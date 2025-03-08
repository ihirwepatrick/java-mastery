<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>

<%
    // Get selected language or default to English
    String language = request.getParameter("lang");
    if (language == null) {
        language = "en";
    }
    Locale locale = new Locale(language);
    ResourceBundle bundle = ResourceBundle.getBundle("message", locale);

    // Check if the user is already logged in
    if (session.getAttribute("userId") != null) {
        response.sendRedirect("projects.jsp");
        return;
    }
%>

<html>
<head>
    <title><%= bundle.getString("login.title") %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        .login-container {
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
            background: #28a745;
            color: white;
            padding: 10px;
            border: none;
            width: 100%;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn:hover {
            background: #218838;
        }
    </style>
    <script>
        function changeLanguage() {
            var selectedLang = document.getElementById("languageSelect").value;
            window.location.href = "add-user.jsp?lang=" + selectedLang;
        }
    </script>
</head>
<body>
<div class="login-container">
    <h2><%= bundle.getString("login.title") %></h2>

    <% if (request.getParameter("error") != null) { %>
    <p style="color:red;">Invalid username or password. Please try again.</p>
    <% } %>

    <form action="login" method="post">
        <label><%= bundle.getString("login.username") %></label>
        <input type="text" name="email" required><br>

        <label><%= bundle.getString("login.password") %></label>
        <input type="password" name="password" required><br>

        <input type="submit" class="btn" value="<%= bundle.getString("login.button") %>">
    </form>

    <!-- Language Selection -->
    <label><%= bundle.getString("language.label") %></label>
    <select id="languageSelect" onchange="changeLanguage()">
        <option value="en" <%= language.equals("en") ? "selected" : "" %>>English</option>
        <option value="fr" <%= language.equals("fr") ? "selected" : "" %>>Français</option>
    </select>
</div>
</body>
</html>
