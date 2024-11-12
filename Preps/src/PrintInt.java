public class PrintInt<T> {
    T num;
    public PrintInt(T num) {
        this.num = num;
    }
    public void display() {
        System.out.println("The number is num"+ num);
    }
}
