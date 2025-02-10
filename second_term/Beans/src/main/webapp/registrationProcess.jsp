<%--
  Created by IntelliJ IDEA.
  User: ihirwe
  Date: 2/10/2025
  Time: 11:53 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page  import ="com.example.beans.StudentBean"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
String studentId = request.getParameter("studentId");
String firstName = request.getParameter("firstName");
String lastName = request.getParameter("lastName");
StudentBean st = new StudentBean();
st.setStudentId(studentId);
st.setFirstName(firstName);
st.setLastName(lastName);
session.setAttribute("Student", st);

%>
<jsp:forward page="display.jsp"></jsp:forward>
</body>
</html>
