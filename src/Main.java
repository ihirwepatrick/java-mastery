// Demonstrating the 4 OOP principles in Java

// 1. Encapsulation
class Vehicle {
    private String brand; // Private fields
    private int speed;

    // Public constructor
    public Vehicle(String brand, int speed) {
        this.brand = brand;
        this.speed = speed;
    }

    // Getter and Setter for brand
    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    // Getter and Setter for speed
    public int getSpeed() {
        return speed;
    }

    public void setSpeed(int speed) {
        this.speed = speed;
    }

    // Method to display vehicle details
    public void displayInfo() {
        System.out.println("Brand: " + brand + ", Speed: " + speed + " km/h");
    }
}

// 2. Inheritance
class Car extends Vehicle {
    private int numberOfDoors;

    // Constructor that calls the parent class constructor
    public Car(String brand, int speed, int numberOfDoors) {
        super(brand, speed);
        this.numberOfDoors = numberOfDoors;
    }

    // Method to display car details
    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("Number of Doors: " + numberOfDoors);
    }
}

// 3. Polymorphism
class SportsCar extends Car {
    private String sportMode;

    // Constructor for the SportsCar class
    public SportsCar(String brand, int speed, int numberOfDoors, String sportMode) {
        super(brand, speed, numberOfDoors);
        this.sportMode = sportMode;
    }

    // Overriding the displayInfo method to show additional info
    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("Sport Mode: " + sportMode);
    }
}

// 4. Abstraction
abstract class Driver {
    protected String name;

    public Driver(String name) {
        this.name = name;
    }

    // Abstract method to be implemented by subclasses
    public abstract void drive();
}

class ProfessionalDriver extends Driver {
    public ProfessionalDriver(String name) {
        super(name);
    }

    // Implementing the abstract method
    @Override
    public void drive() {
        System.out.println(name + " is driving a sports car professionally.");
    }
}

public class OOPPrinciplesDemo {
    public static void main(String[] args) {
        // Encapsulation demonstration
        Vehicle vehicle = new Vehicle("Toyota", 120);
        vehicle.displayInfo();

        // Inheritance demonstration
        Car car = new Car("Honda", 150, 4);
        car.displayInfo();

        // Polymorphism demonstration
        SportsCar sportsCar = new SportsCar("Ferrari", 200, 2, "Enabled");
        sportsCar.displayInfo();

        // Abstraction demonstration
        Driver driver = new ProfessionalDriver("John");
        driver.drive();
    }
}
