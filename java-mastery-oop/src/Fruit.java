public class Fruit extends Item {
    private String type;
    public Fruit(String name, int quantity, String type) {
        super(name, quantity);
        this.type = type;
    }
    public String getType() {
        return type;
    }
    public String toString() {
        return super.toString() + ", Type: " + type;
    }
}
