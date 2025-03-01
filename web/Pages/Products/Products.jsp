<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, java.text.NumberFormat, java.util.Locale" %>
<%@ page import="model.Product" %>

<html>
    <%@ include file="/WEB-INF/jspf/header.jspf" %>

    <body class="bg-[#030712] text-white min-h-screen flex flex-col">
        <%@ include file="/WEB-INF/jspf/navBar.jspf" %>

        <div class="container mx-auto px-6 py-6 max-w-[90%]">
            <h1 class="text-3xl font-semibold mb-6 text-center">All Products</h1>

            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                <%
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    NumberFormat currencyFormat = NumberFormat.getInstance(Locale.US); // Format numbers with commas

                    if (products != null && !products.isEmpty()) {
                        for (Product product : products) {
                            int finalPrice = product.getPrice() - (product.getPrice() * product.getDiscount() / 100);
                %>
                <div class="bg-black-75 border-2 backdrop-blur-xs border-gray-600 rounded-lg shadow-lg overflow-hidden group transition-all hover:scale-105 flex flex-col">

                    <div class="relative w-full h-48 bg-gray-800 animate-pulse">
                        <img src="<%= product.getProductImage()%>" alt="<%= product.getProductName()%>"
                             class="w-full h-full object-cover opacity-0 transition-opacity duration-300"
                             onload="this.style.opacity = '1'; this.previousElementSibling.classList.add('hidden');"
                             >
                    </div>

                    <div class="p-4 flex flex-col flex-grow">
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
