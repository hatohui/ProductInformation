package controller.Auth;

import services.AccountService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;

@WebServlet(name = "login", urlPatterns = {"/login"})
@SuppressWarnings("serial")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account account = (Account) request.getSession().getAttribute("user");
        if (account != null) {
            response.sendRedirect("/");
            return;
        }
        request.getRequestDispatcher("/Pages/Auth/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();
        Account userData = new AccountService().authenticate(username, password);

        if (userData == null) {
            request.setAttribute("loginError", "Invalid credentials");
            request.setAttribute("lastInputUsername", username);
            request.setAttribute("lastInputPassword", password);
            doGet(request, response);
        } else {
            request.getSession().setAttribute("user", userData);
            response.sendRedirect("/");
        }
    }
}
