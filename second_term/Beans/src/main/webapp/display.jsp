<%--
  Created by IntelliJ IDEA.
  User: ihirwe
  Date: 2/10/2025
  Time: 12:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.example.beans.*"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
StudentBean st = (StudentBean)session.getAttribute("Student");
out.print(st.getFirstName());
%>
</body>
</html>
