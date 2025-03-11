<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.projectmanagement.model.Task" %>
<%@ page import="com.example.projectmanagement.model.Project" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    // Use the existing session object instead of creating a new one
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath()+ "/login");
        return;
    }

// Get tasks from session (if available)
    List<Task> tasks = (List<Task>) session.getAttribute("tasks");
    boolean hasTasks = (tasks != null && !tasks.isEmpty());

// Get projects for the dropdown
    List<Project> projects = (List<Project>) session.getAttribute("projects");
    boolean hasProjects = (projects != null && !projects.isEmpty());

// Format for dates
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tasks | TaskFlow</title>
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
        }

        .page-title p {
            color: var(--gray);
            font-size: 16px;
        }

        .page-actions {
            display: flex;
            gap: 10px;
        }

        /* Main Content */
        .container {
            max-width: 1200px;
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

        /* Search and Filter Bar */
        .search-filter-bar {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }

        .search-box input {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 1px solid var(--gray-light);
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s;
        }

        .search-box input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
        }

        .filter-options {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .filter-select {
            padding: 10px 15px;
            border: 1px solid var(--gray-light);
            border-radius: 8px;
            background-color: white;
            font-size: 15px;
            min-width: 150px;
            cursor: pointer;
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
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

        /* Task Priority */
        .priority-indicator {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .priority-dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }

        .priority-high {
            background-color: var(--danger);
        }

        .priority-medium {
            background-color: var(--warning);
        }

        .priority-low {
            background-color: var(--success);
        }

        /* Table Styles */
        .tasks-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: 20px;
        }

        .tasks-table th,
        .tasks-table td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid var(--gray-light);
        }

        .tasks-table th {
            background-color: var(--primary-light);
            color: var(--primary-dark);
            font-weight: 600;
            position: relative;
            cursor: pointer;
            white-space: nowrap;
        }

        .tasks-table th:first-child {
            border-top-left-radius: 8px;
        }

        .tasks-table th:last-child {
            border-top-right-radius: 8px;
        }

        .tasks-table th i {
            margin-left: 5px;
            font-size: 12px;
        }

        .tasks-table tbody tr {
            transition: background-color 0.3s;
        }

        .tasks-table tbody tr:hover {
            background-color: rgba(67, 97, 238, 0.05);
        }

        .tasks-table td {
            vertical-align: middle;
        }

        /* Task Checkbox */
        .task-checkbox {
            width: 20px;
            height: 20px;
            border-radius: 4px;
            border: 2px solid var(--gray);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }

        .task-checkbox.completed {
            background-color: var(--success);
            border-color: var(--success);
            color: white;
        }

        /* Table Actions */
        .table-actions {
            display: flex;
            gap: 8px;
            justify-content: flex-end;
        }

        /* Task Cards (for mobile view) */
        .task-cards {
            display: none;
        }

        .task-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .task-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .task-card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .task-card-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .task-card-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .task-card-meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
            color: var(--gray);
        }

        .task-card-description {
            color: var(--gray-dark);
            margin-bottom: 15px;
            font-size: 14px;
        }

        .task-card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid var(--gray-light);
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            gap: 5px;
            margin-top: 30px;
        }

        .pagination-item {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            background-color: white;
            color: var(--dark);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
        }

        .pagination-item:hover {
            background-color: var(--primary-light);
            color: var(--primary);
        }

        .pagination-item.active {
            background-color: var(--primary);
            color: white;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 50px 20px;
        }

        .empty-state-icon {
            font-size: 60px;
            color: var(--gray-light);
            margin-bottom: 20px;
        }

        .empty-state-title {
            font-size: 20px;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 10px;
        }

        .empty-state-description {
            color: var(--gray);
            margin-bottom: 25px;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Modal Styles */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s;
        }

        .modal-overlay.active {
            opacity: 1;
            visibility: visible;
        }

        .modal {
            background-color: white;
            border-radius: 10px;
            width: 90%;
            max-width: 700px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            transform: translateY(-20px);
            transition: transform 0.3s;
        }

        .modal-overlay.active .modal {
            transform: translateY(0);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 25px;
            border-bottom: 1px solid var(--gray-light);
        }

        .modal-title {
            font-size: 20px;
            font-weight: 600;
            color: var(--dark);
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 20px;
            color: var(--gray);
            cursor: pointer;
            transition: color 0.3s;
        }

        .modal-close:hover {
            color: var(--danger);
        }

        .modal-body {
            padding: 25px;
        }

        .modal-footer {
            padding: 15px 25px 25px;
            display: flex;
            justify-content: flex-end;
            gap: 15px;
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

        /* Button Styles */
        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 15px;
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
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 14px;
        }

        .btn-icon {
            width: 36px;
            height: 36px;
            padding: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
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
        @media (max-width: 992px) {
            .tasks-table th,
            .tasks-table td {
                padding: 12px;
            }

            .status-badge {
                min-width: 80px;
            }
        }

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

            .search-filter-bar {
                flex-direction: column;
            }

            .tasks-table {
                display: none;
            }

            .task-cards {
                display: block;
            }

            .footer-content {
                flex-direction: column;
                gap: 15px;
            }

            .modal {
                width: 95%;
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
    <span class="current">Tasks</span>
</div>

<!-- Page Header -->
<div class="page-header">
    <div class="page-title">
        <h1>Tasks</h1>
        <p>Manage and track all your tasks in one place</p>
    </div>
    <div class="page-actions">
        <button class="btn btn-primary" id="openNewTaskModal">
            <i class="fas fa-plus"></i> New Task
        </button>
    </div>
</div>

<!-- Main Content -->
<div class="container">
    <!-- Search and Filter Bar -->
    <div class="search-filter-bar">
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Search tasks..." id="searchInput">
        </div>
        <div class="filter-options">
            <select class="filter-select" id="statusFilter">
                <option value="">All Statuses</option>
                <option value="todo">To Do</option>
                <option value="in-progress">In Progress</option>
                <option value="completed">Completed</option>
                <option value="blocked">Blocked</option>
            </select>
            <select class="filter-select" id="priorityFilter">
                <option value="">All Priorities</option>
                <option value="high">High</option>
                <option value="medium">Medium</option>
                <option value="low">Low</option>
            </select>
            <select class="filter-select" id="projectFilter">
                <option value="">All Projects</option>
                <% if (hasProjects) {
                    for (Project project : projects) { %>
                <option value="<%= project.getId() %>"><%= project.getName() %></option>
                <% }
                } %>
            </select>
        </div>
    </div>

    <!-- Tasks Table (Desktop View) -->
    <div class="card">
        <% if (hasTasks) { %>
        <table class="tasks-table" id="tasksTable">
            <thead>
            <tr>
                <th style="width: 40px;"></th>
                <th onclick="sortTable(1)">Task Name <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(2)">Project <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(3)">Status <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(4)">Priority <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(5)">Due Date <i class="fas fa-sort"></i></th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Task task : tasks) {
                    // Get project name
                    String projectName = "N/A";
                    if (hasProjects && task.getProjectId() != 0) {
                        for (Project project : projects) {
                            if (project.getId() == task.getProjectId()) {
                                projectName = project.getName();
                                break;
                            }
                        }
                    }

                    // Format due date
                    String dueDate = task.getDueDate() != null ? sdf.format(task.getDueDate()) : "No due date";
            %>
            <tr>
                <td>
                    <div class="task-checkbox <%= "completed".equals(task.getStatus()) ? "completed" : "" %>" data-task-id="<%= task.getId() %>">
                        <% if ("completed".equals(task.getStatus())) { %>
                        <i class="fas fa-check"></i>
                        <% } %>
                    </div>
                </td>
                <td><strong><%= task.getName() %></strong></td>
                <td><%= projectName %></td>
                <td>
                            <span class="status-badge status-<%= task.getStatus() %>">
                                <%= task.getStatus().substring(0, 1).toUpperCase() + task.getStatus().substring(1).replace("-", " ") %>
                            </span>
                </td>
                <td>
                    <div class="priority-indicator">
                        <span class="priority-dot priority-<%= task.getPriority() %>"></span>
                        <%= task.getPriority().substring(0, 1).toUpperCase() + task.getPriority().substring(1) %>
                    </div>
                </td>
                <td><%= dueDate %></td>
                <td>
                    <div class="table-actions">
                        <a href="<%=request.getContextPath()%>/tasks/edit?id=<%= task.getId() %>" class="btn btn-primary btn-sm btn-icon" title="Edit">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="#" onclick="confirmDelete(<%= task.getId() %>)" class="btn btn-danger btn-sm btn-icon" title="Delete">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <!-- Task Cards (Mobile View) -->
        <div class="task-cards">
            <% for (Task task : tasks) {
                // Get project name
                String projectName = "N/A";
                if (hasProjects && task.getProjectId() != 0) {
                    for (Project project : projects) {
                        if (project.getId() == task.getProjectId()) {
                            projectName = project.getName();
                            break;
                        }
                    }
                }

                // Format due date
                String dueDate = task.getDueDate() != null ? sdf.format(task.getDueDate()) : "No due date";
            %>
            <div class="task-card">
                <div class="task-card-header">
                    <div class="task-card-title">
                        <div class="task-checkbox <%= "completed".equals(task.getStatus()) ? "completed" : "" %>" data-task-id="<%= task.getId() %>">
                            <% if ("completed".equals(task.getStatus())) { %>
                            <i class="fas fa-check"></i>
                            <% } %>
                        </div>
                        <%= task.getName() %>
                    </div>
                    <span class="status-badge status-<%= task.getStatus() %>">
                            <%= task.getStatus().substring(0, 1).toUpperCase() + task.getStatus().substring(1).replace("-", " ") %>
                        </span>
                </div>

                <div class="task-card-meta">
                    <div class="task-card-meta-item">
                        <i class="fas fa-project-diagram"></i>
                        <span>Project: <%= projectName %></span>
                    </div>
                    <div class="task-card-meta-item">
                        <i class="far fa-calendar-alt"></i>
                        <span>Due: <%= dueDate %></span>
                    </div>
                    <div class="task-card-meta-item">
                        <div class="priority-indicator">
                            <span class="priority-dot priority-<%= task.getPriority() %>"></span>
                            <span>Priority: <%= task.getPriority().substring(0, 1).toUpperCase() + task.getPriority().substring(1) %></span>
                        </div>
                    </div>
                </div>

                <% if (task.getDescription() != null && !task.getDescription().isEmpty()) { %>
                <div class="task-card-description">
                    <%= task.getDescription().length() > 100 ? task.getDescription().substring(0, 100) + "..." : task.getDescription() %>
                </div>
                <% } %>

                <div class="task-card-footer">
                    <div class="task-card-meta-item">
                        <i class="far fa-user"></i>
                        <span>Assigned to: You</span>
                    </div>
                    <div class="table-actions">
                        <a href="<%=request.getContextPath()%>/tasks/edit?id=<%= task.getId() %>" class="btn btn-primary btn-sm btn-icon" title="Edit">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="#" onclick="confirmDelete(<%= task.getId() %>)" class="btn btn-danger btn-sm btn-icon" title="Delete">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <!-- Pagination -->
        <div class="pagination">
            <a href="#" class="pagination-item"><i class="fas fa-chevron-left"></i></a>
            <a href="#" class="pagination-item active">1</a>
            <a href="#" class="pagination-item">2</a>
            <a href="#" class="pagination-item">3</a>
            <a href="#" class="pagination-item"><i class="fas fa-chevron-right"></i></a>
        </div>

        <% } else { %>
        <!-- Empty State -->
        <div class="empty-state">
            <div class="empty-state-icon">
                <i class="fas fa-clipboard-list"></i>
            </div>
            <h3 class="empty-state-title">No tasks found</h3>
            <p class="empty-state-description">
                You haven't created any tasks yet. Get started by creating your first task.
            </p>
            <button class="btn btn-primary" id="emptyStateNewTask">
                <i class="fas fa-plus"></i> Create New Task
            </button>
        </div>
        <% } %>
    </div>
</div>

<!-- New Task Modal -->
<div class="modal-overlay" id="newTaskModal">
    <div class="modal">
        <div class="modal-header">
            <h3 class="modal-title">Create New Task</h3>
            <button class="modal-close" id="closeModal">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <div class="modal-body">
            <form id="newTaskForm" action="<%=request.getContextPath()%>/tasks/add" method="post">
                <div class="form-group">
                    <label for="name">Task Name</label>
                    <div class="input-group">
                        <i class="fas fa-clipboard-list input-icon"></i>
                        <input type="text" class="form-control input-with-icon" id="name" name="name" required placeholder="Enter a descriptive name for your task">
                    </div>
                </div>

                <div class="form-group">
                    <label for="description">Task Description</label>
                    <div class="input-group">
                        <i class="fas fa-align-left textarea-icon"></i>
                        <textarea class="form-control" id="description" name="description" placeholder="Describe the task details and requirements" style="padding-left: 45px;"></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label for="projectId">Project</label>
                    <select class="form-control" id="projectId" name="projectId">
                        <option value="0">No Project</option>
                        <% if (hasProjects) {
                            for (Project project : projects) { %>
                        <option value="<%= project.getId() %>"><%= project.getName() %></option>
                        <% }
                        } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="status">Status</label>
                    <select class="form-control" id="status" name="status">
                        <option value="todo">To Do</option>
                        <option value="in-progress">In Progress</option>
                        <option value="completed">Completed</option>
                        <option value="blocked">Blocked</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="priority">Priority</label>
                    <select class="form-control" id="priority" name="priority">
                        <option value="low">Low</option>
                        <option value="medium" selected>Medium</option>
                        <option value="high">High</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="dueDate">Due Date</label>
                    <input type="date" class="form-control" id="dueDate" name="dueDate">
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" id="cancelModal">
                <i class="fas fa-times"></i> Cancel
            </button>
            <button class="btn btn-primary" id="submitNewTask">
                <i class="fas fa-save"></i> Create Task
            </button>
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

<!-- JavaScript for table functionality and modal -->
<script>
    // Modal functionality
    const modal = document.getElementById('newTaskModal');
    const openModalBtn = document.getElementById('openNewTaskModal');
    const closeModalBtn = document.getElementById('closeModal');
    const cancelModalBtn = document.getElementById('cancelModal');
    const submitBtn = document.getElementById('submitNewTask');
    const emptyStateBtn = document.getElementById('emptyStateNewTask');

    function openModal() {
        modal.classList.add('active');
        document.body.style.overflow = 'hidden'; // Prevent scrolling
    }

    function closeModal() {
        modal.classList.remove('active');
        document.body.style.overflow = ''; // Re-enable scrolling
    }

    if (openModalBtn) {
        openModalBtn.addEventListener('click', openModal);
    }

    if (emptyStateBtn) {
        emptyStateBtn.addEventListener('click', openModal);
    }

    closeModalBtn.addEventListener('click', closeModal);
    cancelModalBtn.addEventListener('click', closeModal);

    // Close modal when clicking outside
    modal.addEventListener('click', function(e) {
        if (e.target === modal) {
            closeModal();
        }
    });

    // Submit form
    submitBtn.addEventListener('click', function() {
        document.getElementById('newTaskForm').submit();
    });

    // Task checkbox toggle
    document.querySelectorAll('.task-checkbox').forEach(checkbox => {
        checkbox.addEventListener('click', function() {
            const taskId = this.getAttribute('data-task-id');
            this.classList.toggle('completed');

            // In a real app, you would send an AJAX request to update the task status
            if (this.classList.contains('completed')) {
                this.innerHTML = '<i class="fas fa-check"></i>';
                // Update status to completed
                // fetch('/tasks/updateStatus?id=' + taskId + '&status=completed', { method: 'POST' });
            } else {
                this.innerHTML = '';
                // Update status to todo
                // fetch('/tasks/updateStatus?id=' + taskId + '&status=todo', { method: 'POST' });
            }
        });
    });

    // Search functionality
    document.getElementById('searchInput').addEventListener('keyup', function() {
        const searchValue = this.value.toLowerCase();
        filterTasks();
    });

    // Status filter
    document.getElementById('statusFilter').addEventListener('change', function() {
        filterTasks();
    });

    // Priority filter
    document.getElementById('priorityFilter').addEventListener('change', function() {
        filterTasks();
    });

    // Project filter
    document.getElementById('projectFilter').addEventListener('change', function() {
        filterTasks();
    });

    function filterTasks() {
        const searchValue = document.getElementById('searchInput').value.toLowerCase();
        const statusValue = document.getElementById('statusFilter').value.toLowerCase();
        const priorityValue = document.getElementById('priorityFilter').value.toLowerCase();
        const projectValue = document.getElementById('projectFilter').value;

        // Filter table rows
        const table = document.getElementById('tasksTable');
        if (table) {
            const rows = table.getElementsByTagName('tr');

            // Skip header row
            for (let i = 1; i < rows.length; i++) {
                const taskName = rows[i].getElementsByTagName('td')[1].textContent.toLowerCase();
                const projectCell = rows[i].getElementsByTagName('td')[2].textContent.toLowerCase();
                const statusCell = rows[i].getElementsByTagName('td')[3].textContent.toLowerCase();
                const priorityCell = rows[i].getElementsByTagName('td')[4].textContent.toLowerCase();

                const nameMatch = taskName.includes(searchValue);
                const statusMatch = statusValue === '' || statusCell.includes(statusValue);
                const priorityMatch = priorityValue === '' || priorityCell.includes(priorityValue);
                const projectMatch = projectValue === '' || (projectValue === '0' && projectCell === 'n/a') ||
                    (projectCell.includes(projectValue));

                if (nameMatch && statusMatch && priorityMatch && projectMatch) {
                    rows[i].style.display = '';
                } else {
                    rows[i].style.display = 'none';
                }
            }
        }

        // Filter mobile cards
        const cards = document.querySelectorAll('.task-card');
        cards.forEach(card => {
            const cardTitle = card.querySelector('.task-card-title').textContent.toLowerCase();
            const cardStatus = card.querySelector('.status-badge').textContent.toLowerCase();
            const cardPriority = card.querySelector('.priority-indicator').textContent.toLowerCase();
            const cardProject = card.querySelector('.task-card-meta-item:first-child').textContent.toLowerCase();

            const nameMatch = cardTitle.includes(searchValue);
            const statusMatch = statusValue === '' || cardStatus.includes(statusValue);
            const priorityMatch = priorityValue === '' || cardPriority.includes(priorityValue);
            const projectMatch = projectValue === '' || (projectValue === '0' && cardProject.includes('n/a')) ||
                (cardProject.includes(projectValue));

            if (nameMatch && statusMatch && priorityMatch && projectMatch) {
                card.style.display = '';
            } else {
                card.style.display = 'none';
            }
        });
    }

    // Table sorting
    function sortTable(columnIndex) {
        const table = document.getElementById('tasksTable');
        let switching = true;
        let direction = 'asc';
        let switchcount = 0;

        while (switching) {
            switching = false;
            const rows = table.rows;

            for (let i = 1; i < (rows.length - 1); i++) {
                let shouldSwitch = false;
                const x = rows[i].getElementsByTagName('td')[columnIndex];
                const y = rows[i + 1].getElementsByTagName('td')[columnIndex];

                // Get the text content, handling special cases for status and priority
                let xContent, yContent;

                if (columnIndex === 3) { // Status column
                    xContent = x.querySelector('.status-badge').textContent.trim().toLowerCase();
                    yContent = y.querySelector('.status-badge').textContent.trim().toLowerCase();
                } else if (columnIndex === 4) { // Priority column
                    xContent = x.querySelector('.priority-indicator').textContent.trim().toLowerCase();
                    yContent = y.querySelector('.priority-indicator').textContent.trim().toLowerCase();
                } else {
                    xContent = x.textContent.trim().toLowerCase();
                    yContent = y.textContent.trim().toLowerCase();
                }

                if (direction === 'asc') {
                    if (xContent > yContent) {
                        shouldSwitch = true;
                        break;
                    }
                } else if (direction === 'desc') {
                    if (xContent < yContent) {
                        shouldSwitch = true;
                        break;
                    }
                }
            }

            if (shouldSwitch) {
                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                switching = true;
                switchcount++;
            } else {
                if (switchcount === 0 && direction === 'asc') {
                    direction = 'desc';
                    switching = true;
                }
            }
        }

        // Update sort icons
        const headers = table.getElementsByTagName('th');
        for (let i = 0; i < headers.length; i++) {
            const icon = headers[i].querySelector('i');
            if (i === columnIndex) {
                icon.className = direction === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down';
            } else if (icon) {
                icon.className = 'fas fa-sort';
            }
        }
    }

    // Delete confirmation
    function confirmDelete(taskId) {
        if (confirm('Are you sure you want to delete this task? This action cannot be undone.')) {
            window.location.href = '<%=request.getContextPath()%>/tasks/delete?id=' + taskId;
        }
    }

    // User menu dropdown
    document.querySelector('.user-menu-btn').addEventListener('click', function() {
        // In a real application, this would toggle a dropdown menu
        alert('User menu clicked - Add dropdown functionality here');
    });
</script>
</body>
</html>