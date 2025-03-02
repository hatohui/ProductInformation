<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, java.text.NumberFormat, java.util.Locale" %>
<%@ page import="model.Product" %>

<html>
    <%@ include file="/WEB-INF/jspf/header.jspf" %>

    <body class="bg-[#030712] text-white min-h-screen flex flex-col">
        <%@ include file="/WEB-INF/jspf/navBar.jspf" %>

        <div class="container mx-auto px-6 py-6 max-w-[90%]">
            <h1 class="text-3xl font-semibold mb-6 text-center">All Products</h1>

            <div class="mb-6 text-center">
                <a href="/products/create"
                   class="inline-flex items-center gap-2 px-4 py-2 text-sm font-medium text-white bg-blue-600 rounded-md hover:bg-blue-700 transition">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M10 5a1 1 0 0 1 1 1v3h3a1 1 0 0 1 0 2h-3v3a1 1 0 0 1-2 0v-3H6a1 1 0 0 1 0-2h3V6a1 1 0 0 1 1-1z" clip-rule="evenodd" />
                    </svg>
                    Create New Product
                </a>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                <%
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    NumberFormat currencyFormat = NumberFormat.getInstance(Locale.US); // Format numbers with commas

                    if (products != null && !products.isEmpty()) {
                        for (Product product : products) {
                            int finalPrice = product.getPrice() - (product.getPrice() * product.getDiscount() / 100);
                %>
                <div class="relative bg-black-75 border-2 backdrop-blur-xs border-gray-600 rounded-lg shadow-lg overflow-hidden group transition-all hover:scale-105 flex flex-col cursor-pointer">
                    <!-- Icons container, hidden by default, shown on hover -->
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

        <div class="fixed inset-0 -z-50 bg-[url('/Public/Images/axiom-pattern.png')] bg-repeat brightness-125 bg-blend-screen"></div>
    </body>
</html>