interface PrintSum {
    int print(int n1, int n2);
}

public class FunctionalInterfaceForSum {
    public static void main(String[] args) {
      PrintSum p = (n1, n2) -> n1 + n2;
      System.out.println(p.print(1, 2));
    }
}
