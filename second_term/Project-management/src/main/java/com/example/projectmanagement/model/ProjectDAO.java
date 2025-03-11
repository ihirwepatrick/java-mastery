package com.example.projectmanagement.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class ProjectDAO {
    private final Connection connection;

    public ProjectDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean addProject(Project project) {
        String query = "INSERT INTO projects (user_id, project_name, description, status, priority, created_date) VALUES (?, ?, ?, ?, ?, NOW())";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, project.getUserId());
            stmt.setString(2, project.getName());
            stmt.setString(3, project.getDescription());
            stmt.setString(4, project.getStatus());
            stmt.setString(5, project.getPriority());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Legacy method for backward compatibility
    public boolean addProject(int userId, String name, String description) {
        Project project = new Project();
        project.setUserId(userId);
        project.setName(name);
        project.setDescription(description);
        project.setStatus("active"); // Default status
        project.setPriority("medium"); // Default priority
        return addProject(project);
    }

    public List<Project> getUserProjects(int userId) {
        List<Project> projects = new ArrayList<>();
        String query = "SELECT * FROM projects WHERE user_id = ? ORDER BY created_date DESC";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Project project = new Project();
                    project.setId(rs.getInt("project_id"));
                    project.setUserId(rs.getInt("user_id"));
                    project.setName(rs.getString("project_name"));
                    project.setDescription(rs.getString("description"));
                    project.setStatus(rs.getString("status"));
                    project.setPriority(rs.getString("priority"));
                    project.setCreatedDate(rs.getTimestamp("created_date"));
                    projects.add(project);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }

    public Project getProjectById(int projectId) {
        String query = "SELECT * FROM projects WHERE project_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, projectId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Project project = new Project();
                    project.setId(rs.getInt("project_id"));
                    project.setUserId(rs.getInt("user_id"));
                    project.setName(rs.getString("project_name"));
                    project.setDescription(rs.getString("description"));
                    project.setStatus(rs.getString("status"));
                    project.setPriority(rs.getString("priority"));
                    project.setCreatedDate(rs.getTimestamp("created_date"));
                    return project;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateProject(Project project) {
        String query = "UPDATE projects SET project_name = ?, description = ?, status = ?, priority = ? WHERE project_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, project.getName());
            stmt.setString(2, project.getDescription());
            stmt.setString(3, project.getStatus());
            stmt.setString(4, project.getPriority());
            stmt.setInt(5, project.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteProject(int projectId) {
        String query = "DELETE FROM projects WHERE project_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, projectId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}