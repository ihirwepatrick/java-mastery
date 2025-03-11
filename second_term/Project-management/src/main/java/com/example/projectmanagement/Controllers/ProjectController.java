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

@WebServlet(urlPatterns = {
        "/projects",
        "/projects/new",
        "/projects/add",
        "/projects/view",
        "/projects/edit",
        "/projects/update",
        "/projects/delete"
})
public class ProjectController extends HttpServlet {

    private ProjectDAO projectDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        projectDAO = new ProjectDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        int userId = (int) session.getAttribute("userId");

        switch (path) {
            case "/projects":
                listProjects(request, response, userId);
                break;
            case "/projects/new":
                showNewProjectForm(request, response);
                break;
            case "/projects/view":
                viewProject(request, response);
                break;
            case "/projects/edit":
                showEditProjectForm(request, response);
                break;
            case "/projects/delete":
                deleteProject(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/projects");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        int userId = (int) session.getAttribute("userId");

        switch (path) {
            case "/projects/add":
                addProject(request, response, userId);
                break;
            case "/projects/update":
                updateProject(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/projects");
                break;
        }
    }
    private void listProjects(HttpServletRequest request, HttpServletResponse response, int userId) throws ServletException, IOException {
        List<Project> projects = projectDAO.getUserProjects(userId);
        // Use request.getSession() to get the session object
        HttpSession session = request.getSession();
        session.setAttribute("projects", projects); // Store in session for access in JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/projects.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewProjectForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // This is handled by the modal in projects.jsp, but we could redirect to a separate page if needed
        response.sendRedirect(request.getContextPath() + "/projects");
    }

    private void addProject(HttpServletRequest request, HttpServletResponse response, int userId) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String priority = request.getParameter("priority");

        Project project = new Project();
        project.setUserId(userId);
        project.setName(name);
        project.setDescription(description);
        project.setStatus(status);
        project.setPriority(priority);

        if (projectDAO.addProject(project)) {
            response.sendRedirect(request.getContextPath() + "/projects");
        } else {
            request.setAttribute("errorMessage", "Error adding project");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/projects.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void viewProject(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int projectId = Integer.parseInt(request.getParameter("id"));
        Project project = projectDAO.getProjectById(projectId);

        if (project != null) {
            request.setAttribute("project", project);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/project-details");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/projects");
        }
    }

    private void showEditProjectForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int projectId = Integer.parseInt(request.getParameter("id"));
        Project project = projectDAO.getProjectById(projectId);

        if (project != null) {
            request.setAttribute("project", project);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/edit-project");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/projects");
        }
    }

    private void updateProject(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int projectId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String priority = request.getParameter("priority");

        Project project = new Project();
        project.setId(projectId);
        project.setName(name);
        project.setDescription(description);
        project.setStatus(status);
        project.setPriority(priority);

        if (projectDAO.updateProject(project)) {
            response.sendRedirect(request.getContextPath() + "/projects");
        } else {
            request.setAttribute("errorMessage", "Error updating project");
            request.setAttribute("project", project);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/edit-project");
            dispatcher.forward(request, response);
        }
    }

    private void deleteProject(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int projectId = Integer.parseInt(request.getParameter("id"));

        if (projectDAO.deleteProject(projectId)) {
            response.sendRedirect(request.getContextPath() + "/projects");
        } else {
            request.setAttribute("errorMessage", "Error deleting project");
            response.sendRedirect(request.getContextPath() + "/projects");
        }
    }
}