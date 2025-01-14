public class SimplifiedCodeUsingLambdaToImplementRunnableAnonymousClass {
    public static void main(String[] args) {
        Runnable numberTask = () -> {
            for (int i = 0; i < 10; i++) {
                System.out.println("int = " + i);
                new counter();
               System.out.println(" Counter after number task: " +  counter.getCounter());
                try {
                    Thread.sleep(20);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        };
        Runnable lettersTask = () -> {
            for(char letters = 'a'; letters <= 'z'; letters++) {
                System.out.println(letters);
                new counter();
                System.out.println(" Counter after letter task: " +  counter.getCounter());

                try {
                    Thread.sleep(20);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        };
        Thread numberThread = new Thread(numberTask);
        Thread lettersThread = new Thread(lettersTask);
        numberThread.start();
        lettersThread.start();
        try {
            numberThread.join();
            lettersThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
// in this program I am using Lambda expressions to simplify the codes for printing out the numbers
// and letters in  parallel where I have to use threading to start both tasks at the same time
// here lambda expression helped to create an anonymous class that implements the Runnable interface
// this eliminated the need tpo create tye separate classes for those individula task like the hwy we did it
// by extending the Thread class or implementing the Runnable interface in those classes
