import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

class BoyA implements Runnable {
    public void run() {
        System.out.println("Boy Thread started");
        for (int i = 1; i < 20; i++) {
            System.out.print("Boy: " + i + " ");
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
        for (int i = 1; i < 20; i++) {
            System.out.print("Girl: " + i + " ");
            try {
                Thread.sleep(10);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("Girl Thread ended");
    }
}

class TeacherA implements Runnable {
    public void run() {
        System.out.println("Teacher Thread started");
        for (int i = 1; i < 20; i++) {
            System.out.print("Teacher: " + i + " ");
            try {
                Thread.sleep(10);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("Teacher Thread ended");
    }
}

public class ThreadPoolExampleUsingExecutorFramework {
    public static void main(String[] args) {
        // Create a fixed thread pool with 2 threads
        ExecutorService executor = Executors.newFixedThreadPool(2);

        // Submit tasks to the pool
        executor.execute(new BoyA());
        executor.execute(new GirlA());
        executor.execute(new TeacherA());

        // Shutdown the executor after tasks are completed
        executor.shutdown();
    }
}
