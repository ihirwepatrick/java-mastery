public class counter {
    private static int counter = 0; // Static to share across threads

    public counter() {
        increment(); // Increment counter in the constructor
    }

    private synchronized void increment() {
        counter++; // Synchronized to ensure thread safety
    }

    public static synchronized int getCounter() {
        return counter; // Return the current counter value
    }
}
