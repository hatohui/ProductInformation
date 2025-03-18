<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <%@ include file="/WEB-INF/jspf/header.jspf" %>

    <body class="bg-[#030712] text-white min-h-screen flex flex-col">
        <%@ include file="/WEB-INF/jspf/navBar.jspf" %>

        <div class="container flex flex-grow px-12 py-6 gap-6 overflow-hidden mx-auto max-w-[90%]">
            <div class="bg-black-75 p-6 rounded-lg shadow-lg border-2 border-gray-600 backdrop-blur-xs w-1/2 mx-auto">
                <a href="/accounts" class="flex items-center text-gray-400 hover:text-white mb-4">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/>
                    </svg>
                    <span class="ml-2">Back</span>
                </a>

                <h2 class="text-2xl font-semibold text-center text-white">Create New Account</h2>

                <% String errorMessage = (String) request.getAttribute("error"); %>
                <% if (errorMessage != null) {%>
                <div class="text-rose-500 border border-rose-500 p-3 rounded mb-4">
                    <%= errorMessage%>
                </div>
                <% }%>

                <form action="/accounts" method="post" class="mt-4" autocomplete="off" onsubmit="return validateForm()">
                    <div class="relative mb-4">
                        <label for="username" class="block text-sm text-gray-400">Username<span class="text-rose-600">*</span></label>
                        <input type="text" id="username" name="username" required
                               class="block w-full p-2 bg-transparent border border-gray-600 rounded focus:border-sky-500 focus:outline-none"/>
                    </div>

                    <div class="grid grid-cols-2 gap-4">
                        <div class="relative mb-4">
                            <label for="firstName" class="block text-sm text-gray-400">First Name<span class="text-rose-600">*</span></label>
                            <input type="text" id="firstName" name="firstName" required
                                   class="block w-full p-2 bg-transparent border border-gray-600 rounded focus:border-sky-500 focus:outline-none"/>
                        </div>

                        <div class="relative mb-4">
                            <label for="lastName" class="block text-sm text-gray-400">Last Name<span class="text-rose-600">*</span></label>
                            <input type="text" id="lastName" name="lastName" required
                                   class="block w-full p-2 bg-transparent border border-gray-600 rounded focus:border-sky-500 focus:outline-none"/>
                        </div>
                    </div>

                    <div class="relative mb-4">
                        <label for="birthday" class="block text-sm text-gray-400">Birthday<span class="text-rose-600">*</span></label>
                        <input type="date" id="birthday" name="birthday" required
                               class="block w-full p-2 bg-transparent border border-gray-600 rounded text-white focus:border-sky-500 focus:outline-none"/>
                    </div>

                    <div class="mb-4">
                        <label class="block text-sm text-gray-400">Gender<span class="text-rose-600">*</span></label>
                        <div class="flex gap-4 mt-2">
                            <label><input type="radio" name="gender" value="true" required> Male</label>
                            <label><input type="radio" name="gender" value="false"> Female</label>
                        </div>
                    </div>

                    <div class="relative mb-4">
                        <label for="phone" class="block text-sm text-gray-400">Phone<span class="text-rose-600">*</span></label>
                        <input type="text" id="phone" name="phone" required
                               class="block w-full p-2 bg-transparent border border-gray-600 rounded focus:border-sky-500 focus:outline-none"/>
                    </div>

                    <div class="relative mb-4">
                        <label for="role" class="block text-sm text-gray-400">Role<span class="text-rose-600">*</span></label>
                        <div class="relative">
                            <select id="role" name="role" required
                                    class="block w-full p-2 pr-10 bg-transparent border border-gray-600 rounded text-white
                                    focus:border-sky-500 focus:outline-none cursor-pointer custom-select">
                                <option value="" class="bg-slate-950 text-slate-400" disabled selected>Select a role</option>
                                <option value="1" class="bg-slate-950 text-slate-400">Admin</option>
                                <option value="2" class="bg-slate-950 text-slate-400">Manager</option>
                            </select>
                        </div>
                    </div>

                    <div class="relative mb-4">
                        <label for="password" class="block text-sm text-gray-400">Password<span class="text-rose-600">*</span></label>
                        <input type="password" id="password" name="password" required
                               class="block w-full p-2 bg-transparent border border-gray-600 rounded focus:border-sky-500 focus:outline-none"/>
                    </div>

                    <div class="relative mb-4">
                        <label for="password2" class="block text-sm text-gray-400">Retype Password<span class="text-rose-600">*</span></label>
                        <input type="password" id="password2" name="password2" required
                               class="block w-full p-2 bg-transparent border border-gray-600 rounded focus:border-sky-500 focus:outline-none"/>
                    </div>

                    <div id="passwordError" class="text-rose-500 text-sm invisible">Passwords do not match.</div>

                    <div class="text-center mt-4">
                        <button type="submit"
                                class="px-6 py-2 text-white border-2 border-slate-100 rounded-xl text-lg shadow-md transition-all">
                            Create Account
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <div class="fixed inset-0 -z-50 bg-[url('/Public/Images/axiom-pattern.png')] bg-repeat brightness-125 bg-blend-screen"></div>

        <script>
            function validateForm() {
                let password = document.getElementById("password");
                let password2 = document.getElementById("password2");
                let errorElement = document.getElementById("passwordError");

                if (password.value !== password2.value) {
                    errorElement.classList.remove("invisible");

                    password.classList.add("border-rose-500", "text-rose-500");
                    password2.classList.add("border-rose-500", "text-rose-500");

                    return false;
                } else {
                    errorElement.classList.add("invisible");
                    password.classList.remove("border-rose-500", "text-rose-500");
                    password2.classList.remove("border-rose-500", "text-rose-500");

                    return true;
                }
            }
        </script>
    </body>
</html>