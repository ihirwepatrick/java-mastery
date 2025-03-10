package com.example.projectmanagement.Controllers;

import com.example.projectmanagement.model.Project;
import com.example.projectmanagement.model.ProjectDAO;
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
import java.util.List;

public class LoginServlet extends HttpServlet {
    private ProjectDAO projectDAO;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to the signup page (signup.jsp or whatever page you use)
        request.getRequestDispatcher("views/login.jsp").forward(request, response);
    }
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
        projectDAO = new ProjectDAO(conn);

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("userId", rs.getInt("id"));
                int userId = (int) session.getAttribute("userId");

                // Store projects in session to persist after redirect
                List<Project> projects = projectDAO.getUserProjects(userId);
                session.setAttribute("projects", projects);

                response.sendRedirect(request.getContextPath() + "/projects/add");
            }
            else {
                response.sendRedirect(request.getContextPath() + "/views/login?error=Invalid Credentials");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
