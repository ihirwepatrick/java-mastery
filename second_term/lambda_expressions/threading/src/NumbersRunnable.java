public class NumbersRunnable implements Runnable {
    public void run() {
        for(int i = 1; i <= 10; i++) {
            System.out.println("n = " + i);
            try {
                Thread.sleep(20);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
