<%@page import="model.Account"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <%@ include file="/WEB-INF/jspf/header.jspf" %>
    <body>
        <h1>Account List</h1>

        <%
            List<Account> accounts = (List<Account>) request.getAttribute("accountList");
            if (accounts == null || accounts.isEmpty()) {
        %>
        <p>No accounts found.</p>
        <%
        } else {
        %>
        <table class="border">
            <tr>
                <th>Username</th>
                <th>Full Name</th>
                <th>Phone</th>
                <th>Role</th>
            </tr>
            <%
                for (Account acc : accounts) {
            %>
            <tr>
                <td><%= acc.getAccount()%></td>
                <td><%= acc.getFirstName() + " " + acc.getLastName()%></td>
                <td><%= acc.getPhone()%></td>
                <td><%= acc.getRoleString()%></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            }
        %>
    </body>
</html>
