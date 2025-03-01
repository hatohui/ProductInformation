<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>

<html>
    <%@ include file="/WEB-INF/jspf/header.jspf" %>

    <body class="bg-[#030712] text-white min-h-screen flex flex-col">
        <%@ include file="/WEB-INF/jspf/navBar.jspf" %>

        <div class="container flex flex-grow px-12 py-6 gap-6 overflow-hidden mx-auto max-w-[90%]">

            <div class="flex-grow bg-black-75 p-6 rounded-lg shadow-lg border-2 border-gray-600 backdrop-blur-xs w-3/4 flex flex-col">
                <h1 class="text-3xl font-semibold mb-5">Category List</h1>

                <div class="overflow-auto flex-grow">
                    <table class="w-full border-collapse border border-gray-700 text-left">
                        <thead>
                            <tr class="bg-gray-800 text-white">
                                <th class="p-3 border border-gray-700">ID</th>
                                <th class="p-3 border border-gray-700">Category Name</th>
                                <th class="p-3 border border-gray-700">Memo</th>
                                <th class="p-3 border border-gray-700">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Category> categories = (List<Category>) request.getAttribute("categories");
                                if (categories != null && !categories.isEmpty()) {
                                    for (Category category : categories) {
                            %>
                            <tr class="border border-gray-700">
                                <td class="p-3 border border-gray-700"><%= category.getTypeId()%></td>
                                <td class="p-3 border border-gray-700"><%= category.getCategoryName()%></td>
                                <td class="p-3 border border-gray-700"><%= category.getMemo()%></td>
                                <td class="p-3 border border-gray-700">
                                    <button onclick="openEditModal('<%= category.getTypeId()%>', '<%= category.getCategoryName()%>', '<%= category.getMemo()%>')"
                                            class="text-blue-400 hover:underline mr-3">Edit</button>

                                    <a href="/categories/delete?id=<%= category.getTypeId()%>"
                                       class="text-red-400 hover:underline"
                                       onclick="return confirm('Are you sure you want to delete this category?');">
                                        Delete
                                    </a>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="4" class="text-center p-3 border border-gray-700 text-gray-400">
                                    No categories found.
                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="bg-black-75 p-6 rounded-lg shadow-lg border-2 border-gray-600 backdrop-blur-xs w-1/4">
                <h2 class="text-2xl font-semibold text-center text-white">Create Category</h2>

                <form action="category" method="post" class="mt-4" autocomplete="off">
                    <div class="relative z-0 transition-all mb-4">
                        <input
                            type="text"
                            id="categoryName"
                            name="categoryName"
                            required
                            class="block py-2.5 controlled appearance-none duration-300
                            focus:border-sky-500 focus:outline focus:outline-sky-500
                            disabled:border-gray-200 px-0 w-full text-sm bg-transparent border-0 border-b-2
                            focus:outline-none focus:ring-0 focus:border-green-600
                            peer peer-placeholder-shown:border-gray-500 peer-placeholder-shown:focus:border-sky-500
                            peer-invalid:border-pink-500 peer-invalid:focus:border-pink-500"
                            placeholder=" "
                            />
                        <label
                            class="absolute text-sm text-gray-400 peer-focus:text-sky-500
                            duration-300 transform -translate-y-6 scale-75 top-3 left-0 origin-[0]
                            peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0
                            peer-focus:scale-75 peer-focus:-translate-y-6"
                            for="categoryName"
                            >
                            Category Name<span class="text-rose-600">*</span>
                        </label>
                    </div>

                    <div class="relative z-0 transition-all mb-4">
                        <input
                            type="text"
                            id="memo"
                            name="memo"
                            class="block py-2.5 controlled appearance-none duration-300
                            focus:border-sky-500 focus:outline focus:outline-sky-500
                            disabled:border-gray-200 px-0 w-full text-sm bg-transparent border-0 border-b-2
                            focus:outline-none focus:ring-0 focus:border-green-600 peer"
                            placeholder=" "
                            />
                        <label
                            class="absolute text-sm text-gray-400 peer-focus:text-sky-500
                            duration-300 transform -translate-y-6 scale-75 top-3 left-0 origin-[0]
                            peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0
                            peer-focus:scale-75 peer-focus:-translate-y-6"
                            for="memo"
                            >
                            Memo (Optional)
                        </label>
                    </div>

                    <div class="text-center">
                        <button
                            type="submit"
                            class="relative overflow-hidden group inline-block px-6 py-2 text-white border-2 border-slate-100 rounded-xl text-lg shadow-md transition-all"
                            >
                            <span class="-z-2 bg-slate-100 absolute inset-0 duration-700 ease-out w-0 group-hover:w-full"></span>
                            <span class="group-hover:text-slate-700 duration-200">Create</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <div id="editModal" class="fixed inset-0 bg-black/75 backdrop-blur-xs flex justify-center items-center hidden">
            <div class="bg-black-75 p-6 rounded-lg shadow-lg border-2 border-gray-600 w-[350px]">
                <h2 class="text-2xl font-semibold text-center text-white">Edit Category</h2>

                <form id="editCategoryForm" action="category" method="post" class="mt-4">
                    <input type="hidden" id="editCategoryId" name="categoryId">

                    <!-- Category Name -->
                    <div class="relative z-0 transition-all mb-4">
                        <input
                            type="text"
                            id="editCategoryName"
                            name="editCategoryName"
                            class="block py-2.5 controlled appearance-none duration-300
                            focus:border-sky-500 focus:outline focus:outline-sky-500
                            disabled:border-gray-200 px-0 w-full text-sm bg-transparent border-0 border-b-2
                            focus:outline-none focus:ring-0 focus:border-green-600
                            peer peer-placeholder-shown:border-gray-500 peer-placeholder-shown:focus:border-sky-500
                            peer-invalid:border-pink-500 peer-invalid:focus:border-pink-500"
                            placeholder=" "
                            />
                        <label class="absolute text-sm text-gray-400 peer-focus:text-sky-500
                               duration-300 transform -translate-y-6 scale-75 top-3 left-0 origin-[0]
                               peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0
                               peer-focus:scale-75 peer-focus:-translate-y-6"
                               for="editCategoryName">
                            Category Name
                        </label>
                    </div>

                    <div class="relative z-0 transition-all mb-4">
                        <input
                            type="text"
                            id="editMemo"
                            name="editMemo"
                            class="block py-2.5 controlled appearance-none duration-300
                            focus:border-sky-500 focus:outline focus:outline-sky-500
                            disabled:border-gray-200 px-0 w-full text-sm bg-transparent border-0 border-b-2
                            focus:outline-none focus:ring-0 focus:border-green-600
                            peer peer-placeholder-shown:border-gray-500 peer-placeholder-shown:focus:border-sky-500
                            peer-invalid:border-pink-500 peer-invalid:focus:border-pink-500"
                            placeholder=" "
                            />
                        <label class="absolute text-sm text-gray-400 peer-focus:text-sky-500
                               duration-300 transform -translate-y-6 scale-75 top-3 left-0 origin-[0]
                               peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0
                               peer-focus:scale-75 peer-focus:-translate-y-6"
                               for="editMemo">
                            Memo (Optional)
                        </label>
                    </div>

                    <div class="text-center flex justify-center gap-3">
                        <button type="submit"
                                class="relative overflow-hidden group inline-block px-6 py-2 text-white border-2 border-slate-100 rounded-xl text-lg shadow-md transition-all">
                            <span class="-z-2 bg-slate-100 absolute inset-0 duration-700 ease-out w-0 group-hover:w-full"></span>
                            <span class="group-hover:text-slate-700 duration-200">Save Changes</span>
                        </button>

                        <button type="button" onclick="closeEditModal()"
                                class="relative overflow-hidden group inline-block px-6 py-2 text-red-400 border-2 border-red-400 rounded-xl text-lg shadow-md transition-all">
                            <span class="-z-2 bg-red-400 absolute inset-0 duration-700 ease-out w-0 group-hover:w-full"></span>
                            <span class="group-hover:text-white duration-200">Cancel</span>
                        </button>
                    </div>

                </form>
            </div>
        </div>

        <script>
            function openEditModal(id, name, memo) {
                document.getElementById("editCategoryId").value = id;
                document.getElementById("editCategoryName").value = name;
                document.getElementById("editMemo").value = memo;
                document.getElementById("editModal").classList.remove("hidden");
            }

            function closeEditModal() {
                document.getElementById("editModal").classList.add("hidden");
            }
        </script>

        <div class="fixed inset-0 -z-50 bg-[url('/Public/Images/axiom-pattern.png')] bg-repeat brightness-125 bg-blend-screen"></div>
    </body>
</html>
