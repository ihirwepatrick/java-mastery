package com.example.projectmanagement.Controllers;

import com.example.projectmanagement.utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/views/signup")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password"); // In real-world applications, hash the password

        String query = "INSERT INTO users(name, email, password) VALUES(?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password);
            int result = stmt.executeUpdate();

            if (result > 0) {
                response.sendRedirect("add-user.jsp?success=1");
            } else {
                response.sendRedirect("signup.jsp?error=1");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=1");
        }
    }
}

