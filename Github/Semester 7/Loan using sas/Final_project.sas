/* 1-Import the dataset out loan_data */
PROC IMPORT DATAFILE="/home/u63508066/final_proj/loan_train.csv" 
    out=loan_data
    DBMS=csv
    REPLACE;
RUN;

/* 1-replace_missing_with_mode */
/* %macro replace_missing_with_mode(data=, column=, out_data=); */
/*     Step 1: Calculate the mode for the specified column */
/*     proc sql; */
/*         create table &column._Freq as */
/*         select &column, count(*) as freq */
/*         from &data */
/*         where not missing(&column) /* Exclude missing values */
/*         group by &column */
/*         order by freq desc; /* Sort by descending frequency */
/*     quit; */
/*  */
/*     proc sql noprint; */
/*         select &column */
/*         into :mode_value */
/*         from &column._Freq */
/*         having freq = max(freq); /* Select the &column with the highest frequency */
/*     quit; */
/*  */
/*     Debugging: Verify the resolved mode value for the specified column */
/*     %put Mode Value for &column.: &mode_value.; */
/*  */
/*     Step 2: Replace missing values with the mode for the specified column */
/*     data &out_data; */
/*         set &data; */
/*         if missing(&column) then &column = "&mode_value."; /* Replace missing with the mode */
/*     run; */
/*  */
/*     Step 3: Verify the results */
/*     proc freq data=&out_data; */
/*         tables &column / missing; */
/*     run; */
/* %mend replace_missing_with_mode; */
/*  */
/* Example Usage */
/* %replace_missing_with_mode(data=loan_data, column=Gender, out_data=loan_data_prepared); */
/* %replace_missing_with_mode(data=loan_data, column=Self_Employed, out_data=loan_data_prepared); */
/* %replace_missing_with_mode(data=loan_data, column=Loan_Amount_Term, out_data=loan_data_prepared); */
/* %replace_missing_with_mode(data=loan_data, column=Dependents, out_data=loan_data_prepared); */
/* %replace_missing_with_mode(data=loan_data, column=Credit_History, out_data=loan_data_prepared); */
/*  */
/* 1-replace_missing_with_mean */
/* %macro replace_missing_and_save(data=, numeric_column=, out_data=); */
/*     Step 1: Calculate the mean for the specified numeric column */
/*     proc sql noprint; */
/*         select mean(&numeric_column) into :mean_value */
/*         from &data */
/*         where not missing(&numeric_column); /* Exclude missing values */
/*     quit; */
/*  */
/*     %put Mean Value of &numeric_column: &mean_value.; */
/*  */
/*     Step 2: Create a new dataset with missing values replaced */
/*     data &out_data; */
/*         set &data; */
/*         if missing(&numeric_column) then &numeric_column = &mean_value; /* Replace missing with the mean */
/*     run; */
/*  */
/*     Step 3: Verify the results */
/*     proc means data=&out_data nmiss mean; */
/*         var &numeric_column; */
/*     run; */
/*  */
/*     View the first 10 rows of the new dataset */
/*     proc print data=&out_data (obs=10); */
/*         title "First 10 Observations of Dataset &out_data"; */
/*     run; */
/* %mend replace_missing_and_save; */
/*  */
/* Example Usage */
/* %replace_missing_and_save(data=loan_data, numeric_column=LoanAmount, out_data=loan_data_prepared); */

/* 2-view dataset after fill missing  */
/* View the updated dataset */
/* proc print data=loan_data_prepared (); */
/*     title "the Final Dataset loan_data"; */
/* run; */
/*________________________________________________________________________________________________________  */

/* another way to compute mean and impute missing value  */
	/* for categorical data by mode   */
proc freq  data=loan_data;
/* tables Loan_Amount_Term,Credit_History,Property_Area*/
run;
/* Impute missing values in loan_data to create imputed_data */
data imputed_data;
    set loan_data;
    Gender = COALESCEC(Gender, "Male");
    Married = COALESCEC(Married, "Yes");
    Dependents = COALESCEC(Dependents, "0");
    Self_Employed = COALESCEC(Self_Employed, "No");
    Education = COALESCEC(Education, "Graduate");
    Loan_Amount_Term = COALESCE(Loan_Amount_Term, 360);
    Credit_History = COALESCE(Credit_History, 1);
    Property_Area = COALESCEC(Property_Area, "Semiurban");
run;

/* Compute summary statistics for numerical variables */
proc means data=imputed_data mean;
    var LoanAmount ApplicantIncome CoapplicantIncome;
run;

