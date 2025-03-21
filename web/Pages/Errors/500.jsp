<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
    <%@ include file="/WEB-INF/jspf/header.jspf" %>
    <body
        class="flex flex-col select-none items-center justify-center h-screen bg-gradient-to-t from-red-600 to-black"
        >
        <div class="text-center">
            <h1 class="text-9xl font-bold text-gray-100 animate-pulse">500</h1>
            <h2 class="text-2xl font-semibold text-gray-300 mt-4">
                Internal Server Error
            </h2>
            <p class="text-slate-300 mt-2">
                Something went wrong on our end. Please try again later.
            </p>

            <a
                href="/"
                class="mt-6 relative overflow-hidden group inline-block px-6 py-3 text-white rounded-xl text-lg shadow-md border-2 border-white transition-all"
                >
                <span
                    class="-z-2 bg-white absolute inset-0 duration-700 ease-out group-hover:w-full w-0"
                    ></span>
                <span class="group-hover:text-red-700 duration-200">Return Home</span>
            </a>
        </div>
        <div class="fixed inset-0 -z-50 bg-[url('/Public/Images/error-pattern.png')] bg-repeat brightness-125 bg-blend-screen"></div>
    </body>
</html>
