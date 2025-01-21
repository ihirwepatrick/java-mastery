public class Task implements Runnable {
    int num;

    public Task(int num) {
        this.num = num;
    }

    @Override
    public void run() {
        System.out.println("Task number: "+num+"has started");
        for(int i = num; i < num*100; i++) {
            System.out.print("  "+num);
            try {
                Thread.sleep(10000);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
        System.out.println("Task number: "+num+"has completed");
    }
}
