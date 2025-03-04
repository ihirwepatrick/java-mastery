<%--
  Created by IntelliJ IDEA.
  User: ihirwe
  Date: 3/4/2025
  Time: 9:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ page import="java.util.List" %>
<%@ page import="com.example.projectmanagement.model.Project" %>
<h2>Your Projects</h2>
<ul>
    <% List<Project> projects = (List<Project>) request.getAttribute("projects");
    for (Project project : projects) { %>
         <li><strong><%= project.getName() %></strong>: <%= project.getDescription() %></li>
    <% } %>
    </ul>
</body>
</html>
