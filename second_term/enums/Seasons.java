public class Seasons {
    enum Season {
        SPRING("Pleasant"), SUMMER("Summer"), AUTUMN("Autumn");
        private String descriptions;
        Season(String infos) {
            this.descriptions= infos;
        }
        public  String getDescriptions() {
            return descriptions;
        }
    }
    public static void main(String[] args) {
        Season season = Season.SPRING;
        System.out.println(season.getDescriptions());
        System.out.println("Season Descriptions");
        for (Season s : Season.values()) {
            System.out.println(s);
            System.out.println(s.getDescriptions());
        }

    }
}
