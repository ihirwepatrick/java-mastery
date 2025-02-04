package org.example.filterdemo;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.io.PrintWriter;

public class CalculationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        int num2 = Integer.parseInt(req.getParameter("num2"));
        PrintWriter out = servletResponse.getWriter();
        if(num2 < 0) {
            out.println("Num 2 is negative");
        } else {
            filterChain.doFilter(req, servletResponse);
        }
    }
}
