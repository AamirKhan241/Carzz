package companyOp;

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

@WebServlet(urlPatterns = "/AddCompany")
@MultipartConfig(fileSizeThreshold = 5*1024*1024,maxFileSize = 20*1024*1024,maxRequestSize = 5*1024*1024)
public class AddCompany extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if( req.getPart("img").getInputStream().available() == 0 || req.getParameter("name").equals("") || req.getParameter("desc").equals("") )
        {
            req.setAttribute("error", "*All fields are mandatory");
        
            RequestDispatcher rd =req.getRequestDispatcher("AddCompany.jsp");
            rd.forward(req, resp);
        }
        else
        {
            Company c=new Company();
            c.setName(req.getParameter("name"));
            c.setDescription(req.getParameter("desc"));

            Part p=req.getPart("img");
            byte b[]= new byte[p.getInputStream().available()];
            p.getInputStream().read(b);
            File f=new File(this.getServletContext().getRealPath("/")+"/image.jpg") ;

            System.out.println("real path: "+this.getServletContext().getRealPath("/"));
            FileOutputStream fout=new FileOutputStream(f);
            fout.write(b);
            fout.close();

            Cloudinary cld=new Cloudinary(ObjectUtils.asMap("cloud_name","bhooooot","api_key","444557635596948","api_secret","kUBMvq3oH2ZaZKcWMJrieiV0N2E"));
                    Map uploadResult=cld.uploader().upload(f, ObjectUtils.emptyMap());

            System.out.println(uploadResult.get("secure_url"));

            c.setImage(String.valueOf(uploadResult.get("secure_url")));


            CompanyDAO cdao=new CompanyDAOImpl();

            cdao.insert(c);
            resp.sendRedirect("ViewCompany.jsp");
        }
    }    
}
