import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class MainUsingRunnable {
    public static void main(String[] args) {
        LettersRunnable lettersRunnable = new LettersRunnable();
       NumbersRunnable numbersRunnable = new NumbersRunnable();
        ExecutorService executor = Executors.newFixedThreadPool(5);

      executor.execute(lettersRunnable);
      executor.execute(numbersRunnable);
      executor.shutdown();

       // thread safety
//        try {
//            lettersThread.join();
//            numbersThread.join();
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
    }
}
