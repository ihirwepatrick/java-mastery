public class Planets {
    public enum PlanetsList {
        EARTH, MERCURY, VENUS, MARS, JUPITER, SATURN, URANUS;
        public void printInfo(){
            switch(this){
                case EARTH:
                    System.out.println("Habitable planet");
                    break;
                default:
                    System.out.println("Not Habitable planet");
            }
        }

    }
    public static void main(String[] args) {
        PlanetsList planet = PlanetsList.EARTH;
        planet.printInfo();
        for(PlanetsList p: PlanetsList.values()) {
            System.out.println(p);
            p.printInfo();
        }
    }
}
