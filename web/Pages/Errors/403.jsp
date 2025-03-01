<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
    <%@ include file="/WEB-INF/jspf/header.jspf" %>
    <body
        class="flex flex-col select-none items-center justify-center h-screen bg-gradient-to-t from-gray-700 to-gray-900"
        >
        <div class="text-center">
            <h1 class="text-9xl font-bold text-red-500 animate-pulse">403</h1>
            <h2 class="text-2xl font-semibold text-gray-300 mt-4">
                Access Denied
            </h2>
            <p class="text-slate-300 mt-2">
                You don't have permission to access this page.
            </p>

            <a
                href="/login"
                class="mt-6 relative overflow-hidden group inline-block px-6 py-3 text-white rounded-xl text-lg shadow-md border-2 transition-all"
                >
                <span
                    class="-z-2 bg-slate-100 absolute inset-0 duration-700 ease-out group-hover:w-full w-0"
                    ></span>
                <span class="group-hover:text-slate-700 duration-200">Login</span>
            </a>
        </div>
        <div class="fixed inset-0 -z-50 bg-[url('/Public/Images/dark-mosaic.png')] bg-repeat brightness-125 bg-blend-screen"></div>
    </body>
</html>
