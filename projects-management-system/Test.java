 class Example {
    public void show(Example obj) {
        System.out.println("Method called with Example instance");
        obj.show(this);
    }

    public void display() {
        show(this); // Passes the current instance to the method
    }
}
public class Test {
    public static void main(String[] args) {
        Example obj = new Example();
        obj.display();
    }
}
