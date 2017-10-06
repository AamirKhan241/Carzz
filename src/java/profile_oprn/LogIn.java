package profile_oprn;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import profile.Profile;
import profile.ProfileDAO;
import profile.ProfileDAOImplement;

@WebServlet(urlPatterns = "/LogIn")
public class LogIn extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        boolean log=false;
        ProfileDAO pdao=new ProfileDAOImplement();
        
        List<Profile> list=pdao.getProfiles();
        
        for (Profile profile : list) {
            if(profile.getEmail().equalsIgnoreCase(req.getParameter("Lemail")) && profile.getPassword().equals(req.getParameter("Lpassword"))){
                log=true;                
                req.getSession().setAttribute("user", req.getParameter("Lemail"));
                req.getSession().setAttribute("password", req.getParameter("Lpassword"));
                req.getSession().setAttribute("role", profile.getRole());
                req.getSession().setAttribute("name", profile.getfName());
                break;
            }
        }
        
        if(log){
            System.out.println("LogIn Granted");
            
            RequestDispatcher rd=req.getRequestDispatcher("index.jsp");
            rd.forward(req, resp);
        }else{
            System.out.println("LogIn Denied");
            resp.sendRedirect("Unauthorised.jsp");
        }
        

        
    }
    
}
