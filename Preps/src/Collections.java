import java.util.ArrayList;
import java.util.Collection;

public class Collections {

    public static void main(String[] args) {
     int value;
     value = (int) display(23, 12);
     System.out.println("The returned value is: " + value);
     Object ob = display("Hello", 7);
    }

    public static <U, V> V display(U item, V secondItem) {
        System.out.println(item + ": " + secondItem);
        return secondItem;
    }

}

