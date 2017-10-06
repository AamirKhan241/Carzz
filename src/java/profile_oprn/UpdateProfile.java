package profile_oprn;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import profile.Profile;
import profile.ProfileDAO;
import profile.ProfileDAOImplement;
import company.Company;
import company.CompanyDAO;
import company.CompanyDAOImpl;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import supplier.Supplier;
import supplier.SupplierDAO;
import supplier.SupplierDAOImpl;

@WebServlet(urlPatterns = "/UpdateProfile")
@MultipartConfig( maxFileSize = 2 * 1024 * 1024 , maxRequestSize = 20 * 1024 * 1024 )
public class UpdateProfile extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProfileDAO pdao=new ProfileDAOImplement();
        Profile p=pdao.getProfiles(Integer.parseInt(req.getParameter("id")));
        String pRole=p.getRole();
        
        p.setId(Integer.parseInt(req.getParameter("id")));
        p.setfName(req.getParameter("UfName"));
        p.setlName(req.getParameter("UlName"));
        p.setDOB(req.getParameter("UDOB"));
        p.setGender(req.getParameter("Ugender"));
        p.setPassword(req.getParameter("Upassword"));

        if(req.getParameter("Urole").equals("Choose one of the below...")){
            p.setRole("Buyer");
        }else{
            p.setRole(req.getParameter("Urole"));
        }
        
        p.setContact(req.getParameter("Ucontact"));
        p.setAddress(req.getParameter("Uaddress"));
        
        if(pdao.update(p)){
            System.out.println("Updated");
            if(req.getParameter("Urole").equals("SUPPLIER") && !req.getParameter("Urole").equals(pRole) ){
                System.out.println("new supplier");
                
                Company c;
                System.out.println("Adding Company Details");
                CompanyDAO cdao=new CompanyDAOImpl();
                if(req.getParameter("UcName").equals("Other...")){
                    c=new Company();
                    System.out.println("inserting company");
                    c.setName(req.getParameter("UncName"));
                    c.setDescription(req.getParameter("UncDetail"));
                    
                    Part i=req.getPart("Uncimg");
                    byte b[]= new byte[i.getInputStream().available()];
                    i.getInputStream().read(b);
                    File f=new File(this.getServletContext().getRealPath("/")+"/image.jpg") ;

                    FileOutputStream fout=new FileOutputStream(f);
                    fout.write(b);
                    fout.close();

                    Cloudinary cld=new Cloudinary(ObjectUtils.asMap("cloud_name","bhooooot","api_key","444557635596948","api_secret","kUBMvq3oH2ZaZKcWMJrieiV0N2E"));
                    Map uploadResult=cld.uploader().upload(f, ObjectUtils.emptyMap());

                    c.setImage(String.valueOf(uploadResult.get("secure_url")));
                    
                    cdao.insert(c);
                    System.out.println("Company Inserted...");
                    c=cdao.getCompany(req.getParameter("UncName"));
                }else
                    c=cdao.getCompany(req.getParameter("UcName"));

                SupplierDAO sdao=new SupplierDAOImpl();
                Supplier s=new Supplier();
                
                p=pdao.getProfiles(req.getParameter("Uemail"));

                s.setcId(c.getId());
                s.setsId(p.getId());

                sdao.insert(s);
            }else if(req.getParameter("Urole").equals("SUPPLIER") && req.getParameter("Urole").equals(pRole) ){
                System.out.println("Old Supplier");
                p=pdao.getProfiles(req.getParameter("Uemail"));
                
                SupplierDAO sdao=new SupplierDAOImpl();
                Supplier s=sdao.getSupplierS(p.getId());
                
                CompanyDAO cdao=new CompanyDAOImpl();
                Company c=cdao.getCompany(req.getParameter("UcName"));
                if( c.getId() != s.getcId()){
                    System.out.println("Company Changed");
                    s.setcId(c.getId());
                    sdao.update(s);
                }
                
            }else{
                SupplierDAO sdao=new SupplierDAOImpl();
                sdao.deleteS(Integer.parseInt(req.getParameter("id")));
            }
            if(req.getSession().getAttribute("role").toString().equals("ADMINISTRATOR"))
            {
                req.setAttribute("error", "<script>alert('Profile Updated');</script>");
                RequestDispatcher rd=req.getRequestDispatcher("ViewProfiles.jsp");
                rd.forward(req, resp);
            }
            else{
                req.setAttribute("error", "<script>alert('Profile Updated');</script>");
                RequestDispatcher rd=req.getRequestDispatcher("index.jsp");
                rd.forward(req, resp);
            }
        }else{
            System.out.println("Error found");
            resp.sendRedirect("");
        }                
    }    
}