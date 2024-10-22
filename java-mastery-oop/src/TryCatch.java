import java.util.Scanner;

public class TryCatch {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        try {
            // Prompt the user for input
            System.out.print("Enter the numerator: ");
            double numerator = scanner.nextDouble();

            System.out.print("Enter the denominator: ");
            double denominator = scanner.nextDouble();

            // Perform division
            double result = numerator / denominator;
            if (numerator < denominator) {
                throw new IllegalArgumentException();
            }

            // Display the result
            System.out.println("Result: " + result);
        } catch (ArithmeticException e) {
            // Handle division by zero
            System.out.println("Error: Cannot divide by zero." + e.toString());
        }
        catch (IllegalArgumentException e) {
            System.out.println("Error: Invalid input. Please a must be greater than b." + e.toString());
        }
        finally {
            // Close the scanner
            scanner.close();
        }
    }
}
