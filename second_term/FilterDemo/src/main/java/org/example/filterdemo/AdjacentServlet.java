package org.example.filterdemo;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

public class AdjacentServlet extends HttpServlet {
    public void service (HttpServletRequest req, HttpServletResponse res) throws IOException {
        PrintWriter out = res.getWriter();
        String num1Str = req.getParameter("num1");
        String num2Str = req.getParameter("num2");
        try {
            int num1 = Integer.parseInt(num1Str);
            int num2 = Integer.parseInt(num2Str);
            int product = num1 * num2;
            // Display the result
            out.println("<h2>Result: " + product + "</h2>");
        } catch (NumberFormatException e) {
            out.println("<h3 style='color:red;'>Error: Invalid numbers.</h3>");
        }
    }
}
