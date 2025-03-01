package controller.Routes;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import services.AccountService;

@WebServlet(name = "AccountController", urlPatterns = {"/accounts"})
public class AccountController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Account> accounts = new AccountService().getAll();
        System.out.println("got here");
        request.setAttribute("accounts", accounts);
        request.getRequestDispatcher("/Pages/Private/Accounts.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
