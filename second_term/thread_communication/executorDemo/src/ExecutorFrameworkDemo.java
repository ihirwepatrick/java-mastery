import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ExecutorFrameworkDemo {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(5);
        for(int i = 1; i <= 10; i++) {
            executor.execute(new Task(i));
        }
        executor.shutdown();
    }
}






