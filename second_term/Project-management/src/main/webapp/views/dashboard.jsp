<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.projectmanagement.model.Project" %>
<%
    // Use the existing session object instead of creating a new one
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath()+ "/login");
        return;
    }

// Get user name from session (if available)
    String userName = (String) session.getAttribute("userName");
    if (userName == null) {
        userName = "User"; // Default name if not available
    }

// Get projects from session (if available)
    List<Project> projects = (List<Project>) session.getAttribute("projects");
    boolean hasProjects = (projects != null && !projects.isEmpty());

// For demo purposes, let's create some statistics
    int totalProjects = hasProjects ? projects.size() : 0;
    int completedProjects = 0;
    int activeProjects = 0;
    int pendingProjects = 0;

// Calculate project statistics if we have projects
    if (hasProjects) {
        for (Project project : projects) {
            String status = project.getStatus();
            if (status != null) {
                if (status.equals("completed")) {
                    completedProjects++;
                } else if (status.equals("active")) {
                    activeProjects++;
                } else if (status.equals("pending")) {
                    pendingProjects++;
                }
            } else {
                // Default to active if status is null
                activeProjects++;
            }
        }
    }

// Calculate completion percentage
    int completionPercentage = totalProjects > 0 ? (completedProjects * 100) / totalProjects : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | TaskFlow</title>
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

        /* Welcome Banner */
        .welcome-banner {
            background: linear-gradient(135deg, var(--primary-light) 0%, #f0f4ff 100%);
            padding: 30px 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .welcome-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .welcome-text h2 {
            font-size: 24px;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 10px;
        }

        .welcome-text p {
            color: var(--gray);
            font-size: 16px;
            max-width: 600px;
        }

        .welcome-actions {
            display: flex;
            gap: 10px;
        }

        /* Page Header */
        .page-header {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
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
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            background-color: white;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .stat-card.primary {
            border-left: 4px solid var(--primary);
        }

        .stat-card.success {
            border-left: 4px solid var(--success);
        }

        .stat-card.warning {
            border-left: 4px solid var(--warning);
        }

        .stat-card.danger {
            border-left: 4px solid var(--danger);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 15px;
        }

        .stat-icon.primary {
            background-color: var(--primary-light);
            color: var(--primary);
        }

        .stat-icon.success {
            background-color: rgba(56, 176, 0, 0.15);
            color: var(--success);
        }

        .stat-icon.warning {
            background-color: rgba(255, 183, 3, 0.15);
            color: var(--warning);
        }

        .stat-icon.danger {
            background-color: rgba(230, 57, 70, 0.15);
            color: var(--danger);
        }

        .stat-value {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-label {
            color: var(--gray);
            font-size: 14px;
        }

        /* Progress Bar */
        .progress-container {
            margin-top: 10px;
        }

        .progress-bar {
            height: 8px;
            background-color: var(--gray-light);
            border-radius: 4px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background-color: var(--primary);
            border-radius: 4px;
        }

        .progress-text {
            display: flex;
            justify-content: space-between;
            margin-top: 5px;
            font-size: 12px;
            color: var(--gray);
        }

        /* Section Styles */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .section-title {
            font-size: 20px;
            font-weight: 600;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            color: var(--primary);
        }

        .section-actions {
            display: flex;
            gap: 10px;
        }

        /* Project Cards */
        .projects-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .project-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 20px;
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

        /* Tasks List */
        .tasks-list {
            margin-top: 15px;
        }

        .task-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px;
            border-bottom: 1px solid var(--gray-light);
            transition: background-color 0.3s;
        }

        .task-item:hover {
            background-color: var(--primary-light);
        }

        .task-item:last-child {
            border-bottom: none;
        }

        .task-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .task-checkbox {
            width: 20px;
            height: 20px;
            border-radius: 4px;
            border: 2px solid var(--gray);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        .task-checkbox.completed {
            background-color: var(--success);
            border-color: var(--success);
            color: white;
        }

        .task-name {
            font-weight: 500;
        }

        .task-name.completed {
            text-decoration: line-through;
            color: var(--gray);
        }

        .task-meta {
            display: flex;
            gap: 15px;
        }

        .task-due-date {
            font-size: 14px;
            color: var(--gray);
        }

        .task-project {
            font-size: 14px;
            color: var(--primary);
        }

        /* Activity Feed */
        .activity-feed {
            margin-top: 15px;
        }

        .activity-item {
            display: flex;
            gap: 15px;
            padding: 15px 0;
            border-bottom: 1px solid var(--gray-light);
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary-light);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            flex-shrink: 0;
        }

        .activity-icon.success {
            background-color: rgba(56, 176, 0, 0.15);
            color: var(--success);
        }

        .activity-icon.warning {
            background-color: rgba(255, 183, 3, 0.15);
            color: var(--warning);
        }

        .activity-icon.danger {
            background-color: rgba(230, 57, 70, 0.15);
            color: var(--danger);
        }

        .activity-content {
            flex: 1;
        }

        .activity-text {
            margin-bottom: 5px;
        }

        .activity-text a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }

        .activity-text a:hover {
            text-decoration: underline;
        }

        .activity-time {
            font-size: 12px;
            color: var(--gray);
        }

        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }

        .quick-action-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            text-decoration: none;
            color: var(--dark);
        }

        .quick-action-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .quick-action-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            background-color: var(--primary-light);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 15px;
        }

        .quick-action-text {
            font-weight: 500;
            text-align: center;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 30px 20px;
            color: var(--gray);
        }

        .empty-state i {
            font-size: 40px;
            margin-bottom: 15px;
            color: var(--gray-light);
        }

        .empty-state-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--dark);
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

        .btn-sm {
            padding: 6px 12px;
            font-size: 14px;
        }

        .btn-outline {
            background-color: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
        }

        .btn-outline:hover {
            background-color: var(--primary);
            color: white;
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
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
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

            .welcome-content {
                flex-direction: column;
                align-items: flex-start;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .projects-grid {
                grid-template-columns: 1fr;
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
            <a href="<%=request.getContextPath()%>/dashboard" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <a href="<%=request.getContextPath()%>/projects"><i class="fas fa-project-diagram"></i> Projects</a>
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

<!-- Main Content -->
<div class="container">
    <!-- Welcome Banner -->
    <div class="welcome-banner">
        <div class="welcome-content">
            <div class="welcome-text">
                <h2>Welcome back, <%= userName %>!</h2>
                <p>Here's an overview of your projects and tasks. Stay productive and organized with TaskFlow.</p>
            </div>
            <div class="welcome-actions">
                <a href="<%=request.getContextPath()%>/projects" class="btn btn-primary">
                    <i class="fas fa-project-diagram"></i> View Projects
                </a>
                <a href="<%=request.getContextPath()%>/tasks" class="btn btn-outline">
                    <i class="fas fa-clipboard-list"></i> View Tasks
                </a>
            </div>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="stats-grid">
        <div class="stat-card primary">
            <div class="stat-icon primary">
                <i class="fas fa-project-diagram"></i>
            </div>
            <div class="stat-value"><%= totalProjects %></div>
            <div class="stat-label">Total Projects</div>
            <div class="progress-container">
                <div class="progress-bar">
                    <div class="progress-fill" style="width: <%= completionPercentage %>%;"></div>
                </div>
                <div class="progress-text">
                    <span><%= completedProjects %> completed</span>
                    <span><%= completionPercentage %>%</span>
                </div>
            </div>
        </div>

        <div class="stat-card success">
            <div class="stat-icon success">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-value"><%= completedProjects %></div>
            <div class="stat-label">Completed Projects</div>
        </div>

        <div class="stat-card warning">
            <div class="stat-icon warning">
                <i class="fas fa-spinner"></i>
            </div>
            <div class="stat-value"><%= activeProjects %></div>
            <div class="stat-label">Active Projects</div>
        </div>

        <div class="stat-card danger">
            <div class="stat-icon danger">
                <i class="fas fa-clock"></i>
            </div>
            <div class="stat-value"><%= pendingProjects %></div>
            <div class="stat-label">Pending Projects</div>
        </div>
    </div>

    <!-- Recent Projects Section -->
    <div class="card">
        <div class="section-header">
            <h2 class="section-title">
                <i class="fas fa-project-diagram"></i>
                Recent Projects
            </h2>
            <div class="section-actions">
                <a href="<%=request.getContextPath()%>/projects" class="btn btn-secondary btn-sm">
                    View All
                </a>
                <a href="<%=request.getContextPath()%>/projects" class="btn btn-primary btn-sm" id="openNewProjectModal">
                    <i class="fas fa-plus"></i> New Project
                </a>
            </div>
        </div>

        <% if (hasProjects) { %>
        <div class="projects-grid">
            <%
                // Display up to 3 most recent projects
                int count = 0;
                for (int i = projects.size() - 1; i >= 0 && count < 3; i--, count++) {
                    Project project = projects.get(i);

                    // Generate random status and priority for demo purposes
                    // In a real app, these would come from the Project object
                    String[] statuses = {"active", "pending", "completed", "cancelled"};
                    String[] priorities = {"high", "medium", "low"};
                    String status = project.getStatus() != null ? project.getStatus() : statuses[(int)(Math.random() * statuses.length)];
                    String priority = project.getPriority() != null ? project.getPriority() : priorities[(int)(Math.random() * priorities.length)];

                    // Format date - in a real app, use project.getCreatedDate()
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMM dd, yyyy");
                    String createdDate = project.getCreatedDate() != null ? sdf.format(project.getCreatedDate()) : sdf.format(new java.util.Date());
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
                    <%= project.getDescription().length() > 100 ? project.getDescription().substring(0, 100) + "..." : project.getDescription() %>
                    <% } else { %>
                    <em>No description provided</em>
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
                        <a href="<%=request.getContextPath()%>/projects/view?id=<%= project.getId() %>" class="btn btn-secondary btn-sm">
                            <i class="fas fa-eye"></i> View
                        </a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="empty-state">
            <i class="fas fa-folder-open"></i>
            <h3 class="empty-state-title">No projects found</h3>
            <p>You haven't created any projects yet. Get started by creating your first project.</p>
            <a href="<%=request.getContextPath()%>/projects" class="btn btn-primary" style="margin-top: 15px;">
                <i class="fas fa-plus"></i> Create New Project
            </a>
        </div>
        <% } %>
    </div>

    <!-- Tasks Due Soon Section -->
    <div class="card">
        <div class="section-header">
            <h2 class="section-title">
                <i class="fas fa-clipboard-list"></i>
                Tasks Due Soon
            </h2>
            <div class="section-actions">
                <a href="<%=request.getContextPath()%>/tasks" class="btn btn-secondary btn-sm">
                    View All
                </a>
                <a href="<%=request.getContextPath()%>/tasks/add" class="btn btn-primary btn-sm">
                    <i class="fas fa-plus"></i> New Task
                </a>
            </div>
        </div>

        <!-- For demo purposes, we'll show placeholder tasks -->
        <div class="tasks-list">
            <div class="task-item">
                <div class="task-info">
                    <div class="task-checkbox">
                        <!-- Empty checkbox -->
                    </div>
                    <div class="task-name">Complete project documentation</div>
                </div>
                <div class="task-meta">
                    <div class="task-project">Project Management System</div>
                    <div class="task-due-date">Due: Tomorrow</div>
                </div>
            </div>
            <div class="task-item">
                <div class="task-info">
                    <div class="task-checkbox">
                        <!-- Empty checkbox -->
                    </div>
                    <div class="task-name">Review pull requests</div>
                </div>
                <div class="task-meta">
                    <div class="task-project">TaskFlow App</div>
                    <div class="task-due-date">Due: Today</div>
                </div>
            </div>
            <div class="task-item">
                <div class="task-info">
                    <div class="task-checkbox completed">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="task-name completed">Set up development environment</div>
                </div>
                <div class="task-meta">
                    <div class="task-project">TaskFlow App</div>
                    <div class="task-due-date">Completed</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Activity Section -->
    <div class="card">
        <div class="section-header">
            <h2 class="section-title">
                <i class="fas fa-history"></i>
                Recent Activity
            </h2>
        </div>

        <!-- For demo purposes, we'll show placeholder activities -->
        <div class="activity-feed">
            <div class="activity-item">
                <div class="activity-icon">
                    <i class="fas fa-plus"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-text">
                        You created a new project <a href="#">Project Management System</a>
                    </div>
                    <div class="activity-time">Today, 10:30 AM</div>
                </div>
            </div>
            <div class="activity-item">
                <div class="activity-icon success">
                    <i class="fas fa-check"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-text">
                        You completed task <a href="#">Set up development environment</a>
                    </div>
                    <div class="activity-time">Yesterday, 3:45 PM</div>
                </div>
            </div>
            <div class="activity-item">
                <div class="activity-icon warning">
                    <i class="fas fa-user-plus"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-text">
                        You were added to project <a href="#">TaskFlow App</a>
                    </div>
                    <div class="activity-time">2 days ago</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions Section -->
    <div class="card">
        <div class="section-header">
            <h2 class="section-title">
                <i class="fas fa-bolt"></i>
                Quick Actions
            </h2>
        </div>

        <div class="quick-actions">
            <a href="<%=request.getContextPath()%>/projects" class="quick-action-btn">
                <div class="quick-action-icon">
                    <i class="fas fa-plus"></i>
                </div>
                <div class="quick-action-text">New Project</div>
            </a>
            <a href="<%=request.getContextPath()%>/tasks/add" class="quick-action-btn">
                <div class="quick-action-icon">
                    <i class="fas fa-clipboard-list"></i>
                </div>
                <div class="quick-action-text">New Task</div>
            </a>
            <a href="<%=request.getContextPath()%>/team/invite" class="quick-action-btn">
                <div class="quick-action-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <div class="quick-action-text">Invite Team Member</div>
            </a>
            <a href="<%=request.getContextPath()%>/reports" class="quick-action-btn">
                <div class="quick-action-icon">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <div class="quick-action-text">Generate Report</div>
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
    // User menu dropdown
    document.querySelector('.user-menu-btn').addEventListener('click', function() {
        // In a real application, this would toggle a dropdown menu
        alert('User menu clicked - Add dropdown functionality here');
    });

    // Task checkbox toggle
    document.querySelectorAll('.task-checkbox').forEach(checkbox => {
        checkbox.addEventListener('click', function() {
            this.classList.toggle('completed');
            this.closest('.task-info').querySelector('.task-name').classList.toggle('completed');

            // In a real app, you would send an AJAX request to update the task status
            if (this.classList.contains('completed')) {
                this.innerHTML = '<i class="fas fa-check"></i>';
            } else {
                this.innerHTML = '';
            }
        });
    });

    // New Project button
    document.getElementById('openNewProjectModal').addEventListener('click', function(e) {
        e.preventDefault();
        // In a real app, this would open the new project modal
        // For now, just redirect to the projects page
        window.location.href = '<%=request.getContextPath()%>/projects';
    });
</script>
</body>
</html>