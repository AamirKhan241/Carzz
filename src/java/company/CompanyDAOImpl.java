package company;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CompanyDAOImpl implements CompanyDAO{
    
    @Override
    public void insert(Company c) {
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("insert into Company(name,description,Image) values(?,?,?)");
            System.out.println("Inserting Company");
            ps.setString(1, c.getName());
            ps.setString(2, c.getDescription());
            ps.setString(3, c.getImage());
            ps.executeUpdate();
            System.out.println("Company Inserted");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Company c) {
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps;
            if(c.getImage().equals(""))
                ps=conn.prepareStatement("update Company set name=?,description=? where id="+c.getId());
            else{
                ps=conn.prepareStatement("update Company set name=?,description=?,image=? where id="+c.getId());
                ps.setString(3, c.getImage());
            }
            
            ps.setString(1, c.getName());
            ps.setString(2, c.getDescription());       
            
            ps.executeUpdate();
            System.out.println("Updated");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("delete from Company where id="+id);
            ps.executeUpdate();
            System.out.println("Deleted");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Company getCompany(int id) {
        Company c=new Company();
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("select * from Company where id="+id+" order by NAME");
            
            ResultSet rs=ps.executeQuery();
            
            while (rs.next()) {                
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("Name"));
                c.setDescription(rs.getString("Description"));
                c.setImage(rs.getString("image"));
            }
            return c;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    @Override
    public List<Company> getCompany() {
        List<Company> list=new ArrayList<>();
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("select * from Company order by NAME");
            
            ResultSet rs=ps.executeQuery();
            
            while (rs.next()) {                
                Company c=new Company();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("Name"));
                c.setDescription(rs.getString("Description"));
                c.setImage(rs.getString("image"));
                list.add(c);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }        
        return list;
    }

    @Override
    public Company getCompany(String cName) {
        Company c=new Company();
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("select id from Company where name like '"+cName+"' order by NAME");
            
            ResultSet rs=ps.executeQuery();
            
            while (rs.next()) {                
                c.setId(rs.getInt("id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }
}
