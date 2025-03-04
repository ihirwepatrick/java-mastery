<%--
  Created by IntelliJ IDEA.
  User: ihirwe
  Date: 3/4/2025
  Time: 9:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="projects" method="post">
       <input type="hidden" name="userId" value="USER_ID_HERE" />
    <label for="name">Project Name:</label>
      <input type="text" id="name" name="name" required />
    <label for="description">Description:</label>
     <textarea id="description" name="description" required></textarea>
     <button type="submit">Register Project</button>
    </form>

</body>
</html>