/* Additional imputations for numerical variables */
data imputed_data;
    set imputed_data; /* Use the already imputed dataset */
    LoanAmount = COALESCE(LoanAmount, 145.2771709);
    ApplicantIncome = COALESCE(ApplicantIncome, 5324.75);
    CoapplicantIncome = COALESCE(CoapplicantIncome, 1549.75);
run;

/* to check if there are missing value or no  */
proc freq  data=imputed_data;
run;

/*2-view dataset after fill missing  */
proc print data=imputed_data ();
    title "the Final Dataset imputed_data";
run;

/*________________________________________________________________________________________________________  */


/* 3-Sort the dataset by LoanAmount in descending order */
PROC SORT DATA=imputed_data;
    BY DESCENDING LoanAmount;
RUN;

/* 4-Create a subset of LoanAmount */
DATA high_value_Loan_Amount;
    SET imputed_data;
    WHERE LoanAmount > 200;
RUN;

/* 5-Calculate total and average LoanAmount by Loan_Status */
PROC SQL;
    CREATE TABLE Loan_totals AS
    SELECT Loan_Status, 
           SUM(LoanAmount) AS LoanAmount_Sum, 
           MEAN(LoanAmount) AS LoanAmount_Average
    FROM imputed_data
    GROUP BY Loan_Status;
QUIT;

/* 6-Identify the single Loan_ID with the highest LoanAmount from loan_data_prepared */
PROC SQL;
    SELECT Loan_ID AS Loan_ID, LoanAmount
    FROM imputed_data
    WHERE LoanAmount = (SELECT MAX(LoanAmount) FROM imputed_data);
QUIT;

/* 7- categorized_Aged */
DATA categorized_Aged;
    SET imputed_data; 
    IF Age < 18 THEN Age_Category = 'Child';
    ELSE IF Age < 30 THEN Age_Category = 'Young_Adult';
    ELSE IF Age < 50 THEN Age_Category = 'Adult';
    ELSE IF Age < 70 THEN Age_Category = 'Old';
RUN;

/* Step 4: Remove outliers  */

/* Step 1: Calculate Q1, Q3, and IQR for Numerical Variables */
PROC MEANS DATA=imputed_data NOPRINT Q1 Q3;
    VAR LoanAmount ApplicantIncome CoapplicantIncome;
    OUTPUT OUT=iqr_params
        Q1=Q1_LoanAmount Q1_ApplicantIncome Q1_CoapplicantIncome
        Q3=Q3_LoanAmount Q3_ApplicantIncome Q3_CoapplicantIncome;
RUN;

/* Step 2: Remove Outliers Using IQR Rule */
DATA no_outliers;
    SET imputed_data;
    IF _N_ = 1 THEN SET iqr_params; /* Bring in Q1 and Q3 values */

    /* Calculate IQR and thresholds */
    IQR_LoanAmount = Q3_LoanAmount - Q1_LoanAmount;
    LoanAmount_Low = Q1_LoanAmount - 1.5 * IQR_LoanAmount;
    LoanAmount_High = Q3_LoanAmount + 1.5 * IQR_LoanAmount;

    IQR_ApplicantIncome = Q3_ApplicantIncome - Q1_ApplicantIncome;
    ApplicantIncome_Low = Q1_ApplicantIncome - 1.5 * IQR_ApplicantIncome;
    ApplicantIncome_High = Q3_ApplicantIncome + 1.5 * IQR_ApplicantIncome;

    IQR_CoapplicantIncome = Q3_CoapplicantIncome - Q1_CoapplicantIncome;
    CoapplicantIncome_Low = Q1_CoapplicantIncome - 1.5 * IQR_CoapplicantIncome;
    CoapplicantIncome_High = Q3_CoapplicantIncome + 1.5 * IQR_CoapplicantIncome;

    /* Retain rows without outliers */
    IF LoanAmount >= LoanAmount_Low AND LoanAmount <= LoanAmount_High AND
       ApplicantIncome >= ApplicantIncome_Low AND ApplicantIncome <= ApplicantIncome_High AND
       CoapplicantIncome >= CoapplicantIncome_Low AND CoapplicantIncome <= CoapplicantIncome_High;
RUN;

/* Verify the outlier-free dataset */
PROC MEANS DATA=no_outliers MIN MAX;
    VAR LoanAmount ApplicantIncome CoapplicantIncome;
RUN;

proc print data=no_outliers ();
    title "the Final Dataset no_outliers";
run;

