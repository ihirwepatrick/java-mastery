import java.util.Scanner;

public class ArrayOfInt {
    public static void main(String[] args) {
        int[] array;
        array = new int[5];
        int i = 0;
        for(i=0; i<5; i++) {
            System.out.println("Enter element: "+(i+1));
            Scanner sc = new Scanner(System.in);
            array[i] = sc.nextInt();
        }
        System.out.println("The array is: ");
        for(i=0; i<5; i++) {
            System.out.println(array[i] + " ");
        }
    }
}
