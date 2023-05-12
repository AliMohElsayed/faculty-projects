/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data_strucures;
import java.util.ArrayList;
import java.util.Scanner;
public class Students   {
    ArrayList<Students> transaction=new ArrayList<Students>();
    ArrayList<String> data=new ArrayList<String>();
        ArrayList<String> lines = new ArrayList<String>();
protected String first;
protected String Last ;
protected String Middle ;
protected String id;
protected String year="2022";
protected String term;
protected String faculty ;
protected String department ;
protected String nationality;
protected String  Flat_number ;
protected String House_number ;
protected String Street_name;
protected String District_name;
protected String City_name;
protected String Governorate_name ;
protected String Country_name;
protected String Postal_code;
protected String gender;
private int Year ;
private int day ;
private int month ;
private int current_age;
protected int college_year ;
protected String college_id ="25";
protected String et="011";
protected String phone_number ;
protected String vn="010";
protected String or="012";
protected String we="015";
protected String home="03";
protected String email;
protected String home_num;
protected String homee="03";
protected String f_home;
protected String final_home;
protected String final_id;
    public Students() {
    }

public String Studentcontact(){
    //getting the email from the student in condition that the string has @ sign,and modifyng phone number by running the getPhone() method 
        Scanner n=new Scanner(System.in);
    System.out.println("Enter your email");
     email=n.next();
    if(email.contains("@")){
     System.out.println("Modify your home Phone Number(Y/N)");
     char j=n.next().charAt(0);
     if(j=='y' || j=='Y'){
    System.out.println("Enter your home phone num");
    System.out.print(homee);
     home_num=n.next();
     if(home_num.length()==7){
     f_home=(homee)+(home_num);
         System.out.println("Your home number is :"+home);
     System.out.println("Modify your home Phone Number(Y/N)");
        char m=n.next().charAt(0); 
      if(m=='y' || j=='Y'){
    System.out.println("Enter your phone num");
     getPhone();
      }
    else {
        System.out.println("Please enter a correct e-mail.");
        Studentcontact();}
}}}
return this.email;}
public String gender(){
    //getting the student's gender
    Scanner input=new Scanner(System.in);
    System.out.println("Press M for Male \n Press N for Female");
            String choice=input.next();
            if(choice=="m")
            this.gender="male";
            else if(choice=="f")
            this.gender="female";
            System.out.println("The gender is :"+gender);
return this.gender;
}
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }
 public int getBirth(){
     //calculating the age of the student by knowing his birthday
     Scanner  input=new Scanner(System.in);
     System.out.println("Please enter year you were born");
     this.Year=input.nextInt();
     if(this.Year>=1980){
          System.out.println("Please enter Month you were born");
this.month=input.nextInt();
if(this.month!=0&&this.month>=1&&this.month<=12){
     System.out.println("Please enter day you were born");
this.day=input.nextInt();
if(this.day>=1&&this.day<=31){
    System.out.println("You were born : \n"+day+"\\"+month+"\\"+Year);}}}
     this.current_age=(2022-this.Year);
     System.out.println("Your age is :"+current_age+"years old");
 return this.month+this.day+this.current_age+this.Year;
 }
    public String Address(){
        //getting some info from the student such as : flat number,house number...etc as shown 
        Scanner input=new Scanner(System.in);
        System.out.println("Enter the flat number :");
        this.Flat_number=input.next();
        System.out.println("Enter the house number ");
    this.House_number=input.next();
            System.out.println("Enter the street name ");
    this.Street_name=input.next();
            System.out.println("Enter the area name  ");
    this.District_name=input.next();
            System.out.println("Enter the city name ");
    this.City_name=input.next();
            System.out.println("Enter Government name ");
    this.Governorate_name=input.next();
            System.out.println("Enter the Country name ");
    this.Country_name=input.next();
            System.out.println("Enter the postal code ");
    this.Postal_code=input.next();
    
    return this.Flat_number+this.House_number+this.Street_name+this.District_name+this.Governorate_name+this.Country_name+this.Postal_code;
    
    
    }
    public String nationality(){
        //getting the student's nationality 
        int choice;
        Scanner input=new Scanner(System.in);
        System.out.println("What is you nationality ?");
        System.out.println("1-Egyptian \n 2-Saudian \n 3-Morocan");
        choice=input.nextInt();
        switch(choice){
            case 1 :
                this.nationality="Egyptian";
                break ;
            case 2 :
                this.nationality="Saudian";
                break ;
            case 3 :
                this.nationality="Morocan";
                break;
            default :
                System.exit(2);}
    return nationality;}
