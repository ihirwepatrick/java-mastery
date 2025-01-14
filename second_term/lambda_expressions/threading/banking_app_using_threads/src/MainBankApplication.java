public class MainBankApplication {
    public static void main(String[] args) {
    Runnable user1 = () -> {
        new Account().deposit(85000);
        try {
            Thread.sleep(20);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    };
        Runnable user2 = () -> {
            new Account().withdraw(5000);
            try {
                Thread.sleep(20);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        };
        Runnable user3 = () -> {
            new Account().withdraw(5000);
            try {
                Thread.sleep(20);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        };
        Thread t1 = new Thread(user1);
        Thread t2 = new Thread(user2);
        Thread t3 = new Thread(user3);
        t1.start();
        t2.start();
        t3.start();
        try {
            t1.join();
            t2.join();
            t3.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("The Balance = " + new Account().getBalance());
    }
    }
