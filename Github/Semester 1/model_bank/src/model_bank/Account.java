package model_bank;
import java.util.ArrayList;
import java.util.Date;
import java.util.Scanner;
public class Account { 
ArrayList<Account> transaction=new ArrayList<Account>();
protected String name ;
protected double annual_interest_rate=1.5/100;
protected int id; 
protected double balance,amount;
protected char type;
protected Date date;
protected  int trans;
public Account(){date = new java.util.Date();}
public Account(String name, int id) {
this.name = name;
this.id = id;
this.date= new java.util.Date();
this.balance=5000;
this.annual_interest_rate=1.5;}
Date d=new Date();
public double deposit(double amount) {
Scanner sc=new Scanner (System.in);
this.date = new java.util.Date();
this.amount=amount;
this.type='D';
balance += amount; 
transaction.add(this);
return balance;
}
public double withdraw(double amount){
Scanner sc=new Scanner (System.in);
this.date = new java.util.Date(); 
this.amount=amount;
this.type='W';
if(this.balance>=amount) {this.balance -= amount;}
else System.out.println("you dont have enough money");
transaction.add(this );
return this.balance;
}
public void toString1() {
System.out.println("hello :"+this.name+"\nyour id  ="+this.id
+"\nyour annual interest rate ="+this.annual_interest_rate+"%"
+"\nthe type of transactions = "+this.type
+" ="+this.amount+"EGP"+"\nyour balance ="
+this.balance+"EGP"+"\nlast transaction at :"+this.date+"\t\t\t");
System.out.println("    _________________________________________________________________________________");
}}