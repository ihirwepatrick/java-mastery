import java.util.EnumMap;
import java.util.EnumSet;

// Define an enum for Seasons with fields and methods
enum SeasonEnum {
    SPRING("Warm and blooming"),
    SUMMER("Hot and sunny"),
    AUTUMN("Cool and windy"),
    WINTER("Cold and snowy");

    private final String description;

    // Constructor for the enum
    SeasonEnum(String description) {
        this.description = description;
    }

    // Method to get the description of a season
    public String getDescription() {
        return description;
    }
}

// Define an enum for Days
enum DayOfTheWeekEnum {
    MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY;
}

// Define an enum for Priority with custom ordinal positions
enum Priority {
    HIGH(1), MEDIUM(2), LOW(3);

    private final int rank;

    Priority(int rank) {
        this.rank = rank;
    }

    public int getRank() {
        return rank;
    }
}

public class EnumDemo {
    public static void main(String[] args) {
        // 1. Basic Enum Usage
        System.out.println("Basic Enum Usage:");
        SeasonEnum currentSeason = SeasonEnum.SUMMER;
        System.out.println("Current Season: " + currentSeason);
        System.out.println("Description: " + currentSeason.getDescription());
        System.out.println();

        // 2. Using Enum Methods
        System.out.println("Using Enum Methods:");
        for (SeasonEnum season : SeasonEnum.values()) {
            System.out.println(season + " (ordinal: " + season.ordinal() + ", description: " + season.getDescription() + ")");
        }
        System.out.println();

        // 3. Switch Statement with Enums
        System.out.println("Switch Statement with Enums:");
        Day today = Day.FRIDAY;
        switch (today) {
            case MONDAY -> System.out.println("Start of the workweek!");
            case FRIDAY -> System.out.println("End of the workweek, time to relax!");
            case SATURDAY, SUNDAY -> System.out.println("It's the weekend!");
            default -> System.out.println("Another weekday.");
        }
        System.out.println();

        // 4. EnumSet Example
        System.out.println("Using EnumSet:");
        EnumSet<Day> weekend = EnumSet.of(Day.SATURDAY, Day.SUNDAY);
        EnumSet<Day> weekdays = EnumSet.complementOf(weekend);
        System.out.println("Weekdays: " + weekdays);
        System.out.println("Weekend: " + weekend);
        System.out.println();

        // 5. EnumMap Example
        System.out.println("Using EnumMap:");
        EnumMap<Day, String> schedule = new EnumMap<>(Day.class);
        schedule.put(Day.MONDAY, "Math Class");
        schedule.put(Day.WEDNESDAY, "Science Class");
        schedule.put(Day.FRIDAY, "Sports Day");
        for (Day day : schedule.keySet()) {
            System.out.println(day + ": " + schedule.get(day));
        }
        System.out.println();

        // 6. Accessing Custom Fields in Enums
        System.out.println("Accessing Custom Fields:");
        for (Priority priority : Priority.values()) {
            System.out.println(priority + " (Rank: " + priority.getRank() + ")");
        }
        System.out.println();

        // 7. Comparing Enum Values
        System.out.println("Comparing Enum Values:");
        System.out.println("Does MONDAY come before FRIDAY? " + (Day.MONDAY.compareTo(Day.FRIDAY) < 0));
        System.out.println();

        // 8. Converting Strings to Enum Constants
        System.out.println("Converting Strings to Enum Constants:");
        String dayName = "SUNDAY";
        Day sunday = Day.valueOf(dayName);
        System.out.println("Converted " + dayName + " to enum constant: " + sunday);
    }
}
