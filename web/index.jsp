<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <%@ include file="/WEB-INF/jspf/header.jspf" %>

    <body class="bg-[#030712] text-white min-h-screen flex flex-col">
        <%@ include file="/WEB-INF/jspf/navBar.jspf" %>

        <div class="flex-grow flex flex-col items-center justify-center text-center px-6">
            <h1 class="text-5xl font-bold mb-4 bg-gradient-to-r from-blue-400 to-purple-500 text-transparent bg-clip-text">
                Product Information Management
            </h1>
            <p class="text-lg text-gray-300 max-w-2xl">
                Effortlessly manage, organize, and optimize your product data in one place.
            </p>
            <div class="mt-6">
                <a href="/products"
                   class="px-6 py-3 bg-blue-500 hover:bg-blue-600 text-white rounded-lg text-lg transition">
                    View Products
                </a>
            </div>
        </div>

        <footer class="text-center py-4 text-gray-500">
            © <%= java.time.Year.now()%> Your Company. All rights reserved.
        </footer>

        <div class="fixed inset-0 -z-50 bg-[url('/Public/Images/axiom-pattern.png')] bg-repeat brightness-125 bg-blend-screen"></div>
    </body>
</html>
