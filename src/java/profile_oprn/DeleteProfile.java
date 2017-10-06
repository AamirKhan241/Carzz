package profile_oprn;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import newcar.NewCarDAO;
import newcar.NewCarDAOImpl;
import order.OrderDAO;
import order.OrderDAOImpl;
import profile.Profile;
import profile.ProfileDAO;
import profile.ProfileDAOImplement;
import supplier.Supplier;
import supplier.SupplierDAO;
import supplier.SupplierDAOImpl;
import transaction.TransactionDAO;
import transaction.TransactionDAOImpl;


@WebServlet(urlPatterns = "/DeleteProfile")
@MultipartConfig(fileSizeThreshold = 5*1024*1024,maxFileSize = 20*1024*1024,maxRequestSize = 5*1024*1024)
public class DeleteProfile extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        ProfileDAO pdao=new ProfileDAOImplement();
        
        Profile p=pdao.getProfiles(Integer.parseInt(req.getParameter("id")));
        
        
        
        //deleting order
        OrderDAO odao=new OrderDAOImpl();
        odao.deleteS(Integer.parseInt(req.getParameter("id")));
        
        //deleting transaction
        TransactionDAO tdao=new TransactionDAOImpl();
        tdao.deleteB(Integer.parseInt(req.getParameter("id")));
        
        //deleting cars
        NewCarDAO ndao=new NewCarDAOImpl();
        ndao.deleteS(Integer.parseInt(req.getParameter("id")));
        
        if(p.getRole().equals("SUPPLIER")){
            //deleting supplier details
            SupplierDAO sdao=new SupplierDAOImpl();
            Supplier s=sdao.getSupplierS(Integer.parseInt(req.getParameter("id")));
            sdao.deleteS(Integer.parseInt(req.getParameter("id")));
        }
        
        if(pdao.delete(Integer.parseInt(req.getParameter("id"))))
        {
            System.out.println("Deleted");
        }else{
            System.out.println("Error Found");
        }
      
        
        if(req.getSession().getAttribute("role").toString().equals("ADMINISTRATOR") && !req.getSession().getAttribute("user").toString().equalsIgnoreCase(p.getEmail())){
            
            resp.sendRedirect("ViewProfiles.jsp");
        }
        else{
            req.getSession().removeAttribute("user");
            req.getSession().removeAttribute("password");
            req.getSession().removeAttribute("role");
            req.getSession().removeAttribute("name");
            req.setAttribute("error", "<script>alert('Your Profile is Deleted');</script>");
            RequestDispatcher rq=req.getRequestDispatcher("index.jsp");
            rq.forward(req, resp);
        }
    }
}
