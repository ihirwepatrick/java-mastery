public class Student {
    private String studentId;
    private String name;

    public Student(String studentId, String name) {
        this.studentId = studentId;
        this.name = name;
    }

    public String getStudentId() {
        return studentId;
    }

    public String getName() {
        return name;
    }

    public void displayInfo() {
        System.out.println("Student ID: " + studentId);
        System.out.println("Name: " + name);
    }
}
