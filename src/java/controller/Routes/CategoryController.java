package controller.Routes;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.Category;
import services.CategoryService;

@WebServlet(name = "CategoryController", urlPatterns = {"/categories/*"})
public class CategoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();

        if (path == null) {
            path = "/";
        }

        List<Category> categories;
        if (request.getSession().getAttribute("categories") != null) {
            categories = (List<Category>) request.getSession().getAttribute("categories");
        } else {
            categories = new CategoryService().getAll();
            request.getSession().setAttribute("categories", categories);
        }

        switch (path) {
            case "/":
                request.getRequestDispatcher("/Pages/Categories/Category.jsp").forward(request, response);
                break;
            case "/delete":
                String id = request.getParameter("id");

                if (id != null) {
                    Account user = (Account) request.getSession().getAttribute("user");
                    if (user != null && user.getRoleInSystem() == 1) {
                        new CategoryService().delete(id);
                        response.sendRedirect("/categories");
                    } else {
                        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized");
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing category ID");
                }
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String idParam = request.getParameter("categoryId");

        CategoryService categoryService = new CategoryService();

        if (idParam != null && !idParam.isEmpty()) {
            String categoryName = request.getParameter("editCategoryName");
            String memo = request.getParameter("editMemo");
            categoryService.update(idParam, new Category(categoryName, memo));
        } else {
            String categoryName = request.getParameter("categoryName");
            String memo = request.getParameter("memo");
            categoryService.post(new Category(categoryName, memo));
        }

        response.sendRedirect("/categories");
    }

}