/* Step 5: Min-Max Scaling */
/* Min-Max Scaling for Numerical Variables */
PROC SQL;
    /* Find the min and max values for each variable */
    CREATE TABLE scaling_params AS
    SELECT 
        MIN(LoanAmount) AS min_LoanAmount, MAX(LoanAmount) AS max_LoanAmount,
        MIN(ApplicantIncome) AS min_ApplicantIncome, MAX(ApplicantIncome) AS max_ApplicantIncome,
        MIN(CoapplicantIncome) AS min_CoapplicantIncome, MAX(CoapplicantIncome) AS max_CoapplicantIncome
    FROM no_outliers;
QUIT;

/* Perform Min-Max Scaling */
DATA scaled_data;
    SET no_outliers;
    /* Scaling formula: (value - min) / (max - min) */
    IF _N_ = 1 THEN SET scaling_params; /* Bring in min-max values */
    Scaled_LoanAmount = (LoanAmount - min_LoanAmount) / (max_LoanAmount - min_LoanAmount);
    Scaled_ApplicantIncome = (ApplicantIncome - min_ApplicantIncome) / (max_ApplicantIncome - min_ApplicantIncome);
    Scaled_CoapplicantIncome = (CoapplicantIncome - min_CoapplicantIncome) / (max_CoapplicantIncome - min_CoapplicantIncome);
RUN;

/* Verify the scaled dataset */
PROC MEANS DATA=scaled_data MIN MAX MEAN;
    VAR Scaled_LoanAmount Scaled_ApplicantIncome Scaled_CoapplicantIncome;
RUN;

/* View the first 10 rows of the scaled dataset */
PROC PRINT DATA=scaled_data (OBS=10);
    TITLE "First 10 Observations of Scaled Dataset";
RUN;

/* Step 6: Assign Numeric Labels to Categorical Variables */
DATA label_encoded_data;
    SET scaled_data;
    /* Example: Encoding Gender */
    IF Gender = "Male" THEN Gender_Encoded = 1;
    ELSE IF Gender = "Female" THEN Gender_Encoded = 0;
    
    /* Encoding Married */
    IF Married = "Yes" THEN Married_Encoded = 1;
    ELSE IF Married = "No" THEN Married_Encoded = 0;
    
    /* Encoding Loan_Status */
    IF Loan_Status = "Y" THEN Loan_Status_Encoded = 1;
    ELSE IF Loan_Status = "N" THEN Loan_Status_Encoded = 0;
    
    /* Encoding Self_Employed */
    IF Self_Employed = "Yes" THEN Self_Employed_Encoded = 1;
    ELSE IF Self_Employed = "No" THEN Self_Employed_Encoded = 0;
    
    /* Encoding Education */
    IF Education = "Graduate" THEN Education_Encoded = 1;
    ELSE IF Education = "Not Graduate" THEN Education_Encoded = 0;

    /* Similarly, encode other categorical variables */
    IF Property_Area = "Urban" THEN Property_Area_Encoded = 1;
    ELSE IF Property_Area = "Semiurban" THEN Property_Area_Encoded = 2;
    ELSE IF Property_Area = "Rural" THEN Property_Area_Encoded = 3;
RUN;

/* View Encoded Dataset */
PROC PRINT DATA=label_encoded_data (OBS=10);
    TITLE "Label Encoded Categorical Data";
RUN;

/*Export After Changes*/
PROC EXPORT DATA=label_encoded_data
    OUTFILE="/home/u63508066/final_proj/loan_train_after_changes.xlsx"
    DBMS=xlsx
    REPLACE;
RUN;

/* Split the data into training and testing datasets */
proc surveyselect data=label_encoded_data out=loan_train samprate=0.8 seed=42 outall;
run;
data loan_train_data loan_test_data;
 set loan_train;
 if selected = 1 then output loan_train_data;
 else output loan_test_data;
run;
/* Logistic Regression */
proc logistic data=loan_train_data outmodel=logistic_model;
 class Gender_Encoded Married_Encoded Education_Encoded
 Self_Employed_Encoded Property_Area_Encoded / param=ref;
 model Loan_Status_Encoded(event='1') = Scaled_LoanAmount Scaled_ApplicantIncome
 Scaled_CoapplicantIncome Gender_Encoded Married_Encoded Education_Encoded
 Self_Employed_Encoded Property_Area_Encoded;
run;
/* Scoring the test data */
proc logistic inmodel=logistic_model;
 score data= loan_test_data out=logistic_predictions;
run;
/* Evaluate model performance */
proc freq data=logistic_predictions;
 tables Loan_Status_Encoded*I_Loan_Status_Encoded / norow nocol nopercent;
run;

