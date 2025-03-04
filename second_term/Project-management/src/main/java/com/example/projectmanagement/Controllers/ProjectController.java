package com.example.projectmanagement.Controllers;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.example.projectmanagement.model.Project;
import com.example.projectmanagement.model.ProjectDAO;
import com.example.projectmanagement.utils.DBConnection;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.SQLException;
import java.util.List;

@WebServlet("/views/projects")
public class ProjectController extends HttpServlet {
    private ProjectDAO projectDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = null; // Use existing DB connection
        try {
            conn = DBConnection.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        projectDAO = new ProjectDAO(conn);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("add-user.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (projectDAO.addProject(userId, name, description)) {
            response.sendRedirect("/projects?userId=" + userId);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error adding project");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("add-user.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        List<Project> projects = projectDAO.getUserProjects(userId);
        request.setAttribute("projects", projects);
        RequestDispatcher dispatcher = request.getRequestDispatcher("projects.jsp");
        dispatcher.forward(request, response);
    }
}
