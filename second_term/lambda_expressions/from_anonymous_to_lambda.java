interface Printer1 {
    void print(String name, String classroom);
}

public class from_anonymous_to_lambda {
    public static void main(String[] args) {
        Printer1 p = (name, classroom) -> {System.out.println(name+" studies in "+classroom);};
        p.print("John", "Year 2 A");
    }

}
