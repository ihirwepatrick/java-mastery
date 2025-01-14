public class NumberTask extends Thread {
        public void run() {
            for (int i = 1; i <= 50; i++) {
                System.out.println("n = " + i);
                try {
                    Thread.sleep(10);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }

