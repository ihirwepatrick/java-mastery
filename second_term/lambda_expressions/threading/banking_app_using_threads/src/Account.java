public class Account {
    private static double balance;
    public synchronized void deposit(double amount) {
        this.balance += amount;
    }
    public synchronized void withdraw(double amount) {
        this.balance -= amount;
    }
    public synchronized double getBalance() {
        return this.balance;
    }
}
