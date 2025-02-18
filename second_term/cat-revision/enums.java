public class enums {
    enum Color {
        RED("#"), BLUE("#blue"), GREEN("#green"), YELLOW("#yellow");
        ;
private String hexCode;
        Color(String hexCode) {
            this.hexCode = hexCode;
        }
        String getHexCode() {
            return hexCode;
        }
    }
    public static void main(String[] args) {
        for(Color c: Color.values()) {
            System.out.println("Color is: "+ c + " " + c.getHexCode());
        }
    }
}
