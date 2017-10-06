package car_op;

import category.Category;
import category.CategoryDAO;
import category.CategoryDAOImpl;
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
import newcar.NewCar;
import newcar.NewCarDAO;
import newcar.NewCarDAOImpl;
import profile.Profile;
import profile.ProfileDAO;
import profile.ProfileDAOImplement;

@WebServlet(urlPatterns = "/AddNewCar")
@MultipartConfig(fileSizeThreshold = 5*1024*1024,maxFileSize = 20*1024*1024,maxRequestSize = 5*1024*1024)
public class AddNewCar extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    
        NewCar nc=new NewCar();
        ProfileDAO pdao=new ProfileDAOImplement();
        Profile pro=pdao.getProfiles(req.getSession().getAttribute("user").toString());
        nc.setSuppID(pro.getId());
        nc.setName(req.getParameter("nname"));
        nc.setModel(req.getParameter("nmodel"));
        nc.setColor(req.getParameter("ncolor"));
        nc.setSpeed(req.getParameter("nspeed"));
        nc.setSeat(req.getParameter("nseat"));
        nc.setFuel(req.getParameter("nfuel"));
        nc.setFuelCap(req.getParameter("nfuelcap"));
        nc.setTransmission(req.getParameter("ntrans"));
        nc.setPrice(req.getParameter("nrate"));
        nc.setFeature(req.getParameter("nfeature"));        

        Part p=req.getPart("nimg");
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

        nc.setImage(String.valueOf(uploadResult.get("secure_url")));

            CompanyDAO comdao=new CompanyDAOImpl();
            Company com=comdao.getCompany(req.getParameter("ncName"));
        nc.setComID(com.getId());

            CategoryDAO catdao=new CategoryDAOImpl();
            Category cat=catdao.getCategory(req.getParameter("ncategory"));
        nc.setCatID(cat.getId());
        
        NewCarDAO ncdao=new NewCarDAOImpl();
        ncdao.insert(nc);            
        resp.sendRedirect("ViewNewCars.jsp");        
    }    
}
