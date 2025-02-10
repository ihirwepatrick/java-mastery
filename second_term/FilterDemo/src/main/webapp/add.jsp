<%--
  Created by IntelliJ IDEA.
  User: ihirwe
  Date: 2/4/2025
  Time: 11:01 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  int num1 = Integer.parseInt(request.getParameter("num1")) ;
  int num2 = Integer.parseInt(request.getParameter("num2"));
  int sum = num2 + num1;
  out.print("Sum " + sum);
%>
Sum2 : <input name="sum" value="<%= sum %>>">

</body>
</html>
