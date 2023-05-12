package model_bank;
public class CheckingAccount extends Account { 
public  CheckingAccount(String name, int id) {super( name,id);}
public  double deposit(double amount) {
if (this.balance+amount>10000) {
System.out.println("'over drawn");
} else 
super.deposit( amount);
return this.balance;
}	
}
