import java.util.concurrent.*;

class callableTaskA implements Callable<String> {
    String message;
    public callableTaskA(String message) {
        this.message = message;
    }
    public String call() throws Exception {
        return message;
    }
}

public class callableTaskDemo {
    public static void main(String[] args) throws ExecutionException, InterruptedException {
        ExecutorService executor = Executors.newFixedThreadPool(5);
        // when u submit a callable task we access it into a future
        // (like a promise that we can get a value from there)
        Future<String> future = executor.submit(new callableTaskA("Hello World"));
        String message = future.get();
        System.out.println("Message:" + message);
        executor.shutdown();
        System.out.println("Done");
    }
}
