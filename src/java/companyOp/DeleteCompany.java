package companyOp;

import company.CompanyDAO;
import company.CompanyDAOImpl;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/DeleteCompany")
public class DeleteCompany extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CompanyDAO cdao=new CompanyDAOImpl();
        cdao.delete(Integer.parseInt(req.getParameter("id")));
        resp.sendRedirect("ViewCompany.jsp");
    }
    
    
}
