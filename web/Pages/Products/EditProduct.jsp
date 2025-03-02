<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Product, model.Account, model.Category, java.text.NumberFormat, java.util.Locale, java.util.List" %>

<html>
    <%@ include file="/WEB-INF/jspf/header.jspf" %>

    <body class="bg-[#030712] text-white min-h-screen flex flex-col">
        <%@ include file="/WEB-INF/jspf/navBar.jspf" %>

        <div class="flex flex-grow w-full h-full p-8 scrollbar-none">
            <div class="w-full h-full bg-black-75 p-6 rounded-lg shadow-lg border-2 border-gray-600 backdrop-blur-xs overflow-y-auto">
                <a href="/products" class="flex items-center text-gray-400 hover:text-white mb-4">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/>
                    </svg>
                    <span class="ml-2">Back</span>
                </a>

                <h2 class="text-2xl font-semibold text-center text-white">Edit Product</h2>

                <% String errorMessage = (String) request.getAttribute("error"); %>
                <% if (errorMessage != null) {%>
                <div class="text-rose-500 border border-rose-500 p-3 rounded mb-4">
                    <%= errorMessage%>
                </div>
                <% } %>

                <% Product product = (Product) request.getAttribute("product"); %>
                <% Account user = (Account) request.getSession().getAttribute("user");%>
                <form action="/products" method="post" class="mt-4" onsubmit="return validateForm()">
                    <input type="hidden" id="productId" name="productId" value="<%= product != null ? product.getProductId() : ""%>" />

                    <div class="relative mb-4">
                        <label for="productName" class="block text-sm text-gray-400">Product Name<span class="text-rose-600">*</span></label>
                        <input type="text" id="productName" name="productName" required
                               class="block w-full p-2 bg-transparent border border-gray-600 rounded focus:border-sky-500 focus:outline-none placeholder-gray-500"
                               value="<%= product != null ? product.getProductName() : ""%>"
                               placeholder="e.g., Premium Coffee Beans"/>
                    </div>

                    <div class="relative mb-4">
                        <label for="brief" class="block text-sm text-gray-400">Description<span class="text-rose-600">*</span></label>
                        <textarea id="brief" name="brief" rows="3" required
                                  class="block w-full p-2 bg-transparent border border-gray-600 rounded focus:border-sky-500 focus:outline-none placeholder-gray-500"
                                  placeholder="e.g., High-quality coffee from Vietnam"><%= product != null ? product.getBrief() : ""%></textarea>
                    </div>

                    <div class="grid grid-cols-2 gap-4">
                        <div class="relative mb-4">
                            <label for="price" class="block text-sm text-gray-400">Price (VND)<span class="text-rose-600">*</span></label>
                            <div class="relative">
                                <input type="number" id="price" name="price" min="0" step="1000" required
                                       class="block w-full p-2 bg-transparent border border-gray-600 rounded focus:border-sky-500 focus:outline-none text-right placeholder-gray-500 appearance-none"
                                       value="<%= product != null ? product.getPrice() : ""%>"
                                       placeholder="100000"/>
                                <span class="absolute right-2 top-1/2 transform -translate-y-1/2 text-gray-400">₫</span>
                            </div>
                        </div>
                        <div class="relative mb-4">
                            <label for="discount" class="block text-sm text-gray-400">Discount (%)<span class="text-rose-600">*</span></label>
                            <div class="relative">
                                <input type="number" id="discount" name="discount" min="0" max="100" step="1"
                                       class="block w-full p-2 bg-transparent border border-gray-600 rounded focus:border-sky-500 focus:outline-none text-right placeholder-gray-500 appearance-none"
                                       value="<%= product != null ? product.getDiscount() : ""%>"
                                       placeholder="10"/>
                                <span class="absolute right-2 top-1/2 transform -translate-y-1/2 text-gray-400">%</span>
                            </div>
                        </div>
                    </div>

                    <div class="relative mb-4">
                        <label for="productImage" class="block text-sm text-gray-400">Product Image Path<span class="text-rose-600">*</span></label>
                        <input type="text" id="productImage" name="productImage" required
                               class="block w-full p-2 bg-transparent border border-gray-600 rounded focus:border-sky-500 focus:outline-none placeholder-gray-500"
                               value="<%= product != null ? product.getProductImage() : ""%>"
                               placeholder="e.g., /images/product.jpg"/>
                    </div>

                    <div class="grid grid-cols-2 gap-4">
                        <div class="relative mb-4">
                            <label for="unit" class="block text-sm text-gray-400">Unit<span class="text-rose-600">*</span></label>
                            <input type="text" id="unit" name="unit" required
                                   class="block w-full p-2 bg-transparent border border-gray-600 rounded focus:border-sky-500 focus:outline-none placeholder-gray-500"
                                   value="<%= product != null ? product.getUnit() : ""%>"
                                   placeholder="e.g., kg"/>
                        </div>
                        <div class="relative mb-4">
                            <label for="typeId" class="block text-sm text-gray-400">Category<span class="text-rose-600">*</span></label>
                            <select id="typeId" name="typeId" required
                                    class="block w-full p-2 pr-8 bg-transparent border border-gray-600 rounded text-white focus:border-sky-500 focus:outline-none cursor-pointer appearance-none placeholder-gray-500">
                                <option value="" class="bg-slate-800" disabled>Select a category</option>
                                <%
                                    List<Category> categories = (List<Category>) session.getAttribute("categories");
                                    if (categories != null) {
                                        for (Category category : categories) {
                                            String selected = (product != null && category.getTypeId() == product.getTypeId()) ? "selected" : "";
                                %>
                                <option value="<%= category.getTypeId()%>" class="bg-slate-800" <%= selected%>><%= category.getCategoryName()%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                            <span class="absolute right-2 top-1/2 transform -translate-y-1/2 pointer-events-none text-gray-400">▼</span>
                        </div>
                    </div>

                    <input type="hidden" id="account" name="account" value="<%= user != null ? user.getAccount() : product != null ? product.getAccount() : ""%>"/>

                    <div class="text-center mt-4">
                        <button type="submit"
                                class="px-6 py-2 text-white border-2 border-slate-100 rounded-xl text-lg shadow-md transition-all">
                            Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <div class="fixed inset-0 -z-50 bg-[url('/Public/Images/axiom-pattern.png')] bg-repeat brightness-125 bg-blend-screen"></div>

        <script>
            function validateForm() {
                const price = document.getElementById("price").value;
                const discount = document.getElementOfId("discount").value;

                if (price < 0) {
                    alert("Price cannot be negative.");
                    return false;
                }

                if (discount < 0 || discount > 100) {
                    alert("Discount must be between 0% and 100%.");
                    return false;
                }

                return true;
            }

            document.getElementById("price").addEventListener("input", function (e) {
                let value = e.target.value.replace(/\D/g, '');
                e.target.value = value;
            });
        </script>
    </body>
</html>