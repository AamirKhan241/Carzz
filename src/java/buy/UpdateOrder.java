package buy;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import order.Order;
import order.OrderDAO;
import order.OrderDAOImpl;

@WebServlet(urlPatterns = "/UpdateOrder")
public class UpdateOrder extends  HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        OrderDAO odao=new OrderDAOImpl();
        
        Order o=new Order();
        
        o.setId(Integer.parseInt(req.getParameter("id")));
        o.setStatus(req.getParameter("status"));
        
        odao.update(o);
        
        resp.sendRedirect("Orders.jsp");
    }
    
    
    
    
}
