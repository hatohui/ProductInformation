package controller.Routes;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.Category;
import model.Product;
import services.CategoryService;
import services.ProductService;

@WebServlet(name = "product", urlPatterns = "/products/*")
public class ProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();

        Account user = (Account) request.getSession().getAttribute("user");

        if (path == null) {
            path = "/";
        }

        List<Category> categories = (List<Category>) request.getSession().getAttribute("categories");

        if (categories == null) {
            categories = new CategoryService().getAll();
            request.getSession().setAttribute("categories", categories);
        }

        switch (path) {
            case "/":
                String searchQuery = request.getParameter("search");
                String category = request.getParameter("category");
                String filter = request.getParameter("filter");

                List<Product> products;

                if (category != null && !category.equals("all")) {
                    products = new ProductService().getProductsByCategory(Integer.parseInt(category));
                } else {
                    products = new ProductService().getAll();
                }

                if (searchQuery != null && !searchQuery.isEmpty()) {
                    List<Product> searchResult = new ProductService().search(searchQuery.trim());
                    products.retainAll(searchResult);
                    request.setAttribute("search", searchQuery);
                }

                if (filter != null && !filter.isEmpty()) {
                    List<Product> filtered = new ArrayList<>();
                    for (Product product : products) {
                        int finalPrice = product.getPrice() - (product.getPrice() * product.getDiscount() / 100);
                        switch (filter) {
                            case "below5m":
                                if (finalPrice < 5000000) {
                                    filtered.add(product);
                                }
                                break;
                            case "5mTo15m":
                                if (finalPrice >= 5000000 && finalPrice <= 15000000) {
                                    filtered.add(product);
                                }
                                break;
                            case "above15m":
                                if (finalPrice > 15000000) {
                                    filtered.add(product);
                                }
                                break;
                        }
                    }
                    products = filtered;
                }

                request.setAttribute("products", products);
                request.getRequestDispatcher("/Pages/Products/Products.jsp").forward(request, response);
                break;
            case "/view":
                String productId = request.getParameter("id");
                if (productId != null && !productId.isEmpty()) {
                    Product product = new ProductService().getById(productId);
                    if (product != null) {
                        request.setAttribute("product", product);
                        request.getRequestDispatcher("/Pages/Products/ViewProduct.jsp").forward(request, response);
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing product ID");
                }
                break;
            case "/create":
                if (user.getRoleInSystem() != 1) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                }
                request.getRequestDispatcher("/Pages/Products/CreateProduct.jsp").forward(request, response);
                break;
            case "/edit":
                if (user.getRoleInSystem() != 1) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                }
                String editProductId = request.getParameter("id");
                if (editProductId != null && !editProductId.isEmpty()) {
                    Product product = new ProductService().getById(editProductId);
                    if (product != null) {
                        request.setAttribute("product", product);
                        request.getRequestDispatcher("/Pages/Products/EditProduct.jsp").forward(request, response);
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing product ID");
                }
                break;
            case "/delete":
                if (user.getRoleInSystem() != 1) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                }
                String deleteProductId = request.getParameter("id");
                if (deleteProductId != null) {
                    if (new ProductService().delete(deleteProductId)) {
                        response.sendRedirect("/products");
                    } else {
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST);
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

        Account user = (Account) request.getSession().getAttribute("user");
        if (user.getRoleInSystem() != 1) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
        }

        String productId = request.getParameter("productId");
        ProductService productService = new ProductService();

        try {
            if (productId != null && !productId.isEmpty()) {
                Product existingProduct = productService.getById(productId);
                Product product = new Product(
                        productId,
                        request.getParameter("productName"),
                        request.getParameter("productImage"),
                        request.getParameter("brief"),
                        existingProduct.getPostedDate(),
                        Integer.parseInt(request.getParameter("typeId")),
                        request.getParameter("account"),
                        request.getParameter("unit"),
                        Integer.parseInt(request.getParameter("price")),
                        Integer.parseInt(request.getParameter("discount"))
                );
                productService.update(productId, product);
                response.sendRedirect("/products");
            } else {
                String newProductId = UUID.randomUUID().toString().substring(0, 8);
                Product product = new Product(
                        newProductId,
                        request.getParameter("productName"),
                        "/images/sanPham/" + request.getParameter("productImage"),
                        request.getParameter("brief"),
                        new Date(System.currentTimeMillis()),
                        Integer.parseInt(request.getParameter("typeId")),
                        request.getParameter("account"),
                        request.getParameter("unit"),
                        Integer.parseInt(request.getParameter("price")),
                        Integer.parseInt(request.getParameter("discount"))
                );
                productService.post(product);
                response.sendRedirect("/products");
            }
        } catch (IOException | NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
