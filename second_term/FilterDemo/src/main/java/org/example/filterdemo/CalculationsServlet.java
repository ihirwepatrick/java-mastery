package org.example.filterdemo;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CalculationsServlet extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
        res.setContentType("text/html"); // Set response type to HTML
        PrintWriter out = res.getWriter();

        String num1Str = req.getParameter("num1");
        String num2Str = req.getParameter("num2");

        if (num1Str == null || num2Str == null || num1Str.isEmpty() || num2Str.isEmpty()) {
            out.println("<h3 style='color:red;'>Error: num1 and num2 are required.</h3>");
            return;
        }
            int num1 = Integer.parseInt(num1Str);
            int num2 = Integer.parseInt(num2Str);
            int sum = num1 + num2;

            // Display the result
            out.println("<h2>Result: " + sum + "</h2>");
            ServletContext context = getServletContext();
            String email = context.getInitParameter("email");
            System.out.println("Email: " + email);
    }
}
