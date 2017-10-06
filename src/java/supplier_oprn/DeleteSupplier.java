package supplier_oprn;

import com.sun.tools.ws.api.WsgenProtocol;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import supplier.SupplierDAO;
import supplier.SupplierDAOImpl;

@WebServlet(urlPatterns = "/DeleteSupplier")
public class DeleteSupplier extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SupplierDAO sdao=new SupplierDAOImpl();
        sdao.delete(Integer.parseInt(req.getParameter("id")));
        
        resp.sendRedirect("SupplierDetails.jsp");
        
    }
    
    
}
