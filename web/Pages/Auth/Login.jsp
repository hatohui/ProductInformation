<%@ page contentType="text/html;charset=UTF-8" %>
<% String errorMessage = (String) request.getAttribute("loginError"); %>
<% String username = (String) request.getAttribute("lastInputUsername"); %>
<% String password = (String) request.getAttribute("lastInputPassword");%>


<html>
    <%@ include file="/WEB-INF/jspf/header.jspf" %>

    <body
        class="w-screen h-screen flex justify-center items-center overflow-hidden bg-linear-to-b from-[#0a8f63] via-[#5dcc6c] to-[#63c947]"
        >
        <form
            id="loginForm"
            action="login"
            method="post"
            class="container max-w-[400px] bg-white flex border-none flex-col px-6 py-8 gap-2 border-2 shadow-md rounded-xl"
            >
            <p class="text-2xl text-center font-semibold">Log in</p>
            <% if (errorMessage != null) {%>
            <p id="errorMessage" class="text-red-500 text-center text-sm"><%= errorMessage%></p>
            <% }%>
            <div>
                <div class="relative z-0 transition-all m-2">
                    <input
                        type="text"
                        name="username"
                        id="username"
                        value="<%= username == null ? "" : username%>"
                        class="<%= errorMessage != null ? "border-pink-500" : "border-slate-950"%>
                        block py-2.5 text-slate-950 controlled appearance-none invalid:border-pink-500 duration-300
                        focus:border-sky-500 focus:outline focus:outline-sky-500
                        focus:invalid:border-pink-500 focus:invalid:outline-pink-500
                        disabled:border-gray-200 px-0 w-full text-sm bg-transparent border-0 border-b-2
                        appearance-none focus:outline-none focus:ring-0 focus:border-green-600 peer"
                        placeholder=" "
                        autocomplete="username"
                        />
                    <label
                        class="<%= errorMessage != null ? "text-pink-600" : "text-slate-950"%> absolute text-sm peer-focus:text-sky-500
                        invalid:text-pink-600 duration-300 transform -translate-y-6
                        scale-75 top-3 z-10 origin-[0] peer-focus:start-0 peer-placeholder-shown:scale-100
                        peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6
                        rtl:peer-focus:translate-x-1/4 rtl:peer-focus:left-auto" for="username"
                        >username <span class="text-rose-500">*</span></label
                    >
                </div>
                <div class="relative z-0 appearance-none transition-all m-2 mt-8">
                    <input
                        type="password"
                        name="password"
                        value="<%= password == null ? "" : password%>"
                        required
                        minlength="3"
                        class="block py-2.5 <%= errorMessage != null ? "border-pink-500" : "border-slate-950"%> controlled duration-300 focus:border-sky-500 focus:outline focus:outline-sky-500 focus:invalid:border-pink-500 focus:invalid:outline-pink-500 disabled:border-gray-200 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 focus:outline-none focus:ring-0 focus:border-green-600 peer"
                        placeholder=" "
                        autocomplete="current-password"
                        id="password"
                        />
                    <label
                        class="<%= errorMessage != null ? "text-pink-600" : "text-slate-950"%> absolute text-sm peer-focus:text-sky-500 invalid:text-pink-600 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6 rtl:peer-focus:translate-x-1/4 rtl:peer-focus:left-auto"
                        for="password">password <span class="text-rose-500">*</span></label
                    >
                </div>
            </div>
            <div class="flex justify-between p-2 items-center truncate">
                <div class="flex items-center w-1/2 space-x-2">
                    <input type="checkbox" name="remember" id="remember" class="text-sm align-middle" />
                    <label for="remember" class="select-none text-sm text-gray-600 truncate">
                        remember me
                    </label>
                </div>
                <p class="text-sm text-right text-blue-500 hover:underline truncate">
                    Forgot password?
                </p>
            </div>


            <button
                type="submit"
                class="group border-slate-600 px-10 py-2 border-2 rounded-xl duration-300 hover:scale-[102%] m-auto transition-all hover:bg-gradient-to-b from-[#5dcc6c] to-[#63c947]"
                >
                <span
                    class="group-hover:text-slate-100 z-10 text-slate-600 font-bold select-none duration-200"
                    >login</span
                >
            </button>
            <p class="mt-3 mx-2 text-sm text-gray-600 text-center truncate">
                New user?
                <a
                    href="/register"
                    class="text-blue-600 hover:underline hover:text-blue-700 transition"
                    >
                    Register an account instead
                </a>
            </p>
        </form>
        <%@include file="/WEB-INF/jspf/background.jspf" %>
        <div id="loadingOverlay" class="hidden absolute inset-0 bg-gray-100 bg-opacity-80 flex items-center justify-center transition-opacity duration-300 opacity-0">
            <div class="w-12 h-12 border-4 border-gray-300 border-t-blue-500 rounded-full animate-spin"></div>
        </div>
    </body>
</html>

<% request.removeAttribute("loginError"); %>
<% request.removeAttribute("lastInputUsername"); %>
<% request.removeAttribute("lastInputPassword");%>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const inputs = document.querySelectorAll(".controlled");
        const message = document.querySelector("#errorMessage");

        inputs.forEach(input => {
            let hasTyped = false;

            input.addEventListener("input", function () {
                if (!hasTyped) {
                    hasTyped = true;
                    this.classList.remove("border-pink-500");
                    this.classList.add("border-slate-950");
                    const label = document.querySelector("label[for='" + this.name + "']");
                    if (label) {
                        label.classList.remove("text-pink-600");
                        label.classList.add("text-slate-950");
                    }

                    if (message) {
                        message.remove();
                    }
                }
            });

        });
    });

    document.getElementById("loginForm").addEventListener("submit", function () {
        const overlay = document.getElementById("loadingOverlay");
        overlay.classList.remove("hidden");
        setTimeout(() => overlay.classList.remove("opacity-0"), 10);
    });

    window.addEventListener("pageshow", function (event) {
        if (event.persisted) {
            window.location.reload();
        }
    });

</script>