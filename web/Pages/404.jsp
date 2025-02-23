<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
    <%@ include file="/WEB-INF/jspf/header.jspf" %>
    <body class="flex flex-col items-center justify-center h-screen bg-gray-100">
        <div class="text-center">
            <h1 class="text-9xl font-bold text-gray-800">404</h1>
            <h2 class="text-2xl font-semibold text-gray-600 mt-4">Oops! Page not found.</h2>
            <p class="text-gray-500 mt-2">The page you're looking for doesn't exist.</p>

            <a href="#" onclick="history.back(); return false;"
               class="mt-6 inline-block px-6 py-3 bg-blue-600 text-white text-lg rounded-lg shadow-md hover:bg-blue-700 transition">
                Return
            </a>
        </div>
    </body>
</html>
