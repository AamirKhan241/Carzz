package profile_oprn;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/LogOut")
public class LogOut extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().removeAttribute("user");
        req.getSession().removeAttribute("password");
        req.getSession().removeAttribute("role");
        req.getSession().removeAttribute("name");
        
        resp.sendRedirect("index.jsp");
    }
    
    
    
}
