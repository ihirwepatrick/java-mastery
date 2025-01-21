import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

class CallableTask implements Callable<String> {
    private final String message;

    public CallableTask(String message) {
        this.message = message;
    }

    @Override
    public String call() throws Exception {
        // Simulate some work
        Thread.sleep(500); // Optional: Add delay to mimic real-world tasks
        return message;
    }
}

public class callableTaskDemo {
    public static void main(String[] args) throws ExecutionException, InterruptedException {
        // Create a thread pool with 5 threads
        ExecutorService executor = Executors.newFixedThreadPool(5);

        // Create a list of Callable tasks
        List<CallableTask> tasks = new ArrayList<>();
        tasks.add(new CallableTask("Hello World"));
        tasks.add(new CallableTask("Hello Year 2"));
        tasks.add(new CallableTask("Hello Year 3"));
        tasks.add(new CallableTask("Hello Year 1"));

        // Process tasks using invokeAll() (waits for all tasks to complete)
        List<Future<String>> results = executor.invokeAll(tasks);
        for (Future<String> result : results) {
            System.out.println("Result from invokeAll: " + result.get());
        }

        // Process tasks using invokeAny() (returns the first completed task)
        String firstCompleted = executor.invokeAny(tasks);
        System.out.println("First completed result from invokeAny: " + firstCompleted);

        // Submit a single Callable task and get its result via Future
        Future<String> future = executor.submit(new CallableTask("Hello Independent Task"));
        String message = future.get(); // Blocks until the task completes
        System.out.println("Result from submit: " + message);

        // Shutdown the executor
        executor.shutdown();
        System.out.println("All tasks processed. Executor shut down.");
    }
}
