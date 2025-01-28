package org.example.dynamicwebapplication;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

public class TotalServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
        // Retrieve the session
        HttpSession session = req.getSession(false); // Use false to avoid creating a new session if none exists
        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        // Check if the session exists and has the 'total' attribute
        if (session != null && session.getAttribute("total") != null) {
            int total = (int) session.getAttribute("total");
            out.print("<h1>Sum: " + total + "</h1>");
        } else {
            out.print("<h1>No active session or total not available</h1>");
        }
    }
}
