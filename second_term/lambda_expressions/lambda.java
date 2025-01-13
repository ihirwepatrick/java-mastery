// Functional Interface
@FunctionalInterface
interface Greeting {
    void sayHello(String name);
}

public class lambda {
    public static void main(String[] args) {
        // Using Lambda expression to implememt Greeting interface
        Greeting greeting = (name) -> System.out.println("Hello, " + name + "!");
        greeting.sayHello("Patrick");
    }
}

// here we are using a lambda expression to implement an interface without having to create another class
