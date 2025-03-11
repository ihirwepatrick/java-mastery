package com.example.projectmanagement.model;

import java.util.Date;

public class Task {
    private int id;
    private String name;
    private String description;
    private int projectId;
    private String status;
    private String priority;
    private Date dueDate;
    private int assignedTo;
    private int createdBy;
    private Date createdDate;
    private Date lastUpdated;
    private Date completedDate;

    // Default constructor
    public Task() {
        this.status = "todo";
        this.priority = "medium";
    }

    // Constructor with essential fields
    public Task(String name, String description, int projectId, String status, String priority, Date dueDate, int assignedTo, int createdBy) {
        this.name = name;
        this.description = description;
        this.projectId = projectId;
        this.status = status != null ? status : "todo";
        this.priority = priority != null ? priority : "medium";
        this.dueDate = dueDate;
        this.assignedTo = assignedTo;
        this.createdBy = createdBy;
        this.createdDate = new Date();
        this.lastUpdated = new Date();
    }

    // Full constructor
    public Task(int id, String name, String description, int projectId, String status, String priority,
                Date dueDate, int assignedTo, int createdBy, Date createdDate, Date lastUpdated, Date completedDate) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.projectId = projectId;
        this.status = status;
        this.priority = priority;
        this.dueDate = dueDate;
        this.assignedTo = assignedTo;
        this.createdBy = createdBy;
        this.createdDate = createdDate;
        this.lastUpdated = lastUpdated;
        this.completedDate = completedDate;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public int getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(int assignedTo) {
        this.assignedTo = assignedTo;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    public Date getCompletedDate() {
        return completedDate;
    }

    public void setCompletedDate(Date completedDate) {
        this.completedDate = completedDate;
    }

    // Helper methods
    public boolean isCompleted() {
        return "completed".equals(this.status);
    }

    public boolean isOverdue() {
        if (this.dueDate == null || this.isCompleted()) {
            return false;
        }
        return this.dueDate.before(new Date());
    }

    public void markAsCompleted() {
        this.status = "completed";
        this.completedDate = new Date();
        this.lastUpdated = new Date();
    }

    @Override
    public String toString() {
        return "Task{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", projectId=" + projectId +
                ", status='" + status + '\'' +
                ", priority='" + priority + '\'' +
                ", dueDate=" + dueDate +
                '}';
    }
}