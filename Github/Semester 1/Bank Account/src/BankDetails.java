import java.util.Scanner;
public class BankDetails {
    private String account_number;  
    private String name;  
    private String account_type;  
    private long balance;  
    private java.util.Date dateCreated;
public BankDetails(){
dateCreated = new java.util.Date();
}
public String getDateCreated() {
return this.dateCreated.toString();
}
    Scanner sc = new Scanner(System.in);  
    //method to open new account  
    public void openAccount() {  
        System.out.print("Enter Account Number: ");  
        account_number = sc.next();  
        System.out.print("Enter Account type: ");  
        account_type = sc.next();  
        System.out.print("Enter Your Name: ");  
        name = sc.next();  
        System.out.print("Enter Balance: ");  
        balance = sc.nextLong();  
    }  
    //method to display account details 
    public void showAccount() {  
        System.out.println("Name of Account holder: " + name);  
        System.out.println("Account Number.: " + account_number);  
        System.out.println("Account Type: " + account_type);  
        System.out.println("The Balance: " + balance);  
    }  
    //method to deposit money  
    public void deposit() {  
        long amount;  
        System.out.println("Enter the amount you want to deposit: ");  
        amount = sc.nextLong();  
        balance = balance + amount; 
        
    }  
    //method to withdraw money  
    public void withdrawal() {  
        long amount;  
        System.out.println("Enter the amount you want to withdraw: ");  
        amount = sc.nextLong();  
        if (balance >= amount) {  
            balance = balance - amount;  
            System.out.println("The Balance after withdrawal: " + balance);  
        } else {  
            System.out.println("Your Balance is less than " + amount + "\tTransaction failed...!!" );  
        }  
    }  
    //method to search an account number  
    public boolean search(String ac_no) {  
        if (account_number.equals(ac_no)) {  
            showAccount();  
            return (true);  
        }  
        return (false);  
    }  
}  
