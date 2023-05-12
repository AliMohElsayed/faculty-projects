
package data_strucures;
import java.util.*;
public class Data_strucures {
public static void main(String[] args) {
    //creating an array list from students,gpa class,payments class,and
    //each student has 3 classes,one for information,one for anything that has to do with
    //the courses and gpa,one for payments,one for current,finished courses
    //each type of a class has his own arraylist 
    //each array list is arranged with respect to the student's order 
    //ex : s1's "first student" is the first element in the s arraylist, in contrast he has his 
    //own payment class "p1" which is the first element in the p arraylist
    //the same thing for his g1,c1.
ArrayList<Students> s =new ArrayList(3);
ArrayList<Courses_GPA> g=new ArrayList(3);
ArrayList<StudentPayments> p =new ArrayList(3);
ArrayList<css> c =new ArrayList(3);
Courses_GPA g1=new Courses_GPA();
Courses_GPA g2=new Courses_GPA();
Courses_GPA g3=new Courses_GPA();
Students s1=new Students();
Students s2=new Students();
Students s3=new Students();
s1.gender();
//StudentPayments p1 = new StudentPayments();
//StudentPayments p2 = new StudentPayments();
//StudentPayments p3 = new StudentPayments();
//css c1=new css();
//css c2=new css();
//css c3=new css();
//s.add(s1);
//g.add(g1);
//p.add(p1);
//c.add(c1);
//s.add(s2);
//g.add(g2);
//p.add(p2);
//c.add(c2);
//s.add(s3);
//g.add(g3);
//p.add(p3);
//c.add(c3);
////running a for loop that contains the all methods,classes for each student with respect to the student's order.
//for(int i =0;i<s.size();i++){
//s.get(i).name();
//s.get(i).getPhone();
//s.get(i).nationality();
//s.get(i).gender();
//s.get(i).Studentcontact();
//s.get(i).getBirth();
//s.get(i).Address();
//s.get(i).generate_id();
//s.get(i).print_Details();
//g.get(i).getsubjects();
//g.get(i).getGrades();
//g.get(i).getHours();
//g.get(i).calc_gpa();
//p.get(i).Payments();
//c.get(i).calc();
//}
}
}