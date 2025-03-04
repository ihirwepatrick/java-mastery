package com.example.projectmanagement.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.postgresql.Driver;

public class DBConnection {
    private static final String URL = "jdbc:postgresql://localhost:5432/mvc_db";
    private static final String USER = "postgres";
    private static final String PASSWORD = "pll"; // Change this to your PostgreSQL password

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException("Database connection failed!", e);
        }
    }
}

