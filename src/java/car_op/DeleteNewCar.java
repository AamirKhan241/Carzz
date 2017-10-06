package car_op;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import newcar.NewCarDAO;
import newcar.NewCarDAOImpl;

@WebServlet(urlPatterns = "/DeleteNewCar")
public class DeleteNewCar extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NewCarDAO ndao=new NewCarDAOImpl();
        ndao.delete(Integer.parseInt(req.getParameter("id")));
        
        resp.sendRedirect("ViewNewCars.jsp");
    }
    
    
    
}
