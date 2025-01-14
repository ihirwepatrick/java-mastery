
public class LettersTask extends Thread{
    public void run() {
            for(char letter = 'A'; letter <= 'Z'; letter++) {
                System.out.println(letter);
                try {
                    Thread.sleep(10);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
            }

    }
}
