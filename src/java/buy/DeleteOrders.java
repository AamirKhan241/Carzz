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
import transaction.TransactionDAO;
import transaction.TransactionDAOImpl;

@WebServlet(urlPatterns = "/DeleteOrders")
public class DeleteOrders extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        OrderDAO odao=new OrderDAOImpl();
        
        Order o=odao.getOrder(Integer.parseInt(req.getParameter("id")));
        
        TransactionDAO tdao=new TransactionDAOImpl();
        odao.delete(o.getId());
        tdao.delete(o.getTid());
        
        resp.sendRedirect("Orders.jsp");
    }
    
    
}
