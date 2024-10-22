import java.util.ArrayList;

public class Inventory {
    final private ArrayList<Item> items;
    public Inventory() {
        items = new ArrayList<>();
    }
    public void addItem(Item item) {
        items.add(item);
    }
    public void displayInventory() {
        for(Item item : items) {
            System.out.println("Item: " + item.getName() + ", Quantity: " + item.getQuantity());
        }
    }
}
