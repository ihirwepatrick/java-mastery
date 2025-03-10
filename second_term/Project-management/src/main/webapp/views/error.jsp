<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Signup Error</title>
</head>
<body>
<h2>Error Occurred</h2>
<p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
<a href="<%= request.getContextPath() %>/signup">Back to Signup</a>
</body>
</html>
