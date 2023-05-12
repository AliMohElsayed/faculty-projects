/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data_strucures;

/**
 *
 * @author abdullah hussien
 */
import java.util.Scanner;
import java.util.Date;
public class StudentPayments extends Students {
   
    Scanner in = new Scanner(System.in);
   protected String TypeOfFunding; 
    protected int NumberOfPaymentsDone;
    int TotalAmountPaidSoFar;
    protected Object[] PayDetails = new Object[4];
    int AmountPaid;
    int TransactionNumber;
    String BankOfTransaction;
    Date TransactionDate;

    public StudentPayments() {
    }

    public StudentPayments(String TypeOfFunding, int NumberOfPaymentsDone, int TotalAmountPaidSoFar, int AmountPaid, int TransactionNumber, String BankOfTransaction, Date TransactionDate) {
        this.TypeOfFunding = TypeOfFunding;
        this.NumberOfPaymentsDone = NumberOfPaymentsDone;
        this.TotalAmountPaidSoFar = TotalAmountPaidSoFar;
        this.AmountPaid = AmountPaid;
        this.TransactionNumber = TransactionNumber;
        this.BankOfTransaction = BankOfTransaction;
        this.TransactionDate = TransactionDate;
    }

    public void setIn(Scanner in) {
        this.in = in;
    }

    public void setTypeOfFunding(String TypeOfFunding) {
        this.TypeOfFunding = TypeOfFunding;
    }

    public void setNumberOfPaymentsDone(int NumberOfPaymentsDone) {
        this.NumberOfPaymentsDone = NumberOfPaymentsDone;
    }

    public void setTotalAmountPaidSoFar(int TotalAmountPaidSoFar) {
        this.TotalAmountPaidSoFar = TotalAmountPaidSoFar;
    }

    public void setPayDetails(Object[] PayDetails) {
        this.PayDetails = PayDetails;
    }

    public void setAmountPaid(int AmountPaid) {
        this.AmountPaid = AmountPaid;
    }

    public void setTransactionNumber(int TransactionNumber) {
        this.TransactionNumber = TransactionNumber;
    }

    public void setBankOfTransaction(String BankOfTransaction) {
        this.BankOfTransaction = BankOfTransaction;
    }

    public void setTransactionDate(Date TransactionDate) {
        this.TransactionDate = TransactionDate;
    }

    public Scanner getIn() {
        return in;
    }

    public String getTypeOfFunding() {
        return TypeOfFunding;
    }

    public int getNumberOfPaymentsDone() {
        return NumberOfPaymentsDone;
    }

    public int getTotalAmountPaidSoFar() {
        return TotalAmountPaidSoFar;
    }

    public Object[] getPayDetails() {
        return PayDetails;
    }

    public int getAmountPaid() {
        return AmountPaid;
    }

    public int getTransactionNumber() {
        return TransactionNumber;
    }

    public String getBankOfTransaction() {
        return BankOfTransaction;
    }

    public Date getTransactionDate() {
        return TransactionDate;
    }
    
    public String Payments()
   {
       //getting the type of payment the student used.
   System.out.println("enter Type of funding self-funded or grant-funded");
   this.TypeOfFunding=in.next();
   //getting number of payments
   System.out.println("enter numper of payments done");
    this.NumberOfPaymentsDone=in.nextInt();
    //getting the total coast from the student
    System.out.println("enter Total amount paid so far");
   this.TotalAmountPaidSoFar=in.nextInt();
   //getting how much money did the student pay so far 
    System.out.println("Enter Amount paid");
   this.AmountPaid=in.nextInt();
    System.out.println("Enter Transaction number");
   this.TransactionNumber=in.nextInt();
    System.out.println("Enter Bank Of Transaction");
   this.BankOfTransaction=in.next();
   
   PayDetails[0] = AmountPaid;
   PayDetails[1] = TransactionNumber;
   PayDetails[2] = BankOfTransaction;
   PayDetails[3] = TransactionDate;
   
   return  TypeOfFunding+ NumberOfPaymentsDone+ TotalAmountPaidSoFar+PayDetails;
   
   
   }
}
