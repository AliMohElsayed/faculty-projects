package data_strucures;
import java.util.Scanner;
public class css extends Students {
public void calc() {
    //we wrote down some courses from the faculty and parted them in 8 semesters
      Scanner input = new Scanner(System.in);
        String[] arr1=new String[8];
        arr1[0]="Course1: programing1                                           -credit hours:3";
       arr1[1]="Course2: math0                                                  -credit hours:3";
       arr1[2]="Course3: English Language                                       -credit hours:3";
       arr1[3]="Course4: Discrete Mathematics                                   -credit hours:3";
       arr1[4]="Course5: Database Systems                                       -credit hours:3";
       arr1[5]="Course6: Business Administration                                -credit hours:3";
         String[] arr2=new String[8];
        arr2[0]="Course1: programing2                                           -credit hours:3";
       arr2[1]="Course2: math1                                                  -credit hours:2";
       arr2[2]="Course3: Linear Algebra                                         -credit hours:3";
       arr2[3]="Course4: data scince                                            -credit hours:3";
       arr2[4]="Course5: Probability                                            -credit hours:3";
       arr2[5]="Course6: Digital Signal Processing                              -credit hours:3";
       String[] arr3=new String[8];
       arr3[0]="Course1: Linear and integer programming                         -credit hours:3";
       arr3[1]="Course2: electronics                                            -credit hours:2";
       arr3[2]="Course3: physics                                                -credit hours:3";
       arr3[3]="Course4: data structure                                         -credit hours:3";
       arr3[4]="Course5: Probability 2                                          -credit hours:3";
       arr3[5]="Course6: computer animation                                     -credit hours:3";
       String[] arr4=new String[8];
       arr4[0]="Course1: Structure and organization of computers                -credit hours:3";
       arr4[1]="Course2: Artificial intelligence                                -credit hours:3";
       arr4[2]="Course3: translators                                            -credit hours:3";
       arr4[3]="Course4: Algorithms                                             -credit hours:3";
       arr4[4]="Course5: processor in parallel                                  -credit hours:2";
       arr4[5]="Course6: Logical design                                         -credit hours:3";
        String[] arr5=new String[8];
       arr5[0]="Course1: Computer language concepts                             -credit hours:3";
       arr5[1]="Course2: Operating Systems                                      -credit hours:3";
       arr5[2]="Course3: Human computer communication systems                   -credit hours:3";
       arr5[3]="Course4: Game programming                                       -credit hours:3";
       arr5[4]="Course5: computer networks                                      -credit hours:3";
       arr5[5]="Course6: Virtual Reality                                        -credit hours:2";
       String[] arr6=new String[8];
       arr6[0]="Course1: Human Rights                                           -credit hours:3";
       arr6[1]="Course2: Computer Architecture                                  -credit hours:3";
       arr6[2]="Course3: Professional Ethics                                    -credit hours:3";
       arr6[3]="Course4: Fundamentals of Economics                              -credit hours:2";
       arr6[4]="Course5: Differential Equations                                 -credit hours:3";
       arr6[5]="Course6: Biostatistics                                          -credit hours:3";
        String[] arr7=new String[8];
       arr7[0]="Course1: Fundamentals of Genetics                               -credit hours:3";
       arr7[1]="Course2: Software Engineering 2                                 -credit hours:3";
       arr7[2]="Course3: Elective 1                                             -credit hours:3";
       arr7[3]="Course4: Data Mining                                            -credit hours:3";
       arr7[4]="Course5: Cloud Computing                                        -credit hours:2";
       arr7[5]="Course6: Information Visualization                              -credit hours:3";
        String[] arr8=new String[8];
       arr8[0]="Course1: Capstone Project II                                    -credit hours:3";
       arr8[1]="Course2: Elective 4                                             -credit hours:3";
       arr8[2]="Course3: Medical Image Processing                               -credit hours:3";
       arr8[3]="Course4: Humanities 4                                           -credit hours:2";
       arr8[4]="Course5: Big Data Analytics                                     -credit hours:3";
       arr8[5]="Course6: Technical Writing                                      -credit hours:3";
       //then we asked the user to enter his studying year and term,every 2 numbers he write from 1:4 years 
       //and first or second term leads him to finished and current courses 
       System.out.println("enter your year student");
        int num =input.nextInt();
         
        System.out.println("enter your Semester student");
        int num2=input.nextInt();
       
        
      if(true){  if(num==1 &&num2==1){
           System.out.println("the current courses");
           System.out.println("________________________________________");
          for (int i=0 ;i<6;i++)
           {
              
               System.out.println(arr1[i]);
              
          } System.out.println("total credit hours in the current courses:17");
        }
        
      if (num==1 &&num2==2){
            System.out.println("the finished courses"); 
                       System.out.println("________________________________________");

            for (int i=0 ;i<6;i++)
          {
             System.out.println(arr1[i]);
          } 
             System.out.println("total credit hours in the finished courses:17");
           System.out.println("the current courses");
            
           System.out.println("________________________________________");

            for (int i=0 ;i<6;i++){
             System.out.println(arr2[i]);
            } 
            System.out.println("total credit hours in the current courses:17");
            }
       
      if (num==2 &&num2==1){
           System.out.println("the finished courses");
                      System.out.println("________________________________________");

          for (int i=0 ;i<6;i++)
           {
               System.out.println(arr1[i]);
               System.out.println(arr2[i]);
           } 
           System.out.println("total credit hours in the finished courses:32");
          System.out.println("the current courses");
                     System.out.println("________________________________________");

                       for (int i=0 ;i<6;i++){
                      System.out.println(arr3[i]);
                                             } 
         System.out.println("total credit hours in the current courses:17");
        }
        if (num==2 &&num2==2){
            System.out.println("the finished courses");
                       System.out.println("________________________________________");

           for (int i=0 ;i<6;i++)
           {
               
               System.out.println(arr1[i]);
               System.out.println(arr2[i]);
               System.out.println(arr3[i]);
           } System.out.println("total credit hours in the finished courses:51");
           System.out.println("the current courses");
                      System.out.println("________________________________________");

           for (int i=0 ;i<6;i++){

              System.out.println(arr4[i]);
         }
           System.out.println("total credit hours in the current courses:17");
        }
        if (num==3 &&num2==1){
            System.out.println("the finished courses");
                       System.out.println("________________________________________");

            for (int i=0 ;i<6;i++)
           {
             
               System.out.println(arr1[i]);
               System.out.println(arr2[i]);
               System.out.println(arr3[i]);
               System.out.println(arr4[i]);
           }
            System.out.println("total credit hours in the finished courses:68");
            System.out.println("the current courses");
                       System.out.println("________________________________________");

            for (int i=0 ;i<6;i++)
           {  
           System.out.println(arr5[i]);
               
          } System.out.println("total credit hours in the current courses:17");
        }
        if (num==3 &&num2==2){
            System.out.println("the finished courses");
                       System.out.println("________________________________________");

           for (int i=0 ;i<6;i++)
           {
                
               System.out.println(arr1[i]);
               System.out.println(arr2[i]);
               System.out.println(arr3[i]);
               System.out.println(arr4[i]);
               System.out.println(arr5[i]);
           }
             System.out.println("total credit hours in the finished courses:85"); 
           System.out.println("the current courses");
                      System.out.println("________________________________________");

              for (int i=0 ;i<6;i++)
           {
              System.out.println(arr6[i]);
               
          } System.out.println("total credit hours in the current courses:17");
        }
        if (num==4 &&num2==1){
             System.out.println("the finished courses");
                        System.out.println("________________________________________");

           for (int i=0 ;i<6;i++)
           {
                
               System.out.println(arr1[i]);
               System.out.println(arr2[i]);
               System.out.println(arr3[i]);
               System.out.println(arr4[i]);
               System.out.println(arr5[i]);
               System.out.println(arr6[i]);
           } 
            System.out.println("total credit hours in the finished courses:102"); 
           System.out.println("the current courses");
                      System.out.println("________________________________________");

             for (int i=0 ;i<6;i++)
           {  
               System.out.println(arr7[i]);
               
          } System.out.println("total credit hours in the current courses:17");
        }
        if (num==4 &&num2==2){
            System.out.println("the finished courses");
                       System.out.println("________________________________________");

           for (int i=0 ;i<6;i++)
           {
               
               System.out.println(arr1[i]);
               System.out.println(arr2[i]);
               System.out.println(arr3[i]);
               System.out.println(arr4[i]);
               System.out.println(arr5[i]);
               System.out.println(arr6[i]);
               System.out.println(arr7[i]);
           }
              System.out.println("total credit hours in the finished courses:119");  
           System.out.println("the current courses");
                      System.out.println("________________________________________");

               for (int i=0 ;i<6;i++)
           {
               System.out.println(arr8[i]);
               
          }
            System.out.println("total credit hours in that courses:17");
        }}
        else{System.out.println("You made a mistake, try again later");}
      
      
    }
    
}


