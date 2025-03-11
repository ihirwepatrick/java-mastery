package com.example.projectmanagement.model;

import com.example.projectmanagement.model.Task;
import com.example.projectmanagement.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    // Create a new task
    public int createTask(Task task) throws SQLException {
        String sql = "INSERT INTO tasks (name, description, project_id, status, priority, due_date, assigned_to, created_by) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?) RETURNING id";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, task.getName());
            stmt.setString(2, task.getDescription());

            if (task.getProjectId() > 0) {
                stmt.setInt(3, task.getProjectId());
            } else {
                stmt.setNull(3, java.sql.Types.INTEGER);
            }

            stmt.setString(4, task.getStatus());
            stmt.setString(5, task.getPriority());

            if (task.getDueDate() != null) {
                stmt.setDate(6, new java.sql.Date(task.getDueDate().getTime()));
            } else {
                stmt.setNull(6, java.sql.Types.DATE);
            }

            if (task.getAssignedTo() > 0) {
                stmt.setInt(7, task.getAssignedTo());
            } else {
                stmt.setNull(7, java.sql.Types.INTEGER);
            }

            stmt.setInt(8, task.getCreatedBy());

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

            return -1;
        }
    }

    // Get a task by ID
    public Task getTaskById(int id) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractTaskFromResultSet(rs);
            }

            return null;
        }
    }

    // Get all tasks
    public List<Task> getAllTasks() throws SQLException {
        String sql = "SELECT * FROM tasks ORDER BY due_date ASC, priority DESC";
        List<Task> tasks = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                tasks.add(extractTaskFromResultSet(rs));
            }

            return tasks;
        }
    }

    // Get tasks by project ID
    public List<Task> getTasksByProjectId(int projectId) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE project_id = ? ORDER BY due_date ASC, priority DESC";
        List<Task> tasks = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, projectId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                tasks.add(extractTaskFromResultSet(rs));
            }

            return tasks;
        }
    }

    // Get tasks by user ID (assigned to)
    public List<Task> getTasksByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE assigned_to = ? ORDER BY due_date ASC, priority DESC";
        List<Task> tasks = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                tasks.add(extractTaskFromResultSet(rs));
            }

            return tasks;
        }
    }

    // Get tasks by status
    public List<Task> getTasksByStatus(String status) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE status = ? ORDER BY due_date ASC, priority DESC";
        List<Task> tasks = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                tasks.add(extractTaskFromResultSet(rs));
            }

            return tasks;
        }
    }

    // Update a task
    public boolean updateTask(Task task) throws SQLException {
        String sql = "UPDATE tasks SET name = ?, description = ?, project_id = ?, status = ?, " +
                "priority = ?, due_date = ?, assigned_to = ?, last_updated = CURRENT_TIMESTAMP " +
                "WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, task.getName());
            stmt.setString(2, task.getDescription());

            if (task.getProjectId() > 0) {
                stmt.setInt(3, task.getProjectId());
            } else {
                stmt.setNull(3, java.sql.Types.INTEGER);
            }

            stmt.setString(4, task.getStatus());
            stmt.setString(5, task.getPriority());

            if (task.getDueDate() != null) {
                stmt.setDate(6, new java.sql.Date(task.getDueDate().getTime()));
            } else {
                stmt.setNull(6, java.sql.Types.DATE);
            }

            if (task.getAssignedTo() > 0) {
                stmt.setInt(7, task.getAssignedTo());
            } else {
                stmt.setNull(7, java.sql.Types.INTEGER);
            }

            stmt.setInt(8, task.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    // Update task status
    public boolean updateTaskStatus(int taskId, String status) throws SQLException {
        String sql = "UPDATE tasks SET status = ?, last_updated = CURRENT_TIMESTAMP";

        // If status is completed, set the completed_date
        if ("completed".equals(status)) {
            sql += ", completed_date = CURRENT_TIMESTAMP";
        }

        sql += " WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, taskId);

            return stmt.executeUpdate() > 0;
        }
    }

    // Delete a task
    public boolean deleteTask(int id) throws SQLException {
        String sql = "DELETE FROM tasks WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            return stmt.executeUpdate() > 0;
        }
    }

    // Get tasks due soon (within the next 7 days)
    public List<Task> getTasksDueSoon(int userId) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE due_date BETWEEN CURRENT_DATE AND (CURRENT_DATE + INTERVAL '7 days') " +
                "AND status != 'completed' AND assigned_to = ? ORDER BY due_date ASC";
        List<Task> tasks = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                tasks.add(extractTaskFromResultSet(rs));
            }

            return tasks;
        }
    }

    // Get overdue tasks
    public List<Task> getOverdueTasks(int userId) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE due_date < CURRENT_DATE AND status != 'completed' " +
                "AND assigned_to = ? ORDER BY due_date ASC";
        List<Task> tasks = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                tasks.add(extractTaskFromResultSet(rs));
            }

            return tasks;
        }
    }

    // Helper method to extract a Task from a ResultSet
    private Task extractTaskFromResultSet(ResultSet rs) throws SQLException {
        Task task = new Task();
        task.setId(rs.getInt("id"));
        task.setName(rs.getString("name"));
        task.setDescription(rs.getString("description"));
        task.setProjectId(rs.getInt("project_id"));
        task.setStatus(rs.getString("status"));
        task.setPriority(rs.getString("priority"));

        Date dueDate = rs.getDate("due_date");
        if (dueDate != null) {
            task.setDueDate(new java.util.Date(dueDate.getTime()));
        }

        task.setAssignedTo(rs.getInt("assigned_to"));
        task.setCreatedBy(rs.getInt("created_by"));

        Timestamp createdDate = rs.getTimestamp("created_date");
        if (createdDate != null) {
            task.setCreatedDate(new java.util.Date(createdDate.getTime()));
        }

        Timestamp lastUpdated = rs.getTimestamp("last_updated");
        if (lastUpdated != null) {
            task.setLastUpdated(new java.util.Date(lastUpdated.getTime()));
        }

        Timestamp completedDate = rs.getTimestamp("completed_date");
        if (completedDate != null) {
            task.setCompletedDate(new java.util.Date(completedDate.getTime()));
        }

        return task;
    }
}