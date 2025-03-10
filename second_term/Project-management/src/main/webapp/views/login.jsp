<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>

<%
    String language = request.getParameter("lang");
    if (language == null) {
        language = "en";
    }
    Locale locale = new Locale(language);
    ResourceBundle bundle = ResourceBundle.getBundle("message", locale);

    if (session.getAttribute("userId") != null) {
        response.sendRedirect(request.getContextPath()+"/projects");
        return;
    }
%>

<html>
<head>
    <title><%= bundle.getString("login.title") %></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .login-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            transition: transform 0.3s ease;
        }

        .login-container:hover {
            transform: translateY(-5px);
        }

        h2 {
            color: #333;
            margin-bottom: 24px;
            text-align: center;
            font-weight: 600;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 16px;
            margin-bottom: 24px;
        }

        label {
            color: #555;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 4px;
            display: block;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #4a6cf7;
            box-shadow: 0 0 0 3px rgba(74, 108, 247, 0.15);
            outline: none;
        }

        .btn {
            background-color: #4a6cf7;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 12px 16px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 8px;
        }

        .btn:hover {
            background-color: #3a5ce5;
        }

        .error-message {
            background-color: #fff2f2;
            border-left: 4px solid #ff4d4f;
            color: #cf1322;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 4px;
            font-size: 14px;
        }

        .language-section {
            margin-top: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            padding-top: 16px;
            border-top: 1px solid #eee;
        }

        select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            background-color: white;
            cursor: pointer;
            flex-grow: 1;
        }

        select:focus {
            border-color: #4a6cf7;
            outline: none;
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 24px;
            }
        }
    </style>
    <script>
        function changeLanguage() {
            var selectedLang = document.getElementById("languageSelect").value;
            window.location.href = "<%= request.getContextPath() %>/login?lang=" + selectedLang;
        }
    </script>
</head>
<body>
<div class="login-container">
    <h2><%= bundle.getString("login.title") %></h2>

    <% if (request.getParameter("error") != null) { %>
    <div class="error-message">Invalid username or password. Please try again.</div>
    <% } %>

    <!-- Updated form action -->
    <form action="<%=request.getContextPath()%>/login" method="post">
        <div>
            <label><%= bundle.getString("login.username") %></label>
            <input type="text" name="email" required>
        </div>

        <div>
            <label><%= bundle.getString("login.password") %></label>
            <input type="password" name="password" required>
        </div>

        <input type="submit" class="btn" value="<%= bundle.getString("login.button") %>">
    </form>

    <!-- Language Selection -->
    <div class="language-section">
        <label><%= bundle.getString("language.label") %></label>
        <select id="languageSelect" onchange="changeLanguage()">
            <option value="en" <%= language.equals("en") ? "selected" : "" %>>English</option>
            <option value="fr" <%= language.equals("fr") ? "selected" : "" %>>Français</option>
        </select>
    </div>
</div>
</body>
</html>