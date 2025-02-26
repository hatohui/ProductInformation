package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("Authentication Filter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        Account user = (session != null) ? (Account) session.getAttribute("user") : null;
        String path = httpRequest.getServletPath();

        if (path.startsWith("/Public") || path.equals("/favicon.ico")) {
            chain.doFilter(request, response);
            return;
        }

        if (user == null && !httpRequest.getRequestURI().contains("/login")) {
            httpResponse.sendRedirect("/login");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        System.out.println("Authentication Filter destroyed");
    }
}
