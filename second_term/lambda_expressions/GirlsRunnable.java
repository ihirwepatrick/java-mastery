public class GirlsRunnable implements Runnable {
    public void run() {
        for (int i = 0; i < 15; i++) {
            System.out.println("Girl");
            try {
                Thread.sleep(8);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
