import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ProjectManager projectManager = new ProjectManager();

        // Creating projects
        System.out.print("Enter project type (Research/Development): ");
        String projectType = scanner.nextLine();
        System.out.print("Enter project ID: ");
        String projectId = scanner.nextLine();
        System.out.print("Enter project name: ");
        String projectName = scanner.nextLine();

        Project project;
        if (projectType.equalsIgnoreCase("Research")) {
            project = new ResearchProject(projectId, projectName);
        } else {
            project = new DevelopmentProject(projectId, projectName);
        }
        projectManager.addProject(project);

        // Creating students
        for (int i = 1; i <= 3; i++) {
            System.out.print("Enter student ID for student " + i + ": ");
            String studentId = scanner.nextLine();
            System.out.print("Enter student name for student " + i + ": ");
            String studentName = scanner.nextLine();
            Student student = new Student(studentId, studentName);
            projectManager.addStudentToProject(projectId, student);
        }

        // Attempt to add more than the allowed number of students for a development project
        if (project instanceof DevelopmentProject) {
            for (int i = 4; i <= 5; i++) {
                System.out.print("Enter student ID for additional student " + i + ": ");
                String studentId = scanner.nextLine();
                System.out.print("Enter student name for additional student " + i + ": ");
                String studentName = scanner.nextLine();
                Student student = new Student(studentId, studentName);
                try {
                    projectManager.addStudentToProject(projectId, student);
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
        }

        // Display all projects
        projectManager.showAllProjects();
        scanner.close();
    }
}
