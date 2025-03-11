<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.projectmanagement.model.Project" %>
<%@ page import="com.example.projectmanagement.model.Task" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Use the existing session object instead of creating a new one
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath()+ "/login");
        return;
    }

// Get task from request attribute
    Task task = (Task) request.getAttribute("task");
    if (task == null) {
        response.sendRedirect(request.getContextPath() + "/tasks");
        return;
    }

// Get projects for the dropdown
    List<Project> projects = (List<Project>) session.getAttribute("projects");
    boolean hasProjects = (projects != null && !projects.isEmpty());

// Get error message if any
    String errorMessage = (String) request.getAttribute("errorMessage");

// Format date for the input field
    String dueDateStr = "";
    if (task.getDueDate() != null) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        dueDateStr = sdf.format(task.getDueDate());
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Task | TaskFlow</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --primary-light: #eef1ff;
            --secondary: #7209b7;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #38b000;
            --warning: #ffb703;
            --danger: #e63946;
            --info: #00b4d8;
            --gray: #6c757d;
            --gray-light: #e9ecef;
            --gray-dark: #343a40;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--light);
            color: var(--dark);
            line-height: 1.6;
        }

        /* Header Styles */
        header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 20px 0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
        }

        .logo i {
            margin-right: 10px;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .nav-links a:hover {
            color: white;
        }

        .nav-links a.active {
            color: white;
            position: relative;
        }

        .nav-links a.active::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 100%;
            height: 3px;
            background-color: white;
            border-radius: 2px;
        }

        .user-menu {
            position: relative;
        }

        .user-menu-btn {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: white;
            padding: 8px 15px;
            border-radius: 50px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
        }

        .user-menu-btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .user-avatar {
            width: 30px;
            height: 30px;
            background-color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-weight: bold;
        }

        /* Breadcrumbs */
        .breadcrumbs {
            max-width: 1200px;
            margin: 20px auto 0;
            padding: 0 20px;
            color: var(--gray);
            font-size: 14px;
        }

        .breadcrumbs a {
            color: var(--gray);
            text-decoration: none;
        }

        .breadcrumbs a:hover {
            color: var(--primary);
        }

        .breadcrumbs .separator {
            margin: 0 8px;
        }

        .breadcrumbs .current {
            color: var(--dark);
            font-weight: 500;
        }

        /* Page Header */
        .page-header {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .page-title h1 {
            font-size: 28px;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-title p {
            color: var(--gray);
            font-size: 16px;
        }

        /* Main Content */
        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* Card Styles */
        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 25px;
            margin-bottom: 30px;
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--gray-light);
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .form-text {
            display: block;
            margin-top: 5px;
            font-size: 13px;
            color: var(--gray);
        }

        .input-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
        }

        .input-with-icon {
            padding-left: 45px;
        }

        .textarea-icon {
            position: absolute;
            left: 15px;
            top: 15px;
            color: var(--gray);
        }

        /* Form Grid */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        /* Alert Styles */
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .alert-danger {
            background-color: rgba(230, 57, 70, 0.15);
            color: var(--danger);
            border: 1px solid rgba(230, 57, 70, 0.3);
        }

        /* Task Status Badges */
        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 50px;
            font-size: 13px;
            font-weight: 500;
            text-align: center;
            min-width: 100px;
        }

        .status-todo {
            background-color: rgba(0, 180, 216, 0.15);
            color: var(--info);
        }

        .status-in-progress {
            background-color: rgba(255, 183, 3, 0.15);
            color: var(--warning);
        }

        .status-completed {
            background-color: rgba(56, 176, 0, 0.15);
            color: var(--success);
        }

        .status-blocked {
            background-color: rgba(230, 57, 70, 0.15);
            color: var(--danger);
        }

        /* Button Styles */
        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-secondary {
            background-color: var(--gray-light);
            color: var(--dark);
        }

        .btn-secondary:hover {
            background-color: #dde1e6;
            transform: translateY(-2px);
        }

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background-color: #d32f2f;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 30px;
        }

        /* Footer */
        footer {
            background-color: white;
            border-top: 1px solid var(--gray-light);
            padding: 20px 0;
            margin-top: 50px;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .footer-links {
            display: flex;
            gap: 20px;
        }

        .footer-links a {
            color: var(--gray);
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: var(--primary);
        }

        .copyright {
            color: var(--gray);
            font-size: 14px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
                padding: 15px 20px;
            }

            .nav-links {
                width: 100%;
                justify-content: center;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .footer-content {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
<!-- Header with Navigation -->
<header>
    <nav class="navbar">
        <a href="<%=request.getContextPath()%>/dashboard" class="logo">
            <i class="fas fa-tasks"></i> TaskFlow
        </a>
        <div class="nav-links">
            <a href="<%=request.getContextPath()%>/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <a href="<%=request.getContextPath()%>/projects"><i class="fas fa-project-diagram"></i> Projects</a>
            <a href="<%=request.getContextPath()%>/tasks" class="active"><i class="fas fa-clipboard-list"></i> Tasks</a>
            <a href="<%=request.getContextPath()%>/team"><i class="fas fa-users"></i> Team</a>
        </div>
        <div class="user-menu">
            <button class="user-menu-btn">
                <div class="user-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <span>My Account</span>
                <i class="fas fa-chevron-down"></i>
            </button>
        </div>
    </nav>
</header>

<!-- Breadcrumbs -->
<div class="breadcrumbs">
    <a href="<%=request.getContextPath()%>/dashboard">Dashboard</a>
    <span class="separator"><i class="fas fa-chevron-right"></i></span>
    <a href="<%=request.getContextPath()%>/tasks">Tasks</a>
    <span class="separator"><i class="fas fa-chevron-right"></i></span>
    <span class="current">Edit Task</span>
</div>

<!-- Page Header -->
<div class="page-header">
    <div class="page-title">
        <h1><i class="fas fa-edit"></i> Edit Task</h1>
        <p>Update task details and status</p>
    </div>
</div>

<!-- Main Content -->
<div class="container">
    <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
    <div class="alert alert-danger">
        <i class="fas fa-exclamation-circle"></i> <%= errorMessage %>
    </div>
    <% } %>

    <div class="card">
        <form id="editTaskForm" action="<%=request.getContextPath()%>/tasks/update" method="post">
            <input type="hidden" name="id" value="<%= task.getId() %>">

            <div class="form-group">
                <label for="name">Task Name <span style="color: var(--danger);">*</span></label>
                <div class="input-group">
                    <i class="fas fa-clipboard-list input-icon"></i>
                    <input type="text" class="form-control input-with-icon" id="name" name="name" required value="<%= task.getName() %>" placeholder="Enter a descriptive name for your task">
                </div>
            </div>

            <div class="form-group">
                <label for="description">Task Description</label>
                <div class="input-group">
                    <i class="fas fa-align-left textarea-icon"></i>
                    <textarea class="form-control" id="description" name="description" placeholder="Describe the task details and requirements" style="padding-left: 45px;"><%= task.getDescription() != null ? task.getDescription() : "" %></textarea>
                </div>
                <span class="form-text">Provide clear instructions and details about what needs to be done.</span>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="projectId">Project</label>
                    <select class="form-control" id="projectId" name="projectId">
                        <option value="0" <%= task.getProjectId() == 0 ? "selected" : "" %>>No Project</option>
                        <% if (hasProjects) {
                            for (Project project : projects) { %>
                        <option value="<%= project.getId() %>" <%= task.getProjectId() == project.getId() ? "selected" : "" %>><%= project.getName() %></option>
                        <% }
                        } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="dueDate">Due Date</label>
                    <input type="date" class="form-control" id="dueDate" name="dueDate" value="<%= dueDateStr %>">
                    <span class="form-text">When should this task be completed?</span>
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="status">Status <span style="color: var(--danger);">*</span></label>
                    <select class="form-control" id="status" name="status" required>
                        <option value="todo" <%= "todo".equals(task.getStatus()) ? "selected" : "" %>>To Do</option>
                        <option value="in-progress" <%= "in-progress".equals(task.getStatus()) ? "selected" : "" %>>In Progress</option>
                        <option value="completed" <%= "completed".equals(task.getStatus()) ? "selected" : "" %>>Completed</option>
                        <option value="blocked" <%= "blocked".equals(task.getStatus()) ? "selected" : "" %>>Blocked</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="priority">Priority <span style="color: var(--danger);">*</span></label>
                    <select class="form-control" id="priority" name="priority" required>
                        <option value="low" <%= "low".equals(task.getPriority()) ? "selected" : "" %>>Low</option>
                        <option value="medium" <%= "medium".equals(task.getPriority()) ? "selected" : "" %>>Medium</option>
                        <option value="high" <%= "high".equals(task.getPriority()) ? "selected" : "" %>>High</option>
                    </select>
                </div>
            </div>

            <div class="form-actions">
                <a href="<%=request.getContextPath()%>/tasks" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Update Task
                </button>
            </div>
        </form>
    </div>

    <!-- Task Details Card -->
    <div class="card">
        <h3 style="margin-bottom: 15px; font-size: 18px;">Task Information</h3>

        <div style="display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 20px;">
            <div style="flex: 1; min-width: 200px;">
                <p style="color: var(--gray); font-size: 14px; margin-bottom: 5px;">Current Status</p>
                <span class="status-badge status-<%= task.getStatus() %>">
                        <%= task.getStatus().substring(0, 1).toUpperCase() + task.getStatus().substring(1).replace("-", " ") %>
                    </span>
            </div>

            <div style="flex: 1; min-width: 200px;">
                <p style="color: var(--gray); font-size: 14px; margin-bottom: 5px;">Created Date</p>
                <p style="font-weight: 500;">
                    <%= task.getCreatedDate() != null ? new SimpleDateFormat("MMM dd, yyyy").format(task.getCreatedDate()) : "N/A" %>
                </p>
            </div>

            <div style="flex: 1; min-width: 200px;">
                <p style="color: var(--gray); font-size: 14px; margin-bottom: 5px;">Last Updated</p>
                <p style="font-weight: 500;">
                    <%= task.getLastUpdated() != null ? new SimpleDateFormat("MMM dd, yyyy").format(task.getLastUpdated()) : "N/A" %>
                </p>
            </div>

            <% if (task.getCompletedDate() != null) { %>
            <div style="flex: 1; min-width: 200px;">
                <p style="color: var(--gray); font-size: 14px; margin-bottom: 5px;">Completed Date</p>
                <p style="font-weight: 500;">
                    <%= new SimpleDateFormat("MMM dd, yyyy").format(task.getCompletedDate()) %>
                </p>
            </div>
            <% } %>
        </div>

        <div style="display: flex; justify-content: flex-end;">
            <a href="#" onclick="confirmDelete(<%= task.getId() %>)" class="btn btn-danger">
                <i class="fas fa-trash-alt"></i> Delete Task
            </a>
        </div>
    </div>
</div>

<!-- Footer -->
<footer>
    <div class="footer-content">
        <div class="footer-links">
            <a href="<%=request.getContextPath()%>/help">Help</a>
            <a href="<%=request.getContextPath()%>/settings">Settings</a>
            <a href="<%=request.getContextPath()%>/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
        <div class="copyright">
            &copy; <%= new java.util.Date().getYear() + 1900 %> TaskFlow. All rights reserved.
        </div>
    </div>
</footer>

<script>
    // Form validation
    document.getElementById('editTaskForm').addEventListener('submit', function(e) {
        const nameField = document.getElementById('name');

        if (!nameField.value.trim()) {
            e.preventDefault();
            nameField.classList.add('is-invalid');
            nameField.focus();
            alert('Task name is required');
            return false;
        }

        return true;
    });

    // User menu dropdown
    document.querySelector('.user-menu-btn').addEventListener('click', function() {
        // In a real application, this would toggle a dropdown menu
        alert('User menu clicked - Add dropdown functionality here');
    });

    // Delete confirmation
    function confirmDelete(taskId) {
        if (confirm('Are you sure you want to delete this task? This action cannot be undone.')) {
            window.location.href = '<%=request.getContextPath()%>/tasks/delete?id=' + taskId;
        }
    }

    // Status change handler
    document.getElementById('status').addEventListener('change', function() {
        if (this.value === 'completed') {
            if (confirm('Mark this task as completed? This will set the completion date to today.')) {
                // In a real app, you might want to update the UI to show the completion date
            } else {
                // Reset to previous value if user cancels
                this.value = '<%= task.getStatus() %>';
            }
        }
    });
</script>
</body>
</html>