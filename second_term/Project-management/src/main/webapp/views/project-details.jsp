<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.example.projectmanagement.model.Project" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Use the existing session object instead of creating a new one
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath()+ "/login");
        return;
    }

    // Get the project from request attribute
    Project project = (Project) request.getAttribute("project");
    if (project == null) {
        response.sendRedirect(request.getContextPath() + "/projects");
        return;
    }

    // Format dates
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy HH:mm");
    String createdDate = project.getCreatedDate() != null ? sdf.format(project.getCreatedDate()) : "N/A";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= project.getName() %> | TaskFlow</title>
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

        .page-actions {
            display: flex;
            gap: 10px;
        }

        /* Main Content */
        .container {
            max-width: 1000px;
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

        /* Project Status Badges */
        .status-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 50px;
            font-size: 14px;
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

        /* Project Details */
        .project-details {
            margin-bottom: 30px;
        }

        .project-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--gray);
            font-size: 14px;
        }

        .meta-item i {
            color: var(--primary);
            font-size: 16px;
        }

        .project-description {
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid var(--gray-light);
        }

        .project-description h3 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--dark);
        }

        .project-description p {
            color: var(--gray-dark);
            line-height: 1.7;
            white-space: pre-line;
        }

        /* Section Styles */
        .section-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            color: var(--primary);
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

        /* Tasks Section */
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

        .task-actions {
            display: flex;
            gap: 8px;
        }

        /* Team Members Section */
        .team-members {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 15px;
        }

        .team-member {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 15px;
            background-color: var(--light);
            border-radius: 8px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .team-member:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .team-member-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary-light);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 16px;
        }

        .team-member-info {
            display: flex;
            flex-direction: column;
        }

        .team-member-name {
            font-weight: 500;
            color: var(--dark);
        }

        .team-member-role {
            font-size: 12px;
            color: var(--gray);
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

            .page-actions {
                width: 100%;
                justify-content: space-between;
            }

            .project-meta {
                flex-direction: column;
                gap: 10px;
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
    <a href="<%=request.getContextPath()%>/projects">Projects</a>
    <span class="separator"><i class="fas fa-chevron-right"></i></span>
    <span class="current"><%= project.getName() %></span>
</div>

<!-- Page Header -->
<div class="page-header">
    <div class="page-title">
        <h1>
            <i class="fas fa-project-diagram"></i>
            <%= project.getName() %>
            <%
                String status = project.getStatus();
                if (status == null) status = "active";
            %>
            <span class="status-badge status-<%= status %>">
                    <%= status.substring(0, 1).toUpperCase() + status.substring(1) %>
                </span>
        </h1>
    </div>
    <div class="page-actions">
        <a href="<%=request.getContextPath()%>/projects/edit?id=<%= project.getId() %>" class="btn btn-primary">
            <i class="fas fa-edit"></i> Edit Project
        </a>
        <a href="#" onclick="confirmDelete(<%= project.getId() %>)" class="btn btn-danger">
            <i class="fas fa-trash-alt"></i> Delete
        </a>
    </div>
</div>

<!-- Main Content -->
<div class="container">
    <!-- Project Details Card -->
    <div class="card project-details">
        <div class="project-meta">
            <div class="meta-item">
                <i class="far fa-calendar-alt"></i>
                <span>Created: <%= createdDate %></span>
            </div>
            <div class="meta-item">
                <i class="fas fa-user"></i>
                <span>Owner: You</span>
            </div>
            <div class="meta-item">
                <%
                    String priority = project.getPriority();
                    if (priority == null) priority = "medium";
                %>
                <div class="priority-indicator">
                    <span class="priority-dot priority-<%= priority %>"></span>
                    <span>Priority: <%= priority.substring(0, 1).toUpperCase() + priority.substring(1) %></span>
                </div>
            </div>
            <div class="meta-item">
                <i class="fas fa-tasks"></i>
                <span>Tasks: 0 completed / 0 total</span>
            </div>
        </div>

        <div class="project-description">
            <h3>Description</h3>
            <p><%= project.getDescription() != null && !project.getDescription().isEmpty() ? project.getDescription() : "No description provided." %></p>
        </div>
    </div>

    <!-- Tasks Section -->
    <div class="card">
        <div class="section-title">
            <i class="fas fa-clipboard-list"></i>
            <span>Tasks</span>
        </div>

        <div class="empty-state">
            <i class="fas fa-clipboard-list"></i>
            <h3 class="empty-state-title">No tasks yet</h3>
            <p>This project doesn't have any tasks yet. Add a task to get started.</p>
            <a href="#" class="btn btn-primary btn-sm" style="margin-top: 15px;">
                <i class="fas fa-plus"></i> Add Task
            </a>
        </div>

        <!-- Example of how tasks would look (commented out) -->
        <!--
        <div class="tasks-list">
            <div class="task-item">
                <div class="task-info">
                    <div class="task-checkbox completed">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="task-name completed">Create project wireframes</div>
                </div>
                <div class="task-meta">
                    <div class="task-due-date">Due: Oct 15, 2023</div>
                    <div class="task-actions">
                        <a href="#" class="btn btn-secondary btn-sm">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="#" class="btn btn-danger btn-sm">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="task-item">
                <div class="task-info">
                    <div class="task-checkbox"></div>
                    <div class="task-name">Implement frontend design</div>
                </div>
                <div class="task-meta">
                    <div class="task-due-date">Due: Oct 20, 2023</div>
                    <div class="task-actions">
                        <a href="#" class="btn btn-secondary btn-sm">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="#" class="btn btn-danger btn-sm">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        -->
    </div>

    <!-- Team Members Section -->
    <div class="card">
        <div class="section-title">
            <i class="fas fa-users"></i>
            <span>Team Members</span>
        </div>

        <div class="empty-state">
            <i class="fas fa-users"></i>
            <h3 class="empty-state-title">No team members</h3>
            <p>This project doesn't have any team members assigned yet.</p>
            <a href="#" class="btn btn-primary btn-sm" style="margin-top: 15px;">
                <i class="fas fa-plus"></i> Add Team Member
            </a>
        </div>

        <!-- Example of how team members would look (commented out) -->
        <!--
        <div class="team-members">
            <div class="team-member">
                <div class="team-member-avatar">JD</div>
                <div class="team-member-info">
                    <div class="team-member-name">John Doe</div>
                    <div class="team-member-role">Developer</div>
                </div>
            </div>
            <div class="team-member">
                <div class="team-member-avatar">JS</div>
                <div class="team-member-info">
                    <div class="team-member-name">Jane Smith</div>
                    <div class="team-member-role">Designer</div>
                </div>
            </div>
        </div>
        -->
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