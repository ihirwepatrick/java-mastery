<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="error.jsp" %>
<html>
<head>
    <title>Add Two Numbers</title>
</head>
<body>
<h2>Add Two Numbers</h2>
<form method="post">
    <label for="num1">Number 1:</label>
    <input type="number" id="num1" name="num1" required><br><br>

    <label for="num2">Number 2:</label>
    <input type="number" id="num2" name="num2" required><br><br>

    <input type="submit" value="Calculate Sum">
</form>
${param.num1}
<%
    String num1Str = request.getParameter("num1");
    String num2Str = request.getParameter("num2");
    if (num1Str != null && num2Str != null) {
        try {
            int num1 = Integer.parseInt(num1Str);
            int num2 = Integer.parseInt(num2Str);
            int sum = num1 + num2;
%>
<h3>Result: <%= sum %></h3>
<%
} catch (NumberFormatException e) {
%>
<h3 style="color: red;">Invalid input. Please enter valid numbers.</h3>
<%
        }
    }
%>
</body>
</html>
