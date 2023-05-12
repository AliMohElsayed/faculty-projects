package model_bank;
import java.util.Scanner;
public class SavingAccount extends Account {
public SavingAccount(String name, int id) {super( name,id);}
public double withdraw(double amount){
if (this.balance-amount>10000) {
System.out.println("'over daft");}
else
super.withdraw(amount);
return this.balance;
}}
