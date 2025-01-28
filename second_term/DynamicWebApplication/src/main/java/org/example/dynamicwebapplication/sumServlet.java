package org.example.dynamicwebapplication;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

public class sumServlet extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Retrieve the numbers from the request parameters
        int num1 = Integer.parseInt(request.getParameter("num1"));
        int num2 = Integer.parseInt(request.getParameter("num2"));

        // Calculate the sum
        int sum = num1 + num2;

        // Store the sum in the session
        HttpSession session = request.getSession();
        session.setAttribute("total", sum);

        // Forward the request to the 'answer' servlet
        RequestDispatcher rd = request.getRequestDispatcher("answer");
        rd.forward(request, response); // Forward instead of writing directly to the output
    }
}
