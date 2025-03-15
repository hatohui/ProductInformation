<%@page import="model.Category"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, java.text.NumberFormat, java.util.Locale" %>
<%@ page import="model.Product" %>

<html>
    <%@ include file="/WEB-INF/jspf/header.jspf" %>

    <body class="bg-[#030712] text-white min-h-screen flex flex-col">
        <%@ include file="/WEB-INF/jspf/navBar.jspf" %>

        <div class="container mx-auto py-6 max-w-[95%]">

            <div class="w-full truncate md:flex mb-8 text-center justify-between border-b-2 border-gray-600 px-8 backdrop-blur-xs py-1">
                <%
                    String currentCategory = request.getParameter("category");
                    if (currentCategory == null) {
                        currentCategory = "all";
                    }
                %>
                <a href="?category=all" class="px-4 py-2 <%= currentCategory.equals("all") ? "bg-slate-200 text-slate-950" : "text-gray-300 hover:text-white hover:bg-gray-700 transition"%>">
                    Toàn bộ sản phẩm
                </a>
                <%
                    List<Category> categories = (List<Category>) request.getSession().getAttribute("categories");
                    if (categories != null) {
                        for (Category c : categories) {
                            String categoryId = String.valueOf(c.getTypeId());
                            String isActive = currentCategory.equals(categoryId) ? "bg-slate-200 text-slate-950" : "text-gray-300 hover:text-white hover:bg-gray-700 transition";
                %>
                <a href="?category=<%= categoryId%>" class="px-4 py-2 <%= isActive%>">
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
                    <input id="search" type="text" placeholder="Tìm kiếm sản phẩm..."
                           class="w-full pl-12 pr-4 py-2 text-white bg-gray-800 border border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus-border-transparent placeholder-gray-400 h-full"/>
                    <div class="absolute inset-y-0 left-0 flex items-center pl-4">
                        <svg class="w-5 h-5 text-gray-300"
                             viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="11" cy="11" r="8" />
                            <line x1="21" y1="21" x2="16.65" y2="16.65" />
                        </svg>
                    </div>
                </div>
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                    <% if (account.getRoleInSystem() == 1) { %>

                    <a href="/products/create" class="relative bg-black-75 border-2 backdrop-blur-xs border-gray-600 rounded-lg shadow-lg overflow-hidden group transition-all hover:scale-105 flex flex-col items-center justify-center cursor-pointer p-4 min-w-[150px] text-white">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-8 h-8 text-white mb-2 group-hover:text-green-400 transition-colors" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4" />
                        </svg>
                        <span class="text-sm font-semibold text-center">Create New Product</span>
                    </a>

                    <% } %>
                    <%
                        List<Product> products = (List<Product>) request.getAttribute("products");
                        NumberFormat currencyFormat = NumberFormat.getInstance(Locale.US); // Format numbers with commas

                        if (products != null && !products.isEmpty()) {
                            for (Product product : products) {
                                int finalPrice = product.getPrice() - (product.getPrice() * product.getDiscount() / 100);
                    %>
                    <div class="relative bg-black-75 border-2 backdrop-blur-xs border-gray-600 rounded-lg shadow-lg overflow-hidden group transition-all hover:scale-105 flex flex-col cursor-pointer">
                        <% if (account.getRoleInSystem() == 1) {%>
                        <div class="absolute top-2 right-2 z-10 flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                            <a href="/products/edit?id=<%= product.getProductId()%>"
                               class="bg-gray-800 text-white p-2 rounded-sm hover:bg-gray-700 transition-all border border-white"
                               title="Edit Product">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-5 h-5">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M16.862 3.487a2.534 2.534 0 1 1 3.586 3.586l-9.918 9.918a4 4 0 0 1-1.414.942l-4.223 1.408a.5.5 0 0 1-.636-.636l1.408-4.223a4 4 0 0 1 .942-1.414l9.918-9.918z"/>
                                </svg>
                            </a>
                            <a href="/products/delete?id=<%= product.getProductId()%>"
                               class="bg-gray-800 text-white p-2 rounded-sm hover:bg-gray-700 transition-all border border-white"
                               title="Delete Product"
                               onclick="return confirm('Are you sure you want to delete this product?');">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-5 h-5">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                                </svg>
                            </a>
                        </div>
                        <% }%>

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
                                        <%= currencyFormat.format(finalPrice)%>đ
                                    </p>
                                    <% if (product.getDiscount() > 0) {%>
                                    <p class="text-sm text-red-400 line-through">
                                        <%= currencyFormat.format(product.getPrice())%>đ
                                    </p>
                                    <% }%>
                                </div>

                                <a href="/products/view?id=<%= product.getProductId()%>"
                                   class="text-sky-400 hover:underline text-sm">View Details</a>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    } else {
                    %>
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