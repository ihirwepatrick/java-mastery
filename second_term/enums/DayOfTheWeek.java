import java.util.EnumSet;

enum Day {
    MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY;
    public void WeekOrEnd() {
        switch (this) {
            case SATURDAY:
                System.out.println("It's a weekend, Rotateeeeeee!");
                break;
            case SUNDAY:
                System.out.println("It's a sunday, Rotateeeeeee!");
                break;
            default:
                System.out.println("It's not a weekend, Hustle Hard!");
        }
    }
}

public class DayOfTheWeek {
    public static void main(String[] args) {

        System.out.println("Days of the week:");
        for (Day day : Day.values()) {
            System.out.println(day);
        }
        Day d1 = Day.FRIDAY;
        Day d2 = Day.TUESDAY;
        if(d1.ordinal() < d2.ordinal()) {
            System.out.println(d1 + "Comes before " + d2);
        }
        else if(d1.ordinal() > d2.ordinal()) {
            System.out.println(d1 + "Comes after " + d2);
        }
        else {
            System.out.println(d1 + "Comes before " + d2);
        }




        //using the enumset
        EnumSet<Day> weekdays = EnumSet.range(Day.MONDAY, Day.FRIDAY);
        System.out.println("Weekdays:");
        for (Day day : weekdays) {
            System.out.println(day);
        }
    }

}
