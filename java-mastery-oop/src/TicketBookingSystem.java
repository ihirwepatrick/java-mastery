import java.util.Scanner;

public class TicketBookingSystem {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        try {
            // Prompt the user for age
            System.out.print("Enter your age: ");
            int age = scanner.nextInt();

            // Check age eligibility
            if (age < 18) {
                throw new IllegalArgumentException("You must be at least 18 years old to book a ticket.");
            }

            // Prompt the user for booking time
            System.out.print("Enter the hour for booking (0-23): ");
            int hour = scanner.nextInt();

            // Check working hours (9 AM to 5 PM)
            if (hour < 9 || hour > 17) {
                throw new IllegalArgumentException("Booking is only allowed between 9 AM and 5 PM.");
            }

            // If all inputs are valid
            System.out.println("Booking successful! Thank you for your purchase.");

        } catch (java.util.InputMismatchException e) {
            // Handle non-numeric input
            System.out.println("Error: Invalid input. Please enter numeric values only.");
        } catch (IllegalArgumentException e) {
            // Handle custom illegal argument exceptions
            System.out.println("Error: " + e.getMessage());
        } catch (Exception e) {
            // Handle any other unexpected exceptions
            System.out.println("An unexpected error occurred: " + e.getMessage());
        } finally {
            // Close the scanner
            scanner.close();
        }
    }
}
