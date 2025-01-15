import java.util.LinkedList;

public class Linked {
    public static void main(String[] args) {
        LinkedList<String> districts = new LinkedList<String>();
        districts.add("Nyabihu");
        districts.add("Muhanga");
        for (String district : districts) {
            System.out.println(district);
        }
        districts.addFirst("Rubavu");
        districts.addLast("kayonza");
        System.out.println(districts);
    }

}
