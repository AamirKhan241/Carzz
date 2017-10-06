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

@WebServlet(urlPatterns = "/CancelOrder")
public class CancelOrder extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        OrderDAO odao=new OrderDAOImpl();
        Order o=odao.getOrder(Integer.parseInt(req.getParameter("id")));
        
        o.setId(o.getId());
        o.setStatus("Order Cancelled");
        
        odao.update(o);
        
        resp.sendRedirect("Ordered.jsp?id="+o.getTid());
        
    }

    
    
}
