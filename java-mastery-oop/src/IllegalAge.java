// Custom exception class
public class IllegalAge extends IllegalArgumentException {
    public IllegalAge(String message) {
        super(message);
        message = "Illegal age";
    }

}
