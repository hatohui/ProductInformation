package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "product", urlPatterns = "/product/*")
public class ProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            request.getRequestDispatcher("/Pages/Products/Products.jsp").forward(request, response);
        } else {
            String[] parts = path.split("/");
            if (parts.length == 2) {
                String productId = parts[1];
                //set Product with session
                request.getRequestDispatcher("/Pages/Products/ProductDetails.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
