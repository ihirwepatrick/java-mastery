public class MainUsingRunnable {
    public static void main(String[] args) {
        LettersRunnable lettersRunnable = new LettersRunnable();
       NumbersRunnable numbersRunnable = new NumbersRunnable();
       Thread lettersThread = new Thread(lettersRunnable);
       Thread numbersThread = new Thread(numbersRunnable);
       lettersThread.start();
       numbersThread.start();
    }
}
