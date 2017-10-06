package car_op;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
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

@WebServlet(urlPatterns = "/UpdateNewCar")
@MultipartConfig(fileSizeThreshold = 5*1024*1024,maxFileSize = 20*1024*1024,maxRequestSize = 5*1024*1024)
public class UpdateNewCar extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        NewCar nc=new NewCar();
        nc.setId(Integer.parseInt(req.getParameter("id")));
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

        if(req.getPart("nimg").getInputStream().available() != 0)
        {
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
        }
        
        NewCarDAO ncdao=new NewCarDAOImpl();
        ncdao.update(nc);            
        resp.sendRedirect("ViewNewCars.jsp");        
        
    }    
}
