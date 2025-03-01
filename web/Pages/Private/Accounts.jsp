<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Account" %>

<html>
    <%@ include file="/WEB-INF/jspf/header.jspf" %>

    <body class="bg-[#030712] text-white min-h-screen flex flex-col">
        <%@ include file="/WEB-INF/jspf/navBar.jspf" %>

        <div class="container flex flex-grow px-12 py-6 overflow-hidden mx-auto max-w-[90%]">
            <div class="flex-grow bg-black-75 p-6 rounded-lg shadow-lg border-2 border-gray-600 backdrop-blur-xs w-3/4 flex flex-col">
                <h1 class="text-3xl font-semibold mb-5">Account List</h1>

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

        <div class="fixed inset-0 -z-50 bg-[url('/Public/Images/axiom-pattern.png')] bg-repeat brightness-125 bg-blend-screen"></div>
    </body>
</html>
