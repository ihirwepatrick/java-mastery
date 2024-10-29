public class Main {
    public static void main(String[] args) {
        // Creating a project manager
        ProjectManager projectManager = new ProjectManager();

        // Creating projects
        Project researchProject = new ResearchProject("RP101", "AI Research Project");
        Project developmentProject = new DevelopmentProject("DP202", "Mobile App Development");

        // Adding projects to the manager
        projectManager.addProject(researchProject);
        projectManager.addProject(developmentProject);

        // Creating students
        Student student1 = new Student("S001", "Alice");
        Student student2 = new Student("S002", "Bob");
        Student student3 = new Student("S003", "Charlie");

        // Adding students to projects
        projectManager.addStudentToProject("RP101", student1);
        projectManager.addStudentToProject("RP101", student2);
        projectManager.addStudentToProject("RP101", student3);

        // Attempt to add more than the allowed number of students for a development project
        projectManager.addStudentToProject("DP202", student1);
        projectManager.addStudentToProject("DP202", student2);
        projectManager.addStudentToProject("DP202", student3);
        projectManager.addStudentToProject("DP202", new Student("S004", "Dave"));  // Should trigger exception

        // Display all projects
        projectManager.showAllProjects();
    }
}
