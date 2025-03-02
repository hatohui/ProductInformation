<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Account" %>

<html>
    <%@ include file="/WEB-INF/jspf/header.jspf" %>

    <body class="bg-[#030712] text-white min-h-screen flex flex-col">
        <%@ include file="/WEB-INF/jspf/navBar.jspf" %>

        <div class="container flex flex-grow px-12 py-6 overflow-hidden mx-auto max-w-[90%]">
            <div class="flex-grow bg-black-75 p-6 rounded-lg shadow-lg border-2 border-gray-600 backdrop-blur-xs w-3/4 flex flex-col">
                <div class="flex justify-between items-center mb-5">
                    <h1 class="text-3xl font-semibold">Account List</h1>
                    <a href="/accounts/new"
                       class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded-md transition">
                        Create New Account
                    </a>
                </div>

                <div class="overflow-auto flex-grow">
                    <table class="w-full border-collapse border border-gray-700 text-left">
                        <thead>
                            <tr class="bg-gray-800 text-white">
                                <th class="p-3 border border-gray-700">Account</th>
                                <th class="p-3 border border-gray-700">Full Name</th>
                                <th class="p-3 border border-gray-700">Birthday</th>
                                <th class="p-3 border border-gray-700">Gender</th>
                                <th class="p-3 border border-gray-700">Phone</th>
                                <th class="p-3 border border-gray-700">Role</th>
                                <th class="p-3 border border-gray-700">Status</th>
                                <th class="p-3 border border-gray-700">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Account> accounts = (List<Account>) request.getAttribute("accounts");

                                if (accounts != null && !accounts.isEmpty()) {
                                    for (Account acc : accounts) {
                            %>
                            <tr class="border border-gray-700">
                                <td class="p-3 border border-gray-700"><%= acc.getAccount()%></td>
                                <td class="p-3 border border-gray-700"><%= acc.getLastName() + " " + acc.getFirstName()%></td>
                                <td class="p-3 border border-gray-700"><%= acc.getBirthdayString()%></td>
                                <td class="p-3 border border-gray-700"><%= acc.getGenderTitle()%></td>
                                <td class="p-3 border border-gray-700"><%= acc.getPhone()%></td>
                                <td class="p-3 border border-gray-700"><%= acc.getRoleString()%></td>
                                <td class="p-3 border border-gray-700"><%= acc.isIsUse() ? "Active" : "Inactive"%></td>
                                <td class="p-3 border border-gray-700">
                                    <button onclick="openEditModal('<%= acc.getAccount()%>',
                                                    '<%= acc.getLastName()%>',
                                                    '<%= acc.getFirstName()%>',
                                                    '<%= acc.getBirthdayString()%>',
                                                    '<%= acc.isGender()%>',
                                                    '<%= acc.getPhone()%>',
                                                    '<%= acc.isIsUse()%>',
                                                    '<%= acc.getRoleInSystem()%>')"
                                            class="text-blue-400 hover:underline mr-3">Edit</button>

                                    <a href="/accounts/delete?account=<%= acc.getAccount()%>"
                                       class="text-red-400 hover:underline"
                                       onclick="return confirm('Are you sure you want to delete this account?');">
                                        Delete
                                    </a>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="8" class="text-center p-3 border border-gray-700 text-gray-400">
                                    No accounts found.
                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div id="editModal" class="fixed inset-0 bg-black/75 backdrop-blur-xs flex justify-center items-center hidden z-50">
            <div class="bg-black-75 p-6 rounded-lg shadow-lg border-2 border-gray-600 w-[400px] relative">
                <h2 class="text-2xl font-semibold text-center text-white">Edit Account</h2>

                <form id="editAccountForm" action="/accounts/update" method="post" class="mt-4">
                    <input type="hidden" id="editAccountId" name="account">

                    <div class="relative z-0 transition-all mb-4">
                        <input type="text" id="editFirstName" name="firstName"
                               class="block py-2.5 px-2 w-full text-sm bg-transparent border-b-2 border-gray-500 focus:border-green-600 focus:outline-none peer"
                               placeholder=" " />
                        <label for="editFirstName"
                               class="absolute text-sm text-gray-400 peer-focus:text-sky-500 transform -translate-y-6 scale-75 top-3 left-0 peer-placeholder-shown:translate-y-0 peer-placeholder-shown:scale-100 peer-focus:scale-75 peer-focus:-translate-y-6">
                            First Name
                        </label>
                    </div>

                    <div class="relative z-0 transition-all mb-4">
                        <input type="text" id="editLastName" name="lastName"
                               class="block py-2.5 w-full px-2 text-sm bg-transparent border-b-2 border-gray-500 focus:border-green-600 focus:outline-none peer"
                               placeholder=" " />
                        <label for="editLastName"
                               class="absolute text-sm text-gray-400 peer-focus:text-sky-500 transform -translate-y-6 scale-75 top-3 left-0 peer-placeholder-shown:translate-y-0 peer-placeholder-shown:scale-100 peer-focus:scale-75 peer-focus:-translate-y-6">
                            Last Name
                        </label>
                    </div>

                    <div class="relative z-0 transition-all mb-4">
                        <input type="date" id="editBirthday" name="birthday"
                               class="block py-2.5 w-full px-2 text-sm bg-transparent border-b-2 border-gray-500 focus:border-green-600 focus:outline-none peer" />
                        <label for="editBirthday"
                               class="absolute text-sm text-gray-400 peer-focus:text-sky-500 transform -translate-y-6 scale-75 top-3 left-0 peer-placeholder-shown:translate-y-0 peer-placeholder-shown:scale-100 peer-focus:scale-75 peer-focus:-translate-y-6">
                            Birthday
                        </label>
                    </div>

                    <div class="relative z-0 transition-all mb-4">
                        <select id="editGender" name="gender"
                                class="block py-2.5 w-full px-2 text-sm bg-transparent border-b-2 border-gray-500 focus:border-green-600 focus:outline-none peer">
                            <option value="true">Male</option>
                            <option value="false">Female</option>
                        </select>
                        <label for="editGender"
                               class="absolute text-sm text-gray-400 peer-focus:text-sky-500 transform -translate-y-6 scale-75 top-3 left-0 peer-placeholder-shown:translate-y-0 peer-placeholder-shown:scale-100 peer-focus:scale-75 peer-focus:-translate-y-6">
                            Gender
                        </label>
                    </div>

                    <div class="relative z-0 transition-all mb-4">
                        <input type="text" id="editPhone" name="phone"
                               class="block py-2.5 w-full px-2 text-sm bg-transparent border-b-2 border-gray-500 focus:border-green-600 focus:outline-none peer"
                               placeholder=" " />
                        <label for="editPhone"
                               class="absolute text-sm text-gray-400 peer-focus:text-sky-500 transform -translate-y-6 scale-75 top-3 left-0 peer-placeholder-shown:translate-y-0 peer-placeholder-shown:scale-100 peer-focus:scale-75 peer-focus:-translate-y-6">
                            Phone
                        </label>
                    </div>

                    <div class="relative z-0 transition-all mb-4">
                        <select id="editRole" name="role"
                                class="block py-2.5 custom-select w-full px-2 text-sm bg-transparent border-b-2 border-gray-500 focus:border-green-600 focus:outline-none peer">
                            <option value="1" class="bg-black/75">Admin</option>
                            <option value="2" class="bg-black/75">User</option>
                        </select>
                        <label for="editRole"
                               class="absolute text-sm text-gray-400 peer-focus:text-sky-500 transform -translate-y-6 scale-75 top-3 left-0 peer-placeholder-shown:translate-y-0 peer-placeholder-shown:scale-100 peer-focus:scale-75 peer-focus:-translate-y-6">
                            Role
                        </label>
                    </div>

                    <div class="relative z-0 transition-all mb-4">
                        <select id="editStatus" name="status"
                                class="block py-2.5 custom-select w-full px-2 text-sm bg-transparent border-b-2 border-gray-500 focus:border-green-600 focus:outline-none peer">
                            <option value="true" class="bg-black/75">Active</option>
                            <option value="false" class="bg-black/75">Inactive</option>
                        </select>
                        <label for="editStatus"
                               class="absolute text-sm text-gray-400 peer-focus:text-sky-500 transform -translate-y-6 scale-75 top-3 left-0 peer-placeholder-shown:translate-y-0 peer-placeholder-shown:scale-100 peer-focus:scale-75 peer-focus:-translate-y-6">
                            Status
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
            function openEditModal(account, lastName, firstName, birthday, gender, phone, status, role) {
                document.getElementById("editAccountId").value = account;
                document.getElementById("editLastName").value = lastName;
                document.getElementById("editFirstName").value = firstName;
                document.getElementById("editBirthday").value = birthday;
                document.getElementById("editGender").value = gender;
                document.getElementById("editPhone").value = phone;
                document.getElementById("editStatus").value = status;
                document.getElementById("editRole").value = role;
                document.getElementById("editModal").classList.remove("hidden");
            }

            function closeEditModal() {
                document.getElementById("editModal").classList.add("hidden");
            }
        </script>

        <div class="fixed inset-0 -z-50 bg-[url('/Public/Images/axiom-pattern.png')] bg-repeat brightness-125 bg-blend-screen"></div>
    </body>
</html>
