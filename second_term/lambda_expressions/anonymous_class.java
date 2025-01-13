interface Printer {
    void print();
}
public class anonymous_class {
    public static void main(String[] args) {
        Printer printer = new Printer() {
            public void print() {
                System.out.println("Hello World");
            }
        };
        printer.print();
    }
}

// we can implement an interface using anonymous class like above and we can use lambda expressions too
