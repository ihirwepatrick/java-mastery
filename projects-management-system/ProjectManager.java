import java.util.ArrayList;
import java.util.List;

public class ProjectManager {
    private List<Project> projects = new ArrayList<>();

    public void addProject(Project project) {
        projects.add(project);
    }

    public void showAllProjects() {
        for (Project project : projects) {
            project.displayProjectInfo();
            System.out.println("-------------");
        }
    }

    public void addStudentToProject(String projectId, Student student) {
        for (Project project : projects) {
            if ((project instanceof ResearchProject && ((ResearchProject) project).getProjectId().equals(projectId)) ||
                    (project instanceof DevelopmentProject && ((DevelopmentProject) project).getProjectId().equals(projectId))) {


                try {
                    project.addStudent(student);
                    System.out.println("Student added successfully!");
                } catch (MaxStudentsException e) {
                    System.out.println("Error: " + e.getMessage());
                }
                return;
            }
        }
        System.out.println("Project not found with ID: " + projectId);
    }
}
