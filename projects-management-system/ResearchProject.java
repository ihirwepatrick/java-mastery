import java.util.ArrayList;
import java.util.List;

public class ResearchProject implements Project {
    private String projectId;
    private String title;
    private List<Student> students = new ArrayList<>();
    private static final int MAX_STUDENTS = 5;  // Restriction on the number of students

    public ResearchProject(String projectId, String title) {
        this.projectId = projectId;
        this.title = title;
    }

    @Override
    public void displayProjectInfo() {
        System.out.println("Research Project ID: " + projectId);
        System.out.println("Title: " + title);
        System.out.println("Students: ");
        for (Student student : students) {
            student.displayInfo();
        }
    }

    @Override
    public void addStudent(Student student) throws MaxStudentsException {
        if (students.size() >= MAX_STUDENTS) {
            throw new MaxStudentsException("Cannot add more students. Maximum limit reached.");
        }
        students.add(student);
    }
    public String getProjectId() {
        return projectId;
    }
    public String getProjectTitle() {
        return title;
    }
}
