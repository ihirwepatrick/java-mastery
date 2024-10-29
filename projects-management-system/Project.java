public interface Project {
    void displayProjectInfo();
    void addStudent(Student student) throws MaxStudentsException;
    String getProjectId();
    abstract String getProjectTitle();
}
