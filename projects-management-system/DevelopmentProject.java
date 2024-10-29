import java.util.ArrayList;
import java.util.List;

public class DevelopmentProject implements Project {
    private String projectId;
    private String title;
    private List<Student> students = new ArrayList<>();
    private static final int MAX_STUDENTS = 3;  // Different restriction for Development Project

    public DevelopmentProject(String projectId, String title) {
        this.projectId = projectId;
        this.title = title;
    }

    @Override
    public void displayProjectInfo() {
        System.out.println("Development Project ID: " + projectId);
        System.out.println("Title: " + title);
        System.out.println("Students: ");
        for (Student student : students) {
            student.displayInfo();
        }
    }
    public String getProjectId() {
        return projectId;
    }
    public String getProjectTitle() {
        return title;
    }

    @Override
    public void addStudent(Student student) throws MaxStudentsException {
        if (students.size() >= MAX_STUDENTS) {
            throw new MaxStudentsException("Cannot add more students. Maximum limit reached for development projects.");
        }
        students.add(student);
    }
}
