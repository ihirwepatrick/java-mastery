// Main.java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        try {
            // Prompt the user to enter student details
            System.out.print("Enter student's name: ");
            String name = scanner.nextLine();

            System.out.print("Enter student's age: ");
            int age = scanner.nextInt();
            scanner.nextLine(); // Consume the newline character

            System.out.print("Enter student's gender: ");
            String gender = scanner.nextLine();

            System.out.print("Enter student's address: ");
            String address = scanner.nextLine();

            System.out.print("Enter student's grade level: ");
            int gradeLevel = scanner.nextInt();
            scanner.nextLine(); // Consume the newline character

            System.out.print("Enter student's major: ");
            String major = scanner.nextLine();

            System.out.print("Enter student's school: ");
            String school = scanner.nextLine();

            System.out.print("Enter student's year of study: ");
            int yearOfStudy = scanner.nextInt();

            // Create a Student object with the entered details
            Student student1 = new Student(name, age, gender, address, gradeLevel, major, school, yearOfStudy);

            // Display the student information
            student1.displayStudentInfo();

        } catch (Exception e) {
            System.out.println("Error: Invalid input. Please enter the correct details.");
        } finally {
            // Close the scanner
            scanner.close();
        }
    }
}
