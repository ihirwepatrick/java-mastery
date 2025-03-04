class SharedResource {
    private int data;
    private boolean hasData = false;

    public synchronized void produce(int value) {
        while (hasData) { // Wait if data is already produced
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        data = value;
        hasData = true;
        System.out.println("Produced: " + value);
        notify(); // Notify consumer
    }

    public synchronized void consume() {
        while (!hasData) { // Wait if no data is available
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("Consumed: " + data);
        hasData = false;
        notify(); // Notify producer
    }
}

public class Consumer_Producer {
    public static void main(String[] args) {
        SharedResource resource = new SharedResource();

        Thread producer = new Thread(() -> {
            for (int i = 1; i <= 5; i++) {
                resource.produce(i);
            }
        });

        Thread consumer = new Thread(() -> {
            for (int i = 1; i <= 5; i++) {
                resource.consume();
            }
        });

        producer.start();
        consumer.start();
    }
}
