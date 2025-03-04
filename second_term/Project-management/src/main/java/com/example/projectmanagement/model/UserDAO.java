package com.example.projectmanagement.model;

import com.example.projectmanagement.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.postgresql.Driver;

public class UserDAO {
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                users.add(new User(rs.getInt("id"), rs.getString("name"), rs.getString("email")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }


    public void addUser(User user) {
        String query = "INSERT INTO users(name, email) VALUES(?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

