<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>

<%
    String language = request.getParameter("lang");
    if (language == null) {
        language = "en";
    }
    Locale locale = new Locale(language);
    ResourceBundle bundle = ResourceBundle.getBundle("message", locale);
%>

<html>
<head>
    <title><%= bundle.getString("signup.title") %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        .signup-container {
            width: 300px;
            background: white;
            padding: 20px;
            margin: auto;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }
        h2 {
            color: #333;
        }
        input, select {
            width: 100%;
            padding: 8px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            background: #007bff;
            color: white;
            padding: 10px;
            border: none;
            width: 100%;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn:hover {
            background: #0056b3;
        }
    </style>
    <script>
        function changeLanguage() {
            var selectedLang = document.getElementById("languageSelect").value;
            window.location.href = "views/signup.jsp?lang=" + selectedLang;
        }
    </script>
</head>
<body>
<div class="signup-container">
    <h2><%= bundle.getString("login.title") %></h2>

    <% if (request.getParameter("error") != null) { %>
    <p style="color:red;">Error: Unable to register user.</p>
    <% } %>

    <form action="<%=request.getContextPath()%>/signup" method="post">
        <label><%= bundle.getString("login.username") %></label>
        <input type="text" name="name" required><br>

        <label><%= bundle.getString("login.email") %></label>
        <input type="email" name="email" required><br>

        <label><%= bundle.getString("login.password") %></label>
        <input type="password" name="password" required><br>

        <input type="submit" class="btn" value="signup">
    </form>

    <p> Login <a href="login.jsp">Go to login</a></p>

    <!-- Language Selection -->
    <label><%= bundle.getString("language.label") %></label>
    <select id="languageSelect" onchange="changeLanguage()">
        <option value="en" <%= language.equals("en") ? "selected" : "" %>>English</option>
        <option value="fr" <%= language.equals("fr") ? "selected" : "" %>>Français</option>
    </select>

</div>
</body>
</html>
