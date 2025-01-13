enum Season {
    WINTER("Cold"),
    SPRING("Pleasant"),
    SUMMER("Hot"),
    FALL("Cool");

    private final String description;

    // Enum constructor
    Season(String description) {
        this.description = description;
    }

    // Getter method
    public String getDescription() {
        return description;
    }
}

public class Enum{
    public static void main(String[] args) {
        for (SeasonEnum season : SeasonEnum.values()) {
            System.out.println(season + ": " + season.getDescription());
        }
    }
}
