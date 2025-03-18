<%@page import="model.Category"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, java.text.NumberFormat, java.util.Locale" %>
<%@ page import="model.Product" %>

<html>
    <%@ include file="/WEB-INF/jspf/header.jspf" %>

    <body class="bg-[#030712] text-white min-h-screen flex flex-col">
        <%@ include file="/WEB-INF/jspf/navBar.jspf" %>

        <div class="container mx-auto py-6 max-w-[95%]">

            <div class="w-full truncate md:flex mb-8 text-center justify-between border-b-2 bg-[#1e2939] border-gray-600 px-8 backdrop-blur-xs py-1">
                <%
                    String currentCategory = request.getParameter("category");
                    if (currentCategory == null) {
                        currentCategory = "all";
                    }

                    // Preserve parameters
                    String baseParams = "";
                    if (request.getParameter("search") != null) {
                        baseParams += "&search=" + request.getParameter("search");
                    }
                    if (request.getParameter("filter") != null) {
                        baseParams += "&filter=" + request.getParameter("filter");
                    }
                %>

                <a href="?category=all<%= baseParams%>" class="px-4 py-2 <%= currentCategory.equals("all") ? "bg-slate-200 text-slate-950" : "text-gray-300 hover:text-white hover:bg-gray-700 transition"%>">
                    Toàn bộ sản phẩm
                </a>

                <%
                    List<Category> categories = (List<Category>) request.getSession().getAttribute("categories");
                    if (categories != null) {
                        for (Category c : categories) {
                            String categoryId = String.valueOf(c.getTypeId());
                            String isActive = currentCategory.equals(categoryId) ? "bg-slate-200 text-slate-950" : "text-gray-300 hover:text-white hover:bg-gray-700 transition";
                %>
                <a href="?category=<%= categoryId%><%= baseParams%>" class="px-4 py-2 <%= isActive%>">
                    <%= c.getCategoryName()%>
                </a>
                <%
                    }
                } else {
                %>
                <span class="text-red-400">No categories available</span>
                <%
                    }
                %>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-[1fr_4fr] gap-5">
                <div class="relative h-12 w-full max-w-md">
                    <form action="/products" method="GET">
                        <input type="hidden" name="category" value="<%= currentCategory%>">
                        <input type="hidden" name="filter" value="<%= request.getParameter("filter") != null ? request.getParameter("filter") : ""%>">

                        <input name="search" type="text" placeholder="Tìm kiếm sản phẩm..." value="<%= request.getAttribute("search") != null ? request.getAttribute("search") : ""%>"
                               class="w-full pl-12 pr-4 py-2 text-white bg-gray-800 border border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus-border-transparent placeholder-gray-400 h-full"/>
                    </form>

                    <form action="/products" method="GET" class="bg-gray-800 mt-4 border border-gray-600 rounded-lg p-4">
                        <input type="hidden" name="category" value="<%= currentCategory%>">
                        <input type="hidden" name="search" value="<%= request.getParameter("search") != null ? request.getParameter("search") : ""%>">

                        <p class="text-white font-semibold mb-2">Filter by Price:</p>

                        <div class="space-y-2">
                            <label class="flex items-center gap-2 text-gray-300 hover:text-white cursor-pointer">
                                <input type="radio" name="filter" value="below5m"
                                       class="w-5 h-5 accent-blue-500 cursor-pointer"
                                       oninput="this.form.submit()"
                                       <%= "below5m".equals(request.getParameter("filter")) ? "checked" : ""%>>
                                < 5,000,000 VND
                            </label>

                            <label class="flex items-center gap-2 text-gray-300 hover:text-white cursor-pointer">
                                <input type="radio" name="filter" value="5mTo15m"
                                       class="w-5 h-5 accent-blue-500 cursor-pointer"
                                       oninput="this.form.submit()"
                                       <%= "5mTo15m".equals(request.getParameter("filter")) ? "checked" : ""%>>
                                5,000,000 to 15,000,000 VND
                            </label>

                            <label class="flex items-center gap-2 text-gray-300 hover:text-white cursor-pointer">
                                <input type="radio" name="filter" value="above15m"
                                       class="w-5 h-5 accent-blue-500 cursor-pointer"
                                       oninput="this.form.submit()"
                                       <%= "above15m".equals(request.getParameter("filter")) ? "checked" : ""%>>
                                > 15,000,000 VND
                            </label>
                        </div>
                    </form>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                    <%
                        List<Product> products = (List<Product>) request.getAttribute("products");
                        NumberFormat currencyFormat = NumberFormat.getInstance(Locale.US);

                        if (products != null && !products.isEmpty()) {
                            for (Product product : products) {
                                int finalPrice = product.getPrice() - (product.getPrice() * product.getDiscount() / 100);
                    %>
                    <div class="relative bg-black-75 border-2 backdrop-blur-xs border-gray-600 rounded-lg shadow-lg overflow-hidden group transition-all hover:scale-105 flex flex-col cursor-pointer">
                        <div class="relative w-full h-48 bg-gray-800 animate-pulse"
                             onclick="window.location.href = '/products/view?id=<%= product.getProductId()%>';">
                            <img src="<%= product.getProductImage()%>" alt="<%= product.getProductName()%>"
                                 class="w-full h-full object-cover opacity-0 transition-opacity duration-300"
                                 onload="this.style.opacity = '1'; this.parentElement.classList.remove('bg-gray-800', 'animate-pulse');">
                        </div>

                        <div class="p-4 flex flex-col flex-grow"
                             onclick="window.location.href = '/products/view?id=<%= product.getProductId()%>';">
                            <h2 class="text-lg font-semibold mb-1 truncate"><%= product.getProductName()%></h2>
                            <p class="text-gray-400 text-sm mb-3 line-clamp-2"><%= product.getBrief()%></p>

                            <div class="mt-auto flex justify-between items-end">
                                <div>
                                    <p class="text-lg font-bold text-green-400">
                                        <%= currencyFormat.format(finalPrice)%> đ
                                    </p>
                                    <% if (product.getDiscount() > 0) {%>
                                    <p class="text-sm text-red-400 line-through">
                                        <%= currencyFormat.format(product.getPrice())%> đ
                                    </p>
                                    <% }%>
                                </div>

                                <a href="/products/view?id=<%= product.getProductId()%>"
                                   class="text-sky-400 hover:underline text-sm">View Details</a>
                            </div>
                        </div>
                    </div>
                    <% }
                    } else { %>
                    <div class="col-span-full text-center text-gray-400">
                        No products found.
                    </div>
                    <% }%>
                </div>

            </div>
        </div>
        <div class="fixed inset-0 -z-50 bg-[url('/Public/Images/axiom-pattern.png')] bg-repeat brightness-125 bg-blend-screen"></div>

    </body>
</html>
