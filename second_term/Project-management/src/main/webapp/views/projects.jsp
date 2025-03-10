<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.projectmanagement.model.Project" %>
<%
    // Use the existing session object instead of creating a new one
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath()+ "/login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Projects | TaskFlow</title>
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

        /* Table Styles */
        .projects-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: 20px;
        }

        .projects-table th,
        .projects-table td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid var(--gray-light);
        }

        .projects-table th {
            background-color: var(--primary-light);
            color: var(--primary-dark);
            font-weight: 600;
            position: relative;
            cursor: pointer;
            white-space: nowrap;
        }

        .projects-table th:first-child {
            border-top-left-radius: 8px;
        }

        .projects-table th:last-child {
            border-top-right-radius: 8px;
        }

        .projects-table th i {
            margin-left: 5px;
            font-size: 12px;
        }

        .projects-table tbody tr {
            transition: background-color 0.3s;
        }

        .projects-table tbody tr:hover {
            background-color: rgba(67, 97, 238, 0.05);
        }

        .projects-table td {
            vertical-align: middle;
        }

        /* Project Status Badges */
        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 50px;
            font-size: 13px;
            font-weight: 500;
            text-align: center;
            min-width: 100px;
        }

        .status-active {
            background-color: rgba(56, 176, 0, 0.15);
            color: var(--success);
        }

        .status-pending {
            background-color: rgba(255, 183, 3, 0.15);
            color: var(--warning);
        }

        .status-completed {
            background-color: rgba(0, 180, 216, 0.15);
            color: var(--info);
        }

        .status-cancelled {
            background-color: rgba(230, 57, 70, 0.15);
            color: var(--danger);
        }

        /* Project Priority */
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

        /* Table Actions */
        .table-actions {
            display: flex;
            gap: 8px;
            justify-content: flex-end;
        }

        /* Project Card (for mobile view) */
        .project-cards {
            display: none;
        }

        .project-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .project-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .project-card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .project-card-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 5px;
        }

        .project-card-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .project-card-meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
            color: var(--gray);
        }

        .project-card-description {
            color: var(--gray-dark);
            margin-bottom: 15px;
            font-size: 14px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .project-card-footer {
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
            .projects-table th,
            .projects-table td {
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

            .projects-table {
                display: none;
            }

            .project-cards {
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
            <a href="<%=request.getContextPath()%>/projects" class="active"><i class="fas fa-project-diagram"></i> Projects</a>
            <a href="<%=request.getContextPath()%>/tasks"><i class="fas fa-clipboard-list"></i> Tasks</a>
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
    <span class="current">Projects</span>
</div>

<!-- Page Header -->
<div class="page-header">
    <div class="page-title">
        <h1>Projects</h1>
        <p>Manage and track all your projects in one place</p>
    </div>
    <div class="page-actions">
        <button class="btn btn-primary" id="openNewProjectModal">
            <i class="fas fa-plus"></i> New Project
        </button>
    </div>
</div>

<!-- Main Content -->
<div class="container">
    <!-- Search and Filter Bar -->
    <div class="search-filter-bar">
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Search projects..." id="searchInput">
        </div>
        <div class="filter-options">
            <select class="filter-select" id="statusFilter">
                <option value="">All Statuses</option>
                <option value="active">Active</option>
                <option value="pending">Pending</option>
                <option value="completed">Completed</option>
                <option value="cancelled">Cancelled</option>
            </select>
            <select class="filter-select" id="priorityFilter">
                <option value="">All Priorities</option>
                <option value="high">High</option>
                <option value="medium">Medium</option>
                <option value="low">Low</option>
            </select>
        </div>
    </div>

    <!-- Projects Table (Desktop View) -->
    <div class="card">
        <%
            List<Project> projects = (List<Project>) session.getAttribute("projects");
            if (projects != null && !projects.isEmpty()) {
        %>
        <table class="projects-table" id="projectsTable">
            <thead>
            <tr>
                <th onclick="sortTable(0)">Project Name <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(1)">Description <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(2)">Status <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(3)">Priority <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(4)">Created Date <i class="fas fa-sort"></i></th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Assuming Project has more properties than just name
                // If not, you can modify this to show placeholder data
                for (Project project : projects) {
                    // Generate random status and priority for demo purposes
                    // In a real app, these would come from the Project object
                    String[] statuses = {"active", "pending", "completed", "cancelled"};
                    String[] priorities = {"high", "medium", "low"};
                    String status = statuses[(int)(Math.random() * statuses.length)];
                    String priority = priorities[(int)(Math.random() * priorities.length)];

                    // Format date - in a real app, use project.getCreatedDate()
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMM dd, yyyy");
                    String createdDate = sdf.format(new java.util.Date());
            %>
            <tr>
                <td><strong><%= project.getName() %></strong></td>
                <td>
                    <% if (project.getDescription() != null && !project.getDescription().isEmpty()) { %>
                    <%= project.getDescription().length() > 50 ? project.getDescription().substring(0, 50) + "..." : project.getDescription() %>
                    <% } else { %>
                    <em>No description</em>
                    <% } %>
                </td>
                <td>
                            <span class="status-badge status-<%= status %>">
                                <%= status.substring(0, 1).toUpperCase() + status.substring(1) %>
                            </span>
                </td>
                <td>
                    <div class="priority-indicator">
                        <span class="priority-dot priority-<%= priority %>"></span>
                        <%= priority.substring(0, 1).toUpperCase() + priority.substring(1) %>
                    </div>
                </td>
                <td><%= createdDate %></td>
                <td>
                    <div class="table-actions">
                        <a href="<%=request.getContextPath()%>/projects/view?id=<%= project.getId() %>" class="btn btn-secondary btn-sm btn-icon" title="View">
                            <i class="fas fa-eye"></i>
                        </a>
                        <a href="<%=request.getContextPath()%>/projects/edit?id=<%= project.getId() %>" class="btn btn-primary btn-sm btn-icon" title="Edit">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="#" onclick="confirmDelete(<%= project.getId() %>)" class="btn btn-danger btn-sm btn-icon" title="Delete">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <!-- Project Cards (Mobile View) -->
        <div class="project-cards">
            <% for (Project project : projects) {
                // Generate random status and priority for demo purposes
                String[] statuses = {"active", "pending", "completed", "cancelled"};
                String[] priorities = {"high", "medium", "low"};
                String status = statuses[(int)(Math.random() * statuses.length)];
                String priority = priorities[(int)(Math.random() * priorities.length)];

                // Format date
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMM dd, yyyy");
                String createdDate = sdf.format(new java.util.Date());
            %>
            <div class="project-card">
                <div class="project-card-header">
                    <div>
                        <h3 class="project-card-title"><%= project.getName() %></h3>
                        <span class="status-badge status-<%= status %>">
                                <%= status.substring(0, 1).toUpperCase() + status.substring(1) %>
                            </span>
                    </div>
                    <div class="priority-indicator">
                        <span class="priority-dot priority-<%= priority %>"></span>
                        <%= priority.substring(0, 1).toUpperCase() + priority.substring(1) %>
                    </div>
                </div>

                <p class="project-card-description">
                    <% if (project.getDescription() != null && !project.getDescription().isEmpty()) { %>
                    <%= project.getDescription() %>
                    <% } else { %>
                    <em>No description</em>
                    <% } %>
                </p>

                <div class="project-card-meta">
                    <div class="project-card-meta-item">
                        <i class="far fa-calendar-alt"></i>
                        <span>Created: <%= createdDate %></span>
                    </div>
                    <div class="project-card-meta-item">
                        <i class="fas fa-tasks"></i>
                        <span>Tasks: 0/0</span>
                    </div>
                </div>

                <div class="project-card-footer">
                    <div class="project-card-meta-item">
                        <i class="far fa-user"></i>
                        <span>Owner: You</span>
                    </div>
                    <div class="table-actions">
                        <a href="<%=request.getContextPath()%>/projects/view?id=<%= project.getId() %>" class="btn btn-secondary btn-sm btn-icon" title="View">
                            <i class="fas fa-eye"></i>
                        </a>
                        <a href="<%=request.getContextPath()%>/projects/edit?id=<%= project.getId() %>" class="btn btn-primary btn-sm btn-icon" title="Edit">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="#" onclick="confirmDelete(<%= project.getId() %>)" class="btn btn-danger btn-sm btn-icon" title="Delete">
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
                <i class="fas fa-folder-open"></i>
            </div>
            <h3 class="empty-state-title">No projects found</h3>
            <p class="empty-state-description">
                You haven't created any projects yet. Get started by creating your first project.
            </p>
            <button class="btn btn-primary" id="emptyStateNewProject">
                <i class="fas fa-plus"></i> Create New Project
            </button>
        </div>
        <% } %>
    </div>
</div>

<!-- New Project Modal -->
<div class="modal-overlay" id="newProjectModal">
    <div class="modal">
        <div class="modal-header">
            <h3 class="modal-title">Create New Project</h3>
            <button class="modal-close" id="closeModal">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <div class="modal-body">
            <form id="newProjectForm" action="<%=request.getContextPath()%>/projects/add" method="post">
                <div class="form-group">
                    <label for="name">Project Name</label>
                    <div class="input-group">
                        <i class="fas fa-folder input-icon"></i>
                        <input type="text" class="form-control input-with-icon" id="name" name="name" required placeholder="Enter a descriptive name for your project">
                    </div>
                    <small class="form-text">Choose a clear, descriptive name for your project</small>
                </div>

                <div class="form-group">
                    <label for="description">Project Description</label>
                    <div class="input-group">
                        <i class="fas fa-align-left textarea-icon"></i>
                        <textarea class="form-control" id="description" name="description" required placeholder="Describe the goals, scope, and details of your project" style="padding-left: 45px;"></textarea>
                    </div>
                    <small class="form-text">Provide a detailed description of the project goals and scope</small>
                </div>

                <div class="form-group">
                    <label for="status">Status</label>
                    <select class="form-control" id="status" name="status">
                        <option value="active">Active</option>
                        <option value="pending">Pending</option>
                        <option value="completed">Completed</option>
                        <option value="cancelled">Cancelled</option>
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
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" id="cancelModal">
                <i class="fas fa-times"></i> Cancel
            </button>
            <button class="btn btn-primary" id="submitNewProject">
                <i class="fas fa-save"></i> Create Project
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
    const modal = document.getElementById('newProjectModal');
    const openModalBtn = document.getElementById('openNewProjectModal');
    const closeModalBtn = document.getElementById('closeModal');
    const cancelModalBtn = document.getElementById('cancelModal');
    const submitBtn = document.getElementById('submitNewProject');
    const emptyStateBtn = document.getElementById('emptyStateNewProject');

    function openModal() {
        modal.classList.add('active');
        document.body.style.overflow = 'hidden'; // Prevent scrolling
    }

    function closeModal() {
        modal.classList.remove('active');
        document.body.style.overflow = ''; // Re-enable scrolling
    }

    openModalBtn.addEventListener('click', openModal);

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
        document.getElementById('newProjectForm').submit();
    });

    // Search functionality
    document.getElementById('searchInput').addEventListener('keyup', function() {
        const searchValue = this.value.toLowerCase();
        const table = document.getElementById('projectsTable');
        const rows = table.getElementsByTagName('tr');

        // Skip header row
        for (let i = 1; i < rows.length; i++) {
            const projectName = rows[i].getElementsByTagName('td')[0].textContent.toLowerCase();
            const projectDesc = rows[i].getElementsByTagName('td')[1].textContent.toLowerCase();

            if (projectName.includes(searchValue) || projectDesc.includes(searchValue)) {
                rows[i].style.display = '';
            } else {
                rows[i].style.display = 'none';
            }
        }

        // Also filter the mobile cards
        const cards = document.querySelectorAll('.project-card');
        cards.forEach(card => {
            const cardTitle = card.querySelector('.project-card-title').textContent.toLowerCase();
            const cardDesc = card.querySelector('.project-card-description').textContent.toLowerCase();

            if (cardTitle.includes(searchValue) || cardDesc.includes(searchValue)) {
                card.style.display = '';
            } else {
                card.style.display = 'none';
            }
        });
    });

    // Status filter
    document.getElementById('statusFilter').addEventListener('change', function() {
        filterTable();
    });

    // Priority filter
    document.getElementById('priorityFilter').addEventListener('change', function() {
        filterTable();
    });

    function filterTable() {
        const statusValue = document.getElementById('statusFilter').value.toLowerCase();
        const priorityValue = document.getElementById('priorityFilter').value.toLowerCase();
        const table = document.getElementById('projectsTable');
        const rows = table.getElementsByTagName('tr');

        // Skip header row
        for (let i = 1; i < rows.length; i++) {
            const statusCell = rows[i].getElementsByTagName('td')[2];
            const priorityCell = rows[i].getElementsByTagName('td')[3];
            const status = statusCell.textContent.trim().toLowerCase();
            const priority = priorityCell.textContent.trim().toLowerCase();

            const statusMatch = statusValue === '' || status.includes(statusValue);
            const priorityMatch = priorityValue === '' || priority.includes(priorityValue);

            if (statusMatch && priorityMatch) {
                rows[i].style.display = '';
            } else {
                rows[i].style.display = 'none';
            }
        }

        // Also filter the mobile cards
        const cards = document.querySelectorAll('.project-card');
        cards.forEach(card => {
            const cardStatus = card.querySelector('.status-badge').textContent.trim().toLowerCase();
            const cardPriority = card.querySelector('.priority-indicator').textContent.trim().toLowerCase();

            const statusMatch = statusValue === '' || cardStatus.includes(statusValue);
            const priorityMatch = priorityValue === '' || cardPriority.includes(priorityValue);

            if (statusMatch && priorityMatch) {
                card.style.display = '';
            } else {
                card.style.display = 'none';
            }
        });
    }

    // Table sorting
    function sortTable(columnIndex) {
        const table = document.getElementById('projectsTable');
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

                if (columnIndex === 2) { // Status column
                    xContent = x.querySelector('.status-badge').textContent.trim().toLowerCase();
                    yContent = y.querySelector('.status-badge').textContent.trim().toLowerCase();
                } else if (columnIndex === 3) { // Priority column
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
            } else {
                icon.className = 'fas fa-sort';
            }
        }
    }

    // Delete confirmation
    function confirmDelete(projectId) {
        if (confirm('Are you sure you want to delete this project? This action cannot be undone.')) {
            window.location.href = '<%=request.getContextPath()%>/projects/delete?id=' + projectId;
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