/* Decision Tree for Classification */
proc hpsplit data=loan_train_data;
 class Loan_Status_Encoded /* Define the target variable as categorical */
 Gender_Encoded Married_Encoded Education_Encoded
 Self_Employed_Encoded Property_Area_Encoded;
 model Loan_Status_Encoded = Scaled_LoanAmount Scaled_ApplicantIncome
 Scaled_CoapplicantIncome Gender_Encoded Married_Encoded Education_Encoded
 Self_Employed_Encoded Property_Area_Encoded;
 grow entropy; /* Use ENTROPY for classification */
 prune costcomplexity;
 code file='/home/u64078764/excel files/decision_tree_code.sas';
run;
/* Apply the model on test data */
data decision_tree_predictions;
 set loan_test_data;
 %include '/home/u64078764/excel files/decision_tree_code.sas';
run;
/* Print the first few rows to confirm predictions exist */
proc print data=decision_tree_predictions(obs=10);
run;
/* Evaluate model performance */
proc freq data=decision_tree_predictions;
 tables Loan_Status_Encoded*P_Loan_Status_Encoded0*P_Loan_Status_Encoded1 / norow nocol nopercent;
run;

/* Random Forest */
proc hpforest data=loan_test_data maxtrees=100 seed=42;
 target Loan_Status_Encoded / level=binary;
 input ApplicantIncome CoapplicantIncome LoanAmount Loan_Amount_Term Credit_History Age
 Gender_Encoded Married_Encoded Education_Encoded Self_Employed_Encoded Property_Area_Encoded;
 score out=loan_predictions;
run;
/* Step 5: Evaluate the Model */
/* Print Predictions */
proc print data=loan_predictions;
 var Loan_Status_Encoded I_Loan_Status_Encoded P_Loan_Status_Encoded1; /* Actual vs predicted */
run;
/* Step 6: Calculate Residuals */
data loan_predictions_with_residuals;
 set loan_predictions;
 residual = Loan_Status_Encoded - P_Loan_Status_Encoded1;
run;
/* Step 7: Model Performance Metrics */
proc means data=loan_predictions_with_residuals n mean std min max;
 var residual;
run;
/* Step 8: Calculate R-Squared (R²) */
proc reg data=loan_predictions_with_residuals;
 model Loan_Status_Encoded = P_Loan_Status_Encoded1; /* Regression to calculate R² */
run;

/* Linear Regression for Regression Task */
proc reg data=loan_train_data;
 model LoanAmount = Scaled_ApplicantIncome Scaled_CoapplicantIncome
 Gender_Encoded Married_Encoded Education_Encoded
 Self_Employed_Encoded Property_Area_Encoded;
 Property_Area_Encoded;
 output out=predicted_regression_results p=predicted_value r=residual;

run;
/* Evaluate Model: R-squared, RMSE */
proc means data=predicted_regression_results;
 var residual;
run;
proc print data=predicted_regression_results;
 var LoanAmount predicted_value residual;
run;
/* Train a K-Nearest Neighbors (KNN) Model */
proc fastclus data=loan_train_data out=clustered_data maxclusters=2;
 var ApplicantIncome LoanAmount Gender_Encoded Married_Encoded;
run;
/* Step 1: Cluster Summary Statistics */
proc means data=clustered_data n mean std min max;
 class cluster; /* Cluster assignment variable from PROC FASTCLUS */
 var ApplicantIncome LoanAmount Gender_Encoded Married_Encoded;
run;


/* Step 2: Analyze the Distribution of Clusters */
proc freq data=clustered_data;
 tables cluster / nocum nopercent; /* Check the number of observations in each cluster */
run;
/* Step 3: Visualize the Clusters */
proc sgplot data=clustered_data;
 scatter x=ApplicantIncome y=LoanAmount / group=cluster; /* Scatter plot for visual separation */
 title "Cluster Visualization: ApplicantIncome vs LoanAmount";
run;
proc sgplot data=clustered_data;
 scatter x=Gender_Encoded y=Married_Encoded / group=cluster; /* Scatter plot for categorical variables */
 title "Cluster Visualization: Gender_Encoded vs Married_Encoded";
run;
/* Step 4: Evaluate Cluster Separation with FASTCLUS */
proc fastclus data=clustered_data maxclusters=2 out=clustered_data_out;
 var ApplicantIncome LoanAmount Gender_Encoded Married_Encoded; /* Input variables */
run;
/* Cluster Summary to check intra-cluster means and distances */
proc means data=clustered_data_out n mean std min max;
 class cluster; /* Cluster variable */
 var ApplicantIncome LoanAmount Gender_Encoded Married_Encoded;
run;

/* Check the number of observations per cluster */
proc freq data=clustered_data_out;
 tables cluster / nocum nopercent;
run;
/* This will cluster the data into 2 groups based on the provided variables */
