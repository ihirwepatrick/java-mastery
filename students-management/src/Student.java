public class Student extends Person {
private String specialty;
private String faculty;
private int grade;

public Student(String name, int age, String gender, String address, int id, String specialty, String faculty, int grade) {
        super(name, age, gender, address, id);
        this.specialty = specialty;
        this.faculty = faculty;
        this.grade = grade;
    }

    //getters
    public String getSpecialty() {
    return specialty;
    }
    public void setSpecialty(String specialty) {
        if (specialty != null && !specialty.isEmpty()) {
            this.specialty = specialty;
        } else {
            System.out.println("Specialty cannot be empty.");
        }
    }
    public String getFaculty() {
    return faculty;
    }
    public void setFaculty(String faculty) {
    if (faculty != null && !faculty.isEmpty()) {
        this.faculty = faculty;
    } else {
        System.out.println("Faculty cannot be empty.");
    }
    }
    public int getGrade() {
    return grade;
    }
    public void setGrade(int grade) {
   if (grade >= 0 && grade <= 100) {
       this.grade = grade;
   } else {
       System.out.println("Grade must be between 0 and 100 else the student is supposed to repeat");
   }
    }
    public void displayStudentInfo() {
        System.out.println("Name: " + getName() + "\n"+ "Grade: " + getGrade() + "\n"+ "Faculty: " + getFaculty() + "\n"+ "Specialty: " + getSpecialty());
    }
}
