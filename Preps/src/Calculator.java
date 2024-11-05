import java.util.ArrayList;

class Calculator {
    private int value;
    ArrayList<String> list = new ArrayList<String>();

    public ArrayList<String> getList() {
        return list;
    }
    // Constructor
    public Calculator(int value) {
        this.value = value;
    }

    // Method to add a number
    public Calculator add(int number) {
        this.value += number;
        return this; // Returning the current instance
    }

    // Method to subtract a number
    public Calculator subtract(int number) {
        this.value -= number;
        return this; // Returning the current instance
    }

    // Method to display the current value
    public void displayValue() {
        System.out.println("Current value: " + value);
    }
}


class Main {
    public static void main(String[] args) {
        Calculator calc = new Calculator(10);
        ArrayList<String> list = calc.getList();
        // Chaining method calls using 'this'
        calc.add(5).subtract(3).displayValue();
        list.add("Apple");       // Add a single value
        list.add("Banana");      // Add another value
        list.add("Cherry"); // Output: Current value: 12
    }

}
