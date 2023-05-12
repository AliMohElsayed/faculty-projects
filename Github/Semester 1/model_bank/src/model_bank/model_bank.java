
package model_bank;
public class model_bank {

public static void main(String[] args) {

Account account1=new Account("sarah",1122);
account1=new CheckingAccount("sarah",1122);
account1=new SavingAccount("sarah",1122);
account1.deposit(30); account1.toString1();
account1.deposit(40); account1.toString1();
account1.deposit(50); account1.toString1();
account1.withdraw(5); account1.toString1();
account1.withdraw(4); account1.toString1();
account1.withdraw(2); account1.toString1();
}}
