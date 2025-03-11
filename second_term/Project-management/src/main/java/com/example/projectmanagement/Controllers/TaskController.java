package com.example.projectmanagement.Controllers;

import com.example.projectmanagement.model.ProjectDAO;
import com.example.projectmanagement.model.TaskDAO;
import com.example.projectmanagement.model.Project;
import com.example.projectmanagement.model.Task;
import com.example.projectmanagement.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "TaskController", urlPatterns = {"/tasks", "/tasks/*"})
public class TaskController extends HttpServlet {
    private TaskDAO taskDAO;
    private ProjectDAO projectDAO;

    @Override
    public void init() {
        taskDAO = new TaskDAO();
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
        String action = request.getServletPath();
        String pathInfo = request.getPathInfo();

        try {
            // Get user ID from session
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Load projects for task forms
            List<Project> projects = projectDAO.getUserProjects(userId);
            session.setAttribute("projects", projects);

            if (pathInfo == null) {
                // Default action: list all tasks
                listTasks(request, response);
            } else if (pathInfo.equals("/add")) {
                // Show add task form
                showAddTaskForm(request, response);
            } else if (pathInfo.equals("/edit")) {
                // Show edit task form
                showEditTaskForm(request, response);
            } else if (pathInfo.equals("/delete")) {
                // Delete task
                deleteTask(request, response);
            } else if (pathInfo.equals("/updateStatus")) {
                // Update task status
                updateTaskStatus(request, response);
            } else {
                // Default to task list
                listTasks(request, response);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        String pathInfo = request.getPathInfo();

        try {
            // Get user ID from session
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            if (pathInfo == null) {
                // Default action: list all tasks
                listTasks(request, response);
            } else if (pathInfo.equals("/add")) {
                // Add new task
                addTask(request, response);
            } else if (pathInfo.equals("/update")) {
                // Update existing task
                updateTask(request, response);
            } else if (pathInfo.equals("/updateStatus")) {
                // Update task status
                updateTaskStatus(request, response);
            } else {
                // Default to task list
                listTasks(request, response);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listTasks(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        List<Task> tasks = taskDAO.getTasksByUserId(userId);
        session.setAttribute("tasks", tasks);

        request.getRequestDispatcher("/views/tasks.jsp").forward(request, response);
    }

    private void showAddTaskForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/add-task").forward(request, response);
    }

    private void showEditTaskForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Task task = taskDAO.getTaskById(id);

        if (task != null) {
            request.setAttribute("task", task);
            request.getRequestDispatcher("/edit-task").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/tasks");
        }
    }

    private void addTask(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        String name = request.getParameter("name");
        String description = request.getParameter("description");

        int projectId = 0;
        String projectIdParam = request.getParameter("projectId");
        if (projectIdParam != null && !projectIdParam.isEmpty()) {
            projectId = Integer.parseInt(projectIdParam);
        }

        String status = request.getParameter("status");
        String priority = request.getParameter("priority");

        Date dueDate = null;
        String dueDateParam = request.getParameter("dueDate");
        if (dueDateParam != null && !dueDateParam.isEmpty()) {
            try {
                dueDate = new SimpleDateFormat("yyyy-MM-dd").parse(dueDateParam);
            } catch (ParseException e) {
                // Handle date parsing error
                request.setAttribute("errorMessage", "Invalid date format");
                request.getRequestDispatcher("/add-task").forward(request, response);
                return;
            }
        }

        Task task = new Task(name, description, projectId, status, priority, dueDate, userId, userId);

        int taskId = taskDAO.createTask(task);

        if (taskId > 0) {
            // Refresh tasks list in session
            List<Task> tasks = taskDAO.getTasksByUserId(userId);
            session.setAttribute("tasks", tasks);

            response.sendRedirect(request.getContextPath() + "/tasks");
        } else {
            request.setAttribute("errorMessage", "Failed to create task");
            request.getRequestDispatcher("/add-task").forward(request, response);
        }
    }

    private void updateTask(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        int projectId = 0;
        String projectIdParam = request.getParameter("projectId");
        if (projectIdParam != null && !projectIdParam.isEmpty()) {
            projectId = Integer.parseInt(projectIdParam);
        }

        String status = request.getParameter("status");
        String priority = request.getParameter("priority");

        Date dueDate = null;
        String dueDateParam = request.getParameter("dueDate");
        if (dueDateParam != null && !dueDateParam.isEmpty()) {
            try {
                dueDate = new SimpleDateFormat("yyyy-MM-dd").parse(dueDateParam);
            } catch (ParseException e) {
                // Handle date parsing error
                request.setAttribute("errorMessage", "Invalid date format");
                Task task = taskDAO.getTaskById(id);
                request.setAttribute("task", task);
                request.getRequestDispatcher("/edit-task").forward(request, response);
                return;
            }
        }

        Task task = taskDAO.getTaskById(id);

        if (task != null) {
            task.setName(name);
            task.setDescription(description);
            task.setProjectId(projectId);
            task.setStatus(status);
            task.setPriority(priority);
            task.setDueDate(dueDate);
            task.setLastUpdated(new Date());

            boolean success = taskDAO.updateTask(task);

            if (success) {
                // Refresh tasks list in session
                List<Task> tasks = taskDAO.getTasksByUserId(userId);
                session.setAttribute("tasks", tasks);

                response.sendRedirect(request.getContextPath() + "/tasks");
            } else {
                request.setAttribute("errorMessage", "Failed to update task");
                request.setAttribute("task", task);
                request.getRequestDispatcher("/edit-task").forward(request, response);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/tasks");
        }
    }

    private void updateTaskStatus(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        boolean success = taskDAO.updateTaskStatus(id, status);

        if (success) {
            // Refresh tasks list in session
            List<Task> tasks = taskDAO.getTasksByUserId(userId);
            session.setAttribute("tasks", tasks);
        }

        // For AJAX requests, return a simple response
        response.setContentType("text/plain");
        response.getWriter().write(success ? "success" : "error");
    }

    private void deleteTask(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        int id = Integer.parseInt(request.getParameter("id"));

        boolean success = taskDAO.deleteTask(id);

        if (success) {
            // Refresh tasks list in session
            List<Task> tasks = taskDAO.getTasksByUserId(userId);
            session.setAttribute("tasks", tasks);
        }

        response.sendRedirect(request.getContextPath() + "/tasks");
    }
}