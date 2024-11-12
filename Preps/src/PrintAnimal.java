public class PrintAnimal {
    public  void printAnimal(List<? extends Animal> item) {
        for (Animal a : item) {
            System.out.println(a);
        }
    }
}
