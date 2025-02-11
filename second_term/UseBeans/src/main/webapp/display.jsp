<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.example.usebeans.StudentBean" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<html>
<head>
    <title>Registered Students</title>
</head>
<body>
<h2>Registered Students</h2>

<table border="1">
    <tr>
        <th>Student ID</th>
        <th>First Name</th>
        <th>Last Name</th>
    </tr>

    <%
        HashMap<String, StudentBean> studentMap = (HashMap<String, StudentBean>) session.getAttribute("studentMap");
        if (studentMap != null && !studentMap.isEmpty()) {
            for (StudentBean student : studentMap.values()) {
    %>
    <tr>
        <td><%= student.getStudentId() %></td>
        <td><%= student.getFirstName() %></td>
        <td><%= student.getLastName() %></td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="3">No students registered yet.</td>
    </tr>
    <%
        }
    %>
</table>
<c:forEach items="${studentMap}" var="student">
    ${student.firstname}<br>
    ${student.lastname}<br>
    ${student.studentId}<br></br>
</c:forEach>

<br>
<a href="registration.jsp">Register Another Student</a>
</body>
</html>
