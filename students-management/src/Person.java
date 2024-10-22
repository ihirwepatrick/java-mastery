public class Person {
    private String name;
    private int age;
    private String gender;
    private String address;
    private int id;
    public Person (String name, int age, String gender, String address, int id) {
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.address = address;
        this.id = id;
    }
    public int getAge() {
        return age;
    }
    public int getId() {
        return id;
    }
    public String getName() {
        return name;
    }
    public String getAddress() {
        return address;
    }
    public String getGender() {
        return gender;
    }
}
