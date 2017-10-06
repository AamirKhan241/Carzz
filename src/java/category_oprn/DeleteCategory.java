package category_oprn;

import category.CategoryDAO;
import category.CategoryDAOImpl;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/DeleteCategory")
public class DeleteCategory extends HttpServlet{
    
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id=Integer.parseInt(req.getParameter("id"));
        CategoryDAO pdao=new CategoryDAOImpl();
        
        pdao.delete(id);
        
        resp.sendRedirect("ViewCategory.jsp");
    }
    
    
    
}
