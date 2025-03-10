<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.projectmanagement.model.Project" %>
<html>
<head>
    <title>User Projects</title>
</head>
<body>
<h1>User Projects</h1>

<!-- Display Existing Projects -->
<h2>Your Projects</h2>
<ul>
    <%
        List<Project> projects = (List<Project>) request.getAttribute("projects");
        if (projects != null && !projects.isEmpty()) {
            for (Project project : projects) {
    %>
    <li>
        <strong><%= project.getName() %></strong>: <%= project.getDescription() %>
    </li>
    <%
        }
    } else {
    %>
    <li>No projects found.</li>
    <%
        }
    %>
</ul>
</body>
</html>
