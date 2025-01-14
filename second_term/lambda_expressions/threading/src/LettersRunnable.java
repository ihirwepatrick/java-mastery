public class LettersRunnable implements Runnable {
    public void run() {
        for(char letters = 'a'; letters <= 'z'; letters++) {
            System.out.println(letters);
            try {
                Thread.sleep(20);
            } catch (RuntimeException | InterruptedException e) {
                System.out.println(e);
            }
        }
    }
}
