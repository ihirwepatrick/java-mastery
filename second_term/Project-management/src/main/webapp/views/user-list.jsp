<%@ page import="com.example.projectmanagement.model.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User List</title>
</head>
<body>
<h2>Users</h2>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
    </tr>
    <%
        List<User> users = (List<User>) request.getAttribute("users");
        for (User user : users) {
    %>
    <tr>
        <td><%= user.getId() %></td>
        <td><%= user.getName() %></td>
        <td><%= user.getEmail() %></td>
    </tr>
    <% } %>
</table>
<a href="views/add-user.jsp">Add User</a>
</body>
</html>
