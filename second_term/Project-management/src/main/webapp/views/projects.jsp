<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    // Use the existing session object instead of creating a new one
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Register Project</title>
</head>
<body>
<h2>Register New Project</h2>
<form action="projects" method="post">
    <label>Project Name:</label> <input type="text" name="name" required><br>
    <label>Description:</label> <textarea name="description" required></textarea><br>
    <input type="submit" value="Register">
</form>
<a href="logout">Logout</a>
</body>
</html>
