package com.example.projectmanagement.Controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class SignupErrorServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String errorType = request.getParameter("type");
        String message = "";

        switch (errorType) {
            case "email_exists":
                message = "Email is already registered.";
                break;
            case "insert_failed":
                message = "Failed to register. Please try again.";
                break;
            case "sql_error":
                message = "A database error occurred. Contact support.";
                break;
            default:
                message = "An unknown error occurred.";
        }

        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("/views/error.jsp").forward(request, response);
    }
}

