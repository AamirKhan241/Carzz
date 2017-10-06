
package profile_oprn;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import company.Company;
import company.CompanyDAO;
import company.CompanyDAOImpl;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import profile.Profile;
import profile.ProfileDAO;
import profile.ProfileDAOImplement;
import supplier.Supplier;
import supplier.SupplierDAO;
import supplier.SupplierDAOImpl;


@WebServlet(urlPatterns = "/GoSignUp")
@MultipartConfig(fileSizeThreshold = 5*1024*1024,maxFileSize = 20*1024*1024,maxRequestSize = 5*1024*1024)
public class AddProfile extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {        
        
        Profile p=new Profile();
        
        p.setfName(req.getParameter("fName"));
        p.setlName(req.getParameter("lName"));
        p.setDOB(req.getParameter("DOB"));
        p.setGender(req.getParameter("gender"));
        p.setEmail(req.getParameter("email"));
        p.setPassword(req.getParameter("password"));
        
        if(req.getParameter("role").equals("Choose one of the below..."))
            p.setRole("Buyer");
        else
            p.setRole(req.getParameter("role"));
        

        p.setContact(req.getParameter("contact"));
        p.setAddress(req.getParameter("address"));
        
        ProfileDAO pdao=new ProfileDAOImplement();
        if(pdao.Insert(p)){
            System.out.println("Profile Inserted");
            if(req.getParameter("role").equals("SUPPLIER")){
                System.out.println("Adding Company Details");
                CompanyDAO cdao=new CompanyDAOImpl();
                Company c;
                if(req.getParameter("cName").equals("Other...")){
                    c=new Company();
                    System.out.println("inserting company");
                    c.setName(req.getParameter("ncName"));
                    c.setDescription(req.getParameter("ncDetail"));
                    
                    Part i=req.getPart("ncimg");
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
                    c=cdao.getCompany(req.getParameter("ncName"));
                }
                else
                    c=cdao.getCompany(req.getParameter("cName"));
                
              
                SupplierDAO sdao=new SupplierDAOImpl();
                Supplier s=new Supplier();
                
                p=pdao.getProfiles(req.getParameter("email"));

                s.setcId(c.getId());
                s.setsId(p.getId());
                
                sdao.insert(s);
                
                
                RequestDispatcher rd=req.getRequestDispatcher("index.jsp");
                rd.forward(req, resp);
                
            }
            else
            {
                
                RequestDispatcher rd=req.getRequestDispatcher("index.jsp");
                rd.forward(req, resp);
                
            }
        }else{
            System.out.println("Error found");
            resp.sendRedirect("");
        }        
    }
}