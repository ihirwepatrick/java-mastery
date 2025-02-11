<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.example.usebeans.StudentBean" %>

<%
    // Retrieve form data
    String studentId = request.getParameter("studentId");
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");

    if (studentId != null && firstName != null && lastName != null) {
        // Create a new student object
        StudentBean student = new StudentBean();
        student.setStudentId(studentId);
        student.setFirstName(firstName);
        student.setLastName(lastName);

        // Retrieve or create the student map in session
        HashMap<String, StudentBean> studentMap = (HashMap<String, StudentBean>) session.getAttribute("studentMap");
        if (studentMap == null) {
            studentMap = new HashMap<>();
        }

        // Add student to the map
        studentMap.put(studentId, student);

        // Store updated map in session
        session.setAttribute("studentMap", studentMap);
    }

    // Redirect to display page
    response.sendRedirect("display.jsp");
%>
