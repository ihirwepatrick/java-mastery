class  CounterA {
    int counter;
    public synchronized void put(int num) {
        System.out.println("Put: "+ num);
        counter = num;
    }
    public synchronized void get() {
        System.out.println("Get: " + counter);
        try {}
    }
}
class PrucerA implements Runnable {
    CounterA counter;
    public PrucerA(CounterA counter) {
        this.counter = counter;
        Thread t = new Thread(this, "Producer");
    }
    public void run() {
        int i = 0;
        while(true) {
            counter.put(i++);
        }
    }
}
class ConsumerA implements Runnable {
    CounterA counter;
    public ConsumerA(CounterA counter) {
        this.counter = counter;
        Thread t = new Thread(this, "Consumer");
        t.start();
    }
    public void run() {
while(true) {
    counter.get();
    try {
        Thread.sleep(1000);
    } catch (RuntimeException | InterruptedException e) {
        throw new RuntimeException(e);
    }
}


    }
}
public class ConsumerProducer{
    public static void main(String[] args) {
        CounterA counter = new CounterA();
        new PrucerA(counter).run();
        new ConsumerA(counter).run();

    }
}