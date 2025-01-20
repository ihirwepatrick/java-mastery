class BoyA implements Runnable {
    public void run() {
        System.out.println("Boy Thread started");
        for (int i = 1; i < 100; i++) {
            System.out.println("Boy: " + i);
            try {
                Thread.sleep(10);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

        }
        System.out.println("Boy Thread ended");
    }
}
class GirlA implements Runnable {
    public void run() {
        System.out.println("Girl Thread started");
        for (int i = 1; i < 100; i++) {
            System.out.println("Girl: " + i);
            try {
                Thread.sleep(10);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

        }
        System.out.println("Girl Thread ended");
    }
}





public class ThreadPoolExampleUsingExecutorFramework {
    public static void main(String[] args) {

    }
}
