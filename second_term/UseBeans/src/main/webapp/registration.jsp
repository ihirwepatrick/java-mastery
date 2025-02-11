<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student Registration</title>
</head>
<body>
<h2>Student Registration Form</h2>

<form action="registrationProcess.jsp" method="post">
    <table>
        <tr>
            <td>Student ID:</td>
            <td><input type="text" name="studentId" required></td>
        </tr>
        <tr>
            <td>First Name:</td>
            <td><input type="text" name="firstName" required></td>
        </tr>
        <tr>
            <td>Last Name:</td>
            <td><input type="text" name="lastName" required></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="Register Student"></td>
        </tr>
    </table>
</form>

<br>
<a href="display.jsp">View Registered Students</a>
</body>
</html>
