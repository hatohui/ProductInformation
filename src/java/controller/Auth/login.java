package controller.Auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "login", urlPatterns = { "/login" })
@SuppressWarnings("serial")
public class login extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    request.getRequestDispatcher("/Pages/Auth/Login.jsp").forward(request, response);
  }
}
