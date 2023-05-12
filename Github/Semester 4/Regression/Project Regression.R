library(XML)
library(RODBC)
library(readxl)
library(jsonlite)
library(haven)
library(feather)
SLR <- function(Data){ 
  # Getting needed Data
  x <- Data$x
  y <- Data$y
  n <- length(x)
  xbar<-mean(x)
  ybar<-mean(y)
  # Calculating Sxx and Sxy and Syy
  Sxx<- sum(x^2) -n*(xbar^2)
  Syy <- sum(y^2) -n*(ybar^2)
  Sxy <- sum(x*y) -n*xbar*ybar
  # Calculating intercept(Beta Node) and Slope(Beta 1)
  Beta_1 <- Sxy / Sxx
  Beta_0 <- ybar - Beta_1*xbar
  # Plotting Data 
  plot(x,y,main = "Fitted Model",
       xlab ="Features",
       ylab="target")
  abline(a=Beta_0,b=Beta_1,col="red",lwd=3)
  #calculating sum squares (regression, error,total)
  SSR <-Beta_1^2*Sxx
  SST <-Syy
  SSE <-SST-SSR
  #calculating coeffecient(correlation, determination)
  Rsquare<-as.numeric(SSR/SST)
  print(paste('dependent variable explained by an independent variable in regression model',Rsquare*100,'%'))
  if(Beta_1<0){
    r<-0-sqrt(Rsquare)
    print(paste("the model has negative correlation about",r))
  }else{
    r<-sqrt(Rsquare)
    print(paste("the model has positive correlation about",r))
  }
  #DEGREE OF FREEDOM 
  DFR=1
  DFE=n-2
  DFT= DFR+DFE
  #calculating Mean sum squares(regression,error)
  MSR<-SSR/DFR
  MSE<-SSE/DFE
  # calculate F0
  F0 <- MSR / MSE
  #anova table
  ANOVA=matrix(c(SSR,SSE,SST,DFR,DFE,DFT,MSR,MSE,"",F0,"",""),ncol=4)
  row.names(ANOVA)=c("Treatment","Error","Total")
  colnames(ANOVA)=c("Sum square","Degree of freedom","Mean sum square","F table")
  ANOVA<- as.table(ANOVA)
  # calculate f_test 
  SL <- as.numeric(readline("Enter significance level : "))
  Fc<- qf(SL, DFR, DFE)
  if (F0 > Fc) {
    print("Reject H0, There's relation between X and Y")
  } else {
    print("dont reject H0, There's no relation")
  }
  #Confidence Interval For B0 
  Confidence_Interval_of_B1 = function(C){
    t = qt(C/2,df=(n-2))
    margin =  t * sqrt(MSE/Sxx)
    lower_bound = Beta_1-margin
    upper_bound = Beta_1+margin
    CI = c(lower_bound,upper_bound)
    return(CI)
  }
  Confidence_Interval_of_B0 = function(C){
    t = qt(C/2,df=(n-2))
    margin =  t * sqrt(MSE*((1/n)+(xbar^2/Sxx)))
    lower_bound = Beta_0-margin
    upper_bound = Beta_0+margin
    CI = c(lower_bound,upper_bound) 
    return(CI)
  }
  B0 = Confidence_Interval_of_B0(SL)
  lower_bound_b0 = B0[2]
  upper_bound_b0 = B0[1]
  B1 = Confidence_Interval_of_B1(SL)
  lower_bound_b1 = B1[2]
  upper_bound_b1 = B1[1]
  Xn = as.numeric(readline("Enter the X for mean response: "))
  RatX=Beta_0+Beta_1*Xn
  t=qt(SL/2, length(x)-2,lower.tail = F)
  CL = as.numeric((1-SL)*100)
  L=RatX-t*sqrt(MSE*(1/length(x)+(Xn-xbar)^2/Sxx))
  U=RatX+t*sqrt(MSE*(1/length(x)+(Xn-xbar)^2/Sxx))
  Xnew = as.numeric(readline("Enter the X for new observation: "))
  RatXnew=Beta_0+Beta_1*Xnew
  t=qt(SL/2, length(x)-2,lower.tail = F)
  CL = as.numeric((1-SL)*100)
  Lnew= RatXnew - t * sqrt(MSE*(1+1/length(x)+(Xnew-xbar)^2/Sxx))
  Unew= RatXnew + t * sqrt(MSE*(1+1/length(x)+(Xnew-xbar)^2/Sxx))
  #Print Functions
  message(cat("Value of Sxx is",Sxx
              ,"\nValue of Syy is",Syy
              ,"\nValue of Sxy is",Sxy
              ,"\nValue of Beta One(slope) is",Beta_1
              ,"\nValue of Beta node(intercept) is",Beta_0
              ,"\nValue of SST =",Syy
              ,"\nValue of SSR =",SSR
              ,"\nValue of SSE =",SSE
              ,'\nTarget explained by an Features in regression model',Rsquare*100,'%'
              ,"\nthe value of r = :",sqrt(Rsquare)
              ,"\n",lower_bound_b0,"<B0<",upper_bound_b0
              ,"\n",lower_bound_b1, "<B1<",upper_bound_b1
              ,"\nConfidence Interval for mean response at confidence level",CL,"%"
              ,"\n[",L, ",",U,"]"
              ,"\nConfidence Interval for new observation at confidence level",CL,"%"
              ,"\n[",Lnew, ",",Unew,"]"))
  ANOVA
}
# MLP NEED FOR UPDATES, DON'T RUN IT !!!!
MLR <- function(Data){
  #_______________________________# Mahmoud & Zyad_______________________________________________#
  my_df <- as.matrix(Data)
  big_x <- cbind(b0=rep(1,length(Data)),my_df)
  x <- big_x[,-ncol(big_x)]
  y <- subset(my_df, select = ncol(my_df))
  xt <- t(x)
  xtx <- xt%*%x
  xtx_inverse <- solve(xtx)
  xty <- xt%*%y
  betas <- xtx_inverse%*%xt%*%y
  betas
  #_______________________________# Mahmoud & Zyad_______________________________________________#
  #_______________________________# Bisho & Hamdy________________________________________________#
  
  # Calculate y bar
  y_bar=mean(y) 
  # length of y
  n<-length(y) 
  # y transpose
  yt<- t(y)  
  # betas transpose
  betas_t<-t(betas) 
  # Calculate betas * (x transpose)
  betas_x_t<-betas_t%*%xt  
  # Calculate SSE
  SSE<- (yt%*%y)-(betas_x_t%*%y) 
  # Calaulate SST
  SST<-(yt%*%y)-n*(y_bar)^2    
  # CAlculate SSR
  SSR=SST-SSE               
  # Calculate R Square
  Rsquare=1-(SSE/SST)   
  #_______________________________# Bisho & Hamdy________________________________________________#
  #_______________________________# Ziad & Ali___________________________________________________#
  #DEGREE OF FREEDOM
  k <- ncol(big_x[, -c(1, ncol(big_x))])
  DFR=k
  p = k+1
  DFE=n-p
  DFT= DFR+DFE
  #calculating Mean sum squares(regression,error)
  MSR<-SSR/DFR
  MSE<-SSE/DFE
  # calculate F0
  F0 <- MSR / MSE
  #anova table
  ANOVA=matrix(c(SSR,SSE,SST,DFR,DFE,DFT,MSR,MSE,"",F0,"",""),ncol=4)
  row.names(ANOVA)=c("Treatment","Error","Total")
  colnames(ANOVA)=c("Sum square","Degree of freedom","Mean sum square","F table")
  ANOVA<- as.table(ANOVA)
  SL <- as.numeric(readline("Enter significance level : "))
  # FTEST
  #######
  #_______________________________# Ziad & Ali___________________________________________________#
  #_______________________________# Gaber & Safy_________________________________________________#
  diagonal_vector = xtx_inverse[row(xtx_inverse)==col(xtx_inverse)]
  diagonal_vector*as.vector(MSE)
  Confidence_Interval_of_B_vector <- function(SL){
    t <- qt(SL/2, df = n - p, lower.tail = FALSE)
    CI <- data.frame(lowers = numeric(length(betas)), uppers = numeric(length(betas)))
    for (beta in 1:length(betas)){
      margin <-  t * sqrt(MSE * diagonal_vector[beta])
      lower_bound <- betas[beta] - margin
      upper_bound <- betas[beta] + margin
      CI[beta,] <- c(lower_bound, upper_bound)
    }
    return(CI)
  }
  Confidence_Interval_of_B_vector(0.05)
  #_______________________________# Gaber & Safy_________________________________________________#
}
path <- noquote(choose.files())
value_of_format <- as.numeric(readline("Which type of Data do you need? : \n1-CSV\n2-Excel\n3-Json\n4-XML\n5-SQL\n6-SAS\n7-SPSS\n8-Feather"))
Data <- switch (value_of_format,
                Data=read.csv(path),
                Data=read_excel(path),
                Data=fromJSON(path),
                Data=xmlTreeParse(file = path),
                Data=sqlQuery(con(odbcConnect(path)),"SELECT * FROM MY TABLE"),
                Data=read_sas(path),
                Data=read_spss(path),
                Data=read_feather(path),
                stop("Invalid input. one of the choices above you"))
value_of_regression <- as.numeric(readline("Which type of method do you need? :\n1-SLR(Simple Linear Regression)\n2-MLR(Multiple Linear Regression)"))
Function <- switch(value_of_regression,
                   SLR = SLR(Data),
                   MLR = MLR(Data),
                   stop("Invalid input. Please enter 1 or 2."))
print(Function)