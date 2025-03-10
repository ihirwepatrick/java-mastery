package com.example.projectmanagement.Controllers;

import com.example.projectmanagement.utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    // Handle GET request to show the signup form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to the signup page (signup.jsp or whatever page you use)
        request.getRequestDispatcher("views/signup.jsp").forward(request, response);
    }

    // Handle POST request to process form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password"); // Hash in real-world apps

        String checkQuery = "SELECT 1 FROM users WHERE email = ?";
        String insertQuery = "INSERT INTO users(name, email, password) VALUES(?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            // Check if email already exists
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setString(1, email);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    // Redirect to error endpoint for existing email
                    response.sendRedirect(request.getContextPath() + "/signup?error=email_exists");
                    return;
                }
            }

            // Insert new user if email does not exist
            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                insertStmt.setString(1, name);
                insertStmt.setString(2, email);
                insertStmt.setString(3, password);
                int result = insertStmt.executeUpdate();

                if (result > 0) {
                    response.sendRedirect(request.getContextPath()+"/login");
                } else {
                    response.sendRedirect("/signup?error=insert_failed");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/signup?error=sql_error");
        }
    }
}
