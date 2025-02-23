package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Account;
import repositories.AccountDAO;

@WebServlet(name = "test", urlPatterns = "/test")
public class test extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");

    AccountDAO accountDao = new AccountDAO();
    List<Account> accounts = accountDao.getAll();

    try (PrintWriter out = response.getWriter()) {
      out.println("<!DOCTYPE html>");
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet test</title>");
      out.println("</head>");
      out.println("<body>");
      out.println("<h1>Account List</h1>");

      if (accounts.isEmpty()) {
        out.println("<p>No accounts found.</p>");
      } else {
        out.println("<table border='1'>");
        out.println("<tr><th>Username</th><th>Full Name</th><th>Phone</th><th>Role</th></tr>");

        for (Account acc : accounts) {
          out.println("<tr>");
          out.println("<td>" + acc.getAccount() + "</td>");
          out.println("<td>" + acc.getFirstName() + " " + acc.getLastName() + "</td>");
          out.println("<td>" + acc.getPhone() + "</td>");
          out.println("<td>" + acc.getRoleInSystem() + "</td>");
          out.println("</tr>");
        }

        out.println("</table>");
      }

      out.println("</body>");
      out.println("</html>");
    }
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    processRequest(request, response);
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    processRequest(request, response);
  }
}
