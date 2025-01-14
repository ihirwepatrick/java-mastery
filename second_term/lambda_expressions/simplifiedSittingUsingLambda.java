public class simplifiedSittingUsingLambda {
    public static void main(String[] args) {
        Runnable boystask = () -> {
            for (int i = 0; i < 15; i++) {
                System.out.println("Boy");
                try {
                    Thread.sleep(20);
                    new counter(); // Increment the counter
                    System.out.println("Counter in boys: " + counter.getCounter());
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        };

        Runnable girlstask = () -> {
            for (int i = 0; i < 15; i++) {
                System.out.println("Girl");
                try {
                    Thread.sleep(20);
                    new counter(); // Increment the counter
                    System.out.println("Counter in girls: " + counter.getCounter());
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        };

        Thread boyThread = new Thread(boystask);
        Thread girlThread = new Thread(girlstask);

        boyThread.start();
        girlThread.start();
    }
}
