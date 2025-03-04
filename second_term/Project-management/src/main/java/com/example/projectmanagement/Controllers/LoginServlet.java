package com.example.projectmanagement.Controllers;

import com.example.projectmanagement.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/views/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password"); // Assume plaintext for now

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        String query = "SELECT id FROM users WHERE email = ? AND password = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("userId", rs.getInt("id"));
                response.sendRedirect("projects.jsp");
            } else {
                response.sendRedirect("add-user.jsp?error=Invalid Credentials");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
