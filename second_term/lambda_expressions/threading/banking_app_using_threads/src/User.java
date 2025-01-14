public class User {
    public void deposit(double amount) {
        new Account().deposit(amount);
    }
    public void withdraw(double amount) {
        new Account().withdraw(amount);
    }
}
