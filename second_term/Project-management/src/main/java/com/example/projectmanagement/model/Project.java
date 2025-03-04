package com.example.projectmanagement.model;

public class Project {
    private int id;
    private int userId;
    private String name;
    private String description;

    public Project(int id, int userId, String name, String description) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.description = description;
    }

    // Getters and setters
    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getName() { return name; }
    public String getDescription() { return description; }
}
