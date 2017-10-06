package buy;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import newcar.NewCar;
import newcar.NewCarDAO;
import newcar.NewCarDAOImpl;
import order.Order;
import order.OrderDAO;
import order.OrderDAOImpl;
import profile.Profile;
import profile.ProfileDAO;
import profile.ProfileDAOImplement;
import transaction.Transaction;
import transaction.TransactionDAO;
import transaction.TransactionDAOImpl;

@WebServlet(urlPatterns = "/BuyCar")
public class PlaceOrder extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getParameter("bank").equalsIgnoreCase("--Choose bank--")){
            req.setAttribute("error", "<script> alert('Choose bank');</script>");
            RequestDispatcher rd =req.getRequestDispatcher("BuyCar.jsp");
            rd.forward(req, resp);
        }else{
            System.out.println("Buying car");
            try {
                NewCarDAO ndao=new NewCarDAOImpl();
                NewCar c=ndao.getCar(Integer.parseInt(req.getParameter("id")));

                Transaction t=new Transaction();
                ProfileDAO pdao=new ProfileDAOImplement();
                Profile p=pdao.getProfiles(req.getSession().getAttribute("user").toString());

                t.setBank(req.getParameter("bank"));
                t.setCard(req.getParameter("card"));
                t.setCvv(req.getParameter("cvv"));
                t.setExpiry(req.getParameter("exp"));
                t.setHolder(req.getParameter("holder"));
                t.setAmount(String.valueOf(c.getPrice()));
                t.setBid(p.getId());

                TransactionDAO tdao=new TransactionDAOImpl();

                tdao.insert(t);

                t=tdao.getTransactionL();        
                t=tdao.getTransaction(t.getId());
                Order o=new Order();
                OrderDAO odao=new OrderDAOImpl();

                o.setBid(t.getBid());
                o.setSid(c.getSuppID());
                o.setPid(c.getId());
                o.setTid(t.getId());
                o.setStatus("ORDER PLACED");

                odao.insert(o);
                resp.sendRedirect("Ordered.jsp?id="+t.getId());
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect("Unauthorised.jsp");
            }        
        }
        
    }    
}
