<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Product, model.Category, java.text.NumberFormat, java.util.Locale, java.util.List" %>

<html>
    <%@ include file="/WEB-INF/jspf/header.jspf" %>

    <body class="bg-[#030712] text-white min-h-screen flex flex-col">
        <%@ include file="/WEB-INF/jspf/navBar.jspf" %>

        <div class="container mx-auto px-6 py-6 max-w-[90vw] h-[calc(100vh-80px)] flex flex-col justify-center">
            <%
                Product product = (Product) request.getAttribute("product");
                NumberFormat currencyFormat = NumberFormat.getInstance(Locale.US);

                if (product != null) {
                    int finalPrice = product.getPrice() - (product.getPrice() * product.getDiscount() / 100);
                    List<Category> categories = (List<Category>) session.getAttribute("categories");
                    String categoryName = "Unknown";
                    if (categories != null) {
                        for (Category category : categories) {
                            if (category.getTypeId() == product.getTypeId()) {
                                categoryName = category.getCategoryName();
                                break;
                            }
                        }
                    }
            %>

            <div class="mb-4">
                <a href="javascript:history.back()"
                   class="inline-flex items-center gap-2 px-3 py-1 text-sm font-medium text-white bg-gray-700 rounded-md hover:bg-gray-800 transition">
                    ← Back
                </a>
            </div>

            <div class="flex flex-col md:flex-row gap-6 bg-black-75 border border-gray-600 rounded-lg p-6 shadow-lg h-full">
                <div class="relative w-full md:w-[50%] h-full flex items-center justify-center">
                    <div class="w-[90%] h-[80%] bg-gray-800 animate-pulse rounded-lg overflow-hidden">
                        <img src="<%= product.getProductImage()%>" alt="<%= product.getProductName()%>"
                             class="w-full h-full object-cover opacity-0 transition-opacity duration-300"
                             onload="this.style.opacity = '1'; this.previousElementSibling.classList.add('hidden');">
                    </div>
                </div>

                <div class="flex flex-col w-full md:w-[50%] h-full">
                    <h1 class="text-2xl font-bold mb-2"><%= product.getProductName()%></h1>

                    <div class="flex items-center gap-4 text-xl font-bold text-green-400 mb-3">
                        <%= currencyFormat.format(finalPrice)%>đ
                        <% if (product.getDiscount() > 0) {%>
                        <span class="text-sm text-red-400 line-through">
                            <%= currencyFormat.format(product.getPrice())%>đ
                        </span>
                        <% }%>
                    </div>

                    <div class="grid grid-cols-2 text-gray-300 bg-[#111827] rounded-lg p-4 border border-gray-700 text-sm mb-3">
                        <p><span class="font-semibold">Posted:</span> <%= product.getPostedDate()%></p>
                        <p><span class="font-semibold">Unit:</span> <%= product.getUnit()%></p>
                        <p><span class="font-semibold">Category:</span> <%= categoryName%></p>
                        <p><span class="font-semibold">Seller:</span> <%= product.getAccount()%></p>
                    </div>

                    <p class="text-gray-400 text-sm mb-4"><%= product.getBrief()%></p>

                    <div class="mt-auto flex gap-4">
                        <a href="/products/edit?id=<%= product.getProductId()%>"
                           class="inline-flex items-center gap-2 px-4 py-2 text-sm font-medium text-white bg-blue-600 rounded-md hover:bg-blue-700 transition">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                <path d="M17.414 2.586a2 2 0 0 0-2.828 0L8 9.172V12h2.828l6.586-6.586a2 2 0 0 0 0-2.828zM5 14H3v3a1 1 0 0 0 1 1h3v-2H5v-2z" />
                            </svg>
                            Edit Product
                        </a>

                        <div>
                            <a href="/products/delete?id=<%= product.getProductId()%>"
                               onclick="return confirm('Are you sure you want to delete this product?');"
                               class="inline-flex items-center gap-2 px-4 py-2 text-sm font-medium text-white bg-red-600 rounded-md hover:bg-red-700 transition">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M6 8a1 1 0 0 1 1-1h6a1 1 0 1 1 0 2H7a1 1 0 0 1-1-1zm1 4a1 1 0 0 1 1-1h4a1 1 0 1 1 0 2H8a1 1 0 0 1-1-1zm1 4a1 1 0 0 1 1-1h2a1 1 0 1 1 0 2H9a1 1 0 0 1-1-1z" clip-rule="evenodd" />
                                    <path fill-rule="evenodd" d="M4 3a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v1h3a1 1 0 1 1 0 2h-1v10a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V6H2a1 1 0 1 1 0-2h3V3zm2 3v10h8V6H6z" clip-rule="evenodd" />
                                </svg>
                                Delete Product
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <% } else { %>
            <div class="text-center text-gray-400">
                <p>Product not found.</p>
                <a href="/products" class="text-sky-400 hover:underline">Back to Products</a>
            </div>
            <% }%>
        </div>

        <div class="fixed inset-0 -z-50 bg-[url('/Public/Images/axiom-pattern.png')] bg-repeat brightness-125 bg-blend-screen"></div>
    </body>
</html>