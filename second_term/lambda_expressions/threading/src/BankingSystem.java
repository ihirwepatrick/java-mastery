import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

class Account {
    private int balance;
    public synchronized void deposit(int amount) {
        balance += amount;
    }
    public synchronized int getBalance() {
        return balance;
    }
}



public class BankingSystem {
    public static void main(String[] args) {
        Account account = new Account();
        Runnable depositor1 = () -> {
            account.deposit(1000);
            System.out.println(account.getBalance());
            try {
                Thread.sleep(20);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        };
        Runnable depositor2 = () -> {
            account.deposit(1000);
            System.out.println(account.getBalance());
            try {
                Thread.sleep(20);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        };
        Runnable depositor3 = () -> {
            account.deposit(1000);
            System.out.println(account.getBalance());
            try {
                Thread.sleep(20);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        };
        ExecutorService executor = Executors.newFixedThreadPool(3);
        executor.execute(depositor1);
        executor.execute(depositor2);
        executor.execute(depositor3);
        executor.shutdown();
    }
}
