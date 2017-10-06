package supplier_oprn;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import company.Company;
import company.CompanyDAO;
import company.CompanyDAOImpl;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import supplier.Supplier;
import supplier.SupplierDAO;
import supplier.SupplierDAOImpl;

@WebServlet(urlPatterns = "/UpdateSupplier")
@MultipartConfig(fileSizeThreshold = 5*1024*1024,maxFileSize = 20*1024*1024,maxRequestSize = 5*1024*1024)
public class UpdateSupplier extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SupplierDAO sdao=new SupplierDAOImpl();
        Supplier s=sdao.getSupplier(Integer.parseInt(req.getParameter("id")));
        
        CompanyDAO cdao=new CompanyDAOImpl();
        Company c=cdao.getCompany(req.getParameter("Ucname"));
        
        if(c.getId() == s.getcId()){
            System.out.println("Not changed");
            resp.sendRedirect("SupplierDetails.jsp");
        }else if( req.getParameter("Ucname").equals("Other...")){
            System.out.println("Other");
            c.setName(req.getParameter("Ucnname"));
            c.setDescription(req.getParameter("Ucndesc"));
            
            Part p=req.getPart("Ucimg");
            byte b[]= new byte[p.getInputStream().available()];
            p.getInputStream().read(b);
            File f=new File(this.getServletContext().getRealPath("/")+"/image.jpg") ;
            
            FileOutputStream fout=new FileOutputStream(f);
            fout.write(b);
            fout.close();

            Cloudinary cld=new Cloudinary(ObjectUtils.asMap("cloud_name","bhooooot","api_key","444557635596948","api_secret","kUBMvq3oH2ZaZKcWMJrieiV0N2E"));
                    Map uploadResult=cld.uploader().upload(f, ObjectUtils.emptyMap());

            System.out.println(uploadResult.get("secure_url"));

            c.setImage(String.valueOf(uploadResult.get("secure_url")));

            cdao.insert(c);
            
            resp.sendRedirect("SupplierDetails.jsp");
        }else{
            System.out.println("Changes");
            c=cdao.getCompany(req.getParameter("Ucname"));
            s.setcId(c.getId());
            s.setId(Integer.parseInt(req.getParameter("id")));
            sdao.update(s);
            resp.sendRedirect("SupplierDetails.jsp");
        }
//        System.out.println(req.getParameter("id"));
//        System.out.println(req.getParameter("Ucname"));
//        System.out.println(req.getParameter("Uccname"));
//        System.out.println(req.getParameter("Uccdesc"));
        
    }
    
    
    
}
