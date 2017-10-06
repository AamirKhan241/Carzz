package category;


import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class CategoryDAOImpl implements CategoryDAO{
    @Override
    public void insert(Category c) {        
        InputStream inputStream = null; // input stream of the upload file
            
            try{
                Connection conn=database.Database.getInstance().getConnection();
                
                PreparedStatement ps = conn.prepareStatement("insert into category(Car_category,description,image) values(?,?,?)");
                ps.setString(1, c.getCategory_Name());
                ps.setString(2, c.getDescription());
                ps.setString(3, c.getImage());
                
                int s = ps.executeUpdate();
                if(s>0) 
                    System.out.println("Uploaded successfully !");
                else 
                    System.out.println(" nooo :( !");
            }
            catch(Exception e)
            {
                System.out.println(e.getMessage());
                e.printStackTrace();
            }

    }

    @Override
    public void delete(int id) {
        try {
            Connection conn=database.Database.getInstance().getConnection();
            String query="delete from category where id="+id;
            
            PreparedStatement ps=conn.prepareStatement(query);
            ps.executeUpdate();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Deleted");

    }

    @Override
    public void update(Category c) {
        
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps;
            if(c.getImage().equals("")){
                System.out.println("Image not Found");
                ps=conn.prepareStatement("update CATEGORY set Car_category='"+c.getCategory_Name()+"',description='"+c.getDescription()+"' where id="+c.getId());
            }else{
                ps=conn.prepareStatement("update CATEGORY set Car_category='"+c.getCategory_Name()+"',description='"+c.getDescription()+"',image=? where id="+c.getId());
                ps.setString(1,c.getImage());
            }
            
            int s = ps.executeUpdate();
            if(s>0) 
                System.out.println("Uploaded successfully !");
            else 
                System.out.println(" nooo :( !");

            
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Category getCategory(int id) {
       Category c=new Category();
        
        try {
            
            Connection conn=database.Database.getInstance().getConnection();
            String query="SELECT * FROM CATEGORY where id="+id+" order by car_category";
            PreparedStatement ps=conn.prepareStatement(query);
            
            ResultSet rs=ps.executeQuery();
             int i=0;
            while (rs.next()) {                
                c.setId(rs.getInt(1));
                c.setCategory_Name(rs.getString(2));
                c.setDescription(rs.getString(3));     
                c.setImage(rs.getString(4));
            }            
        } catch (Exception e) {
            e.printStackTrace();
        }
            
        return c;
    }

    @Override
    public List<Category> getCategory() {
        List<Category> list=new ArrayList<Category>();
        
        try {
            
            Connection conn=database.Database.getInstance().getConnection();
            String query="SELECT * FROM CATEGORY";
            PreparedStatement ps=conn.prepareStatement(query);
            
            ResultSet rs=ps.executeQuery();
             int i=0;
            while (rs.next()) {
                Category c=new Category();
                
                c.setId(rs.getInt(1));
                c.setCategory_Name(rs.getString(2));
                c.setDescription(rs.getString(3));     
                c.setImage(rs.getString(4));
                list.add(c);                
            }            
        } catch (Exception e) {
            e.printStackTrace();
        }
            
        return list;
    }

    @Override
    public Category getCategory(String name) {
        Category c=new Category();
        
        try {
            
            Connection conn=database.Database.getInstance().getConnection();
            String query="SELECT id FROM CATEGORY where car_category like '"+name+"'";
            PreparedStatement ps=conn.prepareStatement(query);
            
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {                
                c.setId(rs.getInt(1));
                return c;
            }            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }
}
        