public String name (){
    // getting the student's first,middle,and last name 
Scanner input=new Scanner(System.in);
    System.out.println("Enter first name :");
    this.first=input.nextLine();
    System.out.println("Enter Middle name");
        this.Middle=input.nextLine();
    System.out.println("Enter last name");
        this.Last=input.nextLine();
return this.first+this.Middle+this.Last;
}
public String generate_id(){
    //generating an id for the student that contains : his id in the college,the term he is at,the department 
    //he is at,and calculating them in one string as shown :
   Scanner input=new Scanner (System.in);
   System.out.println("Enter your id");
   this.id=input.next();
   System.out.println("Enter your term");
   this.term=input.next();
   System.out.println("Choose your Department");
   System.out.println("1-General \n 2-Healthcare \n 3-cyber security \n 4-Media \n 5-Buisness");
    int choose=input.nextInt();
    switch (choose){
                 case 1 :
                     this.department ="0100" ;
                     break ;
                 case 2 :
                     this.department ="0125" ;
                     break ;
                 case 3 :
                     this.department="0130" ;
                     break ;
                 case 4 :
                     this.department = "0135" ;
                     break ;
                 case 5 :
                     this.department = "0145" ;
                     break ;
                 default :
                     System.exit(1);}
   final_id=(year+term+college_id+department+id);
   System.out.println("The student id is :"+final_id);
return this.year+this.term+this.college_id+this.department+this.id;}
public String getPhone(){
//getting the phone number of the student by choosing the first 3 digits as shown,then allowing the student to enter the rest 8 
    //digits to calculate them in one string    
Scanner s=new Scanner(System.in);
System.out.println("Please choose  the Company  of your phone number");
System.out.println("1-Vodafone \n 2-Etisalat \n 3-Orange \n 4-We");
int choice=s.nextInt();
switch (choice){
    case 1 :
       System.out.print("010");
        phone_number=s.next();
if (phone_number.length()== 8){
System.out.println("your number is :"+vn+phone_number);
phone_number=(vn)+(phone_number.toString());
}
else{
System.out.println("Something went wrong 404");}
    break ;
    case 2 :
        System.out.print("011");
        phone_number=s.next();
if (phone_number.length()== 8){
System.out.println("your number is :"+et+phone_number);
phone_number=(et)+(phone_number.toString());
}
else{
System.out.println("Something went wrong 404");}
    break ;
    case 3 :
        System.out.print("012");
        phone_number=s.next();
if (phone_number.length()== 8){
System.out.println("your number is :"+or+phone_number);
phone_number=(or)+(phone_number.toString());
}
else{
System.out.println("Something went wrong 404");}
    break ;
    case 4 :
        System.out.print("015");
        phone_number=s.next();
if (phone_number.length()== 8){
System.out.println("your number is :"+we+phone_number);
phone_number=(we)+phone_number.toString();
}
else{
System.out.println("Something went wrong 404");}
    break ;
    default :
        System.out.println("Please choose a right input");
        getPhone();
}
return phone_number;
}
public void print_Details(){
    //printing out all the student's details
    System.out.println("The students derails :");
    System.out.println("First name : "+this.first);
    System.out.println("Middle name : "+this.Middle);
    System.out.println("Last name : "+this.Last);
    System.out.println("Gender : "+this.gender);
    System.out.println("Year : "+this.Year);
    System.out.println("Month : "+this.month);
    System.out.println("Day : "+this.day);
    System.out.println("Gender : "+this.gender);
    System.out.println("Age : "+this.current_age);
    System.out.println("email : "+this.email);
    System.out.println("Flat number name : "+this.Flat_number);
    System.out.println("house number : "+this.House_number);
    System.out.println("Street name : "+this.Street_name);
    System.out.println("Distract name : "+this.District_name);
    System.out.println("City name : "+this.City_name);
    System.out.println("Governorate name : "+this.Governorate_name);
    System.out.println("Country name : "+this.Country_name);
    System.out.println("Postal : "+this.Postal_code);
}
    public ArrayList<Students> getTransaction() {
        return transaction;
    }
    public void setTransaction(ArrayList<Students> transaction) {
        this.transaction = transaction;
    }
    public ArrayList<String> getData() {
        return data;
    }
    public void setData(ArrayList<String> data) {
        this.data = data;
    }
    public String getFirst() {
        return first;
    }
    public void setFirst(String first) {
        this.first = first;
    }
    public String getLast() {
        return Last;
    }
    public void setLast(String Last) {
        this.Last = Last;
    }
    public String getMiddle() {
        return Middle;
    }
    public void setMiddle(String Middle) {
        this.Middle = Middle;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getTerm() {
        return term;
    }
    public void setTerm(String term) {
        this.term = term;
    }
    public String getFaculty() {
        return faculty;
    }
    public void setFaculty(String faculty) {
        this.faculty = faculty;
    }
    public String getDepartment() {
        return department;
    }
    public void setDepartment(String department) {
        this.department = department;
    }
    public String getNationality() {
        return nationality;
    }
    public void setNationality(String nationality) {
        this.nationality = nationality;
    }
    public String getFlat_number() {
        return Flat_number;
    }
    public void setFlat_number(String Flat_number) {
        this.Flat_number = Flat_number;
    }
    public String getHouse_number() {
        return House_number;
    }
    public void setHouse_number(String House_number) {
        this.House_number = House_number;
    }
    public String getStreet_name() {
        return Street_name;
    }
    public void setStreet_name(String Street_name) {
        this.Street_name = Street_name;
    }
    public String getDistrict_name() {
        return District_name;
    }
    public void setDistrict_name(String District_name) {
        this.District_name = District_name;
    }
    public String getCity_name() {
        return City_name;
    }
    public void setCity_name(String City_name) {
        this.City_name = City_name;
    }
    public String getGovernorate_name() {
        return Governorate_name;
    }
    public void setGovernorate_name(String Governorate_name) {
        this.Governorate_name = Governorate_name;
    }
    public String getCountry_name() {
        return Country_name;
    }
    public void setCountry_name(String Country_name) {
        this.Country_name = Country_name;
    }
    public String getPostal_code() {
        return Postal_code;
    }
    public void setPostal_code(String Postal_code) {
        this.Postal_code = Postal_code;
    }
    public int getYear() {
        return Year;
    }
    public void setYear(int Year) {
        this.Year = Year;
    }
    public int getDay() {
        return day;
    }
    public void setDay(int day) {
        this.day = day;
    }
    public int getMonth() {
        return month;
    }
    public void setMonth(int month) {
        this.month = month;
    }
    public int getCurrent_age() {
        return current_age;
    }
    public void setCurrent_age(int current_age) {
        this.current_age = current_age;
    }
    public int getCollege_year() {
        return college_year;
    }
    public void setCollege_year(int college_year) {
        this.college_year = college_year;
    }
    public String getCollege_id() {
        return college_id;
    }
    public void setCollege_id(String college_id) {
        this.college_id = college_id;
    }
    public String getEt() {
        return et;
    }
    public void setEt(String et) {
        this.et = et;
    }
    public String getPhone_number() {
        return phone_number;
    }
    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }}
   
    
    
    
  