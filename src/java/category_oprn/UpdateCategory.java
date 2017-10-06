package category_oprn;

import category.Category;
import category.CategoryDAO;
import category.CategoryDAOImpl;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
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

@WebServlet(urlPatterns = "/updateCat")
@MultipartConfig(fileSizeThreshold = 5*1024*1024,maxFileSize = 20*1024*1024,maxRequestSize = 5*1024*1024)
public class UpdateCategory extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if( req.getParameter("name").equals("") || req.getParameter("desc").equals("") )
        {
            req.setAttribute("error", "Category Name and Description are mandatory");
            
            RequestDispatcher rd =req.getRequestDispatcher("UpdateCategory.jsp");
            rd.forward(req, resp);
        }
        else
        {
            CategoryDAO cdao=new CategoryDAOImpl();

            Category c=new Category();

            c.setId(Integer.parseInt(req.getParameter("id")));
            c.setCategory_Name(req.getParameter("name"));
            c.setDescription(req.getParameter("desc"));



            if(req.getPart("img").getInputStream().available() != 0 )
            {
                System.out.println("Uploading Image...");
                Part p=req.getPart("img");
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
            }else
                c.setImage("");
            cdao.update(c);
            System.out.println("Updated ");

            resp.sendRedirect("ViewCategory.jsp");   
        }
    }
}