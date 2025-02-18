interface Math{
    int operation(int a, int b);
        }

public class lambda {
    public static void main(String[] args) {
        Math add = (g, h) -> {return g + h;};
        System.out.println(add.operation(2, 3));
        Math sub = (g, h) -> {return g - h;};
        System.out.println(sub.operation(2, 3));
    }
}
