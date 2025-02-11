<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map, com.example.usebeans.StudentBean" %>
<html>
<head>
    <title>Registered Students</title>
</head>
<body>
<h2>Registered Students</h2>

<c:if test="${empty sessionScope.studentMap}">
    <p>No students registered yet.</p>
</c:if>

<c:forEach var="entry" items="${sessionScope.studentMap}">
    <p>
        <strong>Student ID:</strong> ${entry.key} <br>
        <strong>First Name:</strong> ${entry.value.firstName} <br>
        <strong>Last Name:</strong> ${entry.value.lastName} <br>
    <hr>
    </p>
</c:forEach>

<a href="registration.jsp">Register Another Student</a>
</body>
</html>
