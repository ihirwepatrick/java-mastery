public class Main {
    public static void main(String[] args) {
        Inventory inventory = new Inventory();
        Item item = new Item("Generic item", 20);
        Fruit fruit = new Fruit("Apple", 20, "Fuji");
        Weapon weapon = new Weapon(2, "Mellee", "Sword", 20);
                inventory.addItem(item);
                inventory.addItem(fruit);
                inventory.addItem(weapon);
                inventory.displayInventory();
    } 
}