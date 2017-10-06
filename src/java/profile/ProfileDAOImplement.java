package profile;

import company.CompanyDAO;
import company.CompanyDAOImpl;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProfileDAOImplement implements ProfileDAO{

    private Connection conn;
    @Override
    public boolean Insert(Profile p) {
        try {
            conn=database.Database.getInstance().getConnection();
            String query="insert into PROFILES(FIRST_NAME,LAST_NAME,DOB,GENDER,EMAIL,PASSWORD,ROLE,CONTACT_NUMBER,ADDRESS) VALUES(?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps=conn.prepareStatement(query);
            
            ps.setString(1, p.getfName().toUpperCase());
            ps.setString(2, p.getlName().toUpperCase());
            ps.setString(3, p.getDOB());
            ps.setString(4, p.getGender().toUpperCase());
            ps.setString(5, p.getEmail().toLowerCase());
            ps.setString(6, p.getPassword());
            ps.setString(7, p.getRole());
            ps.setString(8, p.getContact());
            ps.setString(9, p.getAddress().toUpperCase());            
            
            int chk=ps.executeUpdate();
            if(chk>0){
                System.out.println("Inserted into database ");
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    @Override
    public boolean update(Profile p) {
        try {
            conn=database.Database.getInstance().getConnection();
            String query="update PROFILES set FIRST_NAME=?,LAST_NAME=?,DOB=?,GENDER=?,PASSWORD=?,ROLE=?,CONTACT_NUMBER=?,ADDRESS=? where id="+p.getId();
            PreparedStatement ps=conn.prepareStatement(query);
            
            ps.setString(1, p.getfName().toUpperCase());
            ps.setString(2, p.getlName().toUpperCase());
            ps.setString(3, p.getDOB());
            ps.setString(4, p.getGender().toUpperCase());
            ps.setString(5, p.getPassword());
            ps.setString(6, p.getRole());
            ps.setString(7, p.getContact());
            ps.setString(8, p.getAddress().toUpperCase());            
            
            int chk=ps.executeUpdate();
            if(chk>0){
                System.out.println("Inserted into database ");
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        try {
            String role="";
            conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("delete from PROFILES where id="+id);            
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public Profile getProfiles(int id) {
        Profile p=new Profile();
        try {
            conn=database.Database.getInstance().getConnection();
            String query="select * from PROFILES where id="+id+" order by First_NAME";
            PreparedStatement ps=conn.prepareStatement(query);
                        
            ResultSet rs=ps.executeQuery();
            
            while(rs.next()){                
                p.setId(rs.getInt("ID"));
                p.setfName(rs.getString("FIRST_NAME"));
                p.setlName(rs.getString("LAST_NAME"));
                p.setDOB(rs.getString("DOB"));
                p.setGender(rs.getString("GENDER"));
                p.setEmail(rs.getString("EMAIL"));
                p.setPassword(rs.getString("PASSWORD"));
                p.setRole(rs.getString("ROLE"));
                p.setContact(rs.getString("CONTACT_NUMBER"));
                p.setAddress(rs.getString("ADDRESS"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }

    @Override
    public List<Profile> getProfiles() {
        System.out.println("Fetching");
        List<Profile> list=new ArrayList<>();
        try {
            conn=database.Database.getInstance().getConnection();
            String query="select * from PROFILES order by First_NAME";
            PreparedStatement ps=conn.prepareStatement(query);
                        
            ResultSet rs=ps.executeQuery();
            
            while(rs.next()){
                Profile p=new Profile();
                
                p.setId(rs.getInt("ID"));
                p.setfName(rs.getString("FIRST_NAME"));
                p.setlName(rs.getString("LAST_NAME"));
                p.setDOB(rs.getString("DOB"));
                p.setGender(rs.getString("GENDER"));
                p.setEmail(rs.getString("EMAIL"));
                p.setPassword(rs.getString("PASSWORD"));
                p.setRole(rs.getString("ROLE"));
                p.setContact(rs.getString("CONTACT_NUMBER"));
                p.setAddress(rs.getString("ADDRESS"));
                
                list.add(p);
                System.out.println("Added");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Passing");
        return list;
    }

    @Override
    public List<Profile> getSupplier() {
        System.out.println("Fetching");
        List<Profile> list=new ArrayList<>();
        try {
            conn=database.Database.getInstance().getConnection();
            String query="select * from PROFILES WHERE ROLE like 'SUPPLIER' order by First_NAME";
            PreparedStatement ps=conn.prepareStatement(query);
                        
            ResultSet rs=ps.executeQuery();
            
            while(rs.next()){
                Profile p=new Profile();
                
                p.setId(rs.getInt("ID"));
                p.setfName(rs.getString("FIRST_NAME"));
                p.setlName(rs.getString("LAST_NAME"));
                p.setDOB(rs.getString("DOB"));
                p.setGender(rs.getString("GENDER"));
                p.setEmail(rs.getString("EMAIL"));
                p.setPassword(rs.getString("PASSWORD"));
                p.setRole(rs.getString("ROLE"));
                p.setContact(rs.getString("CONTACT_NUMBER"));
                p.setAddress(rs.getString("ADDRESS"));
                
                list.add(p);
                System.out.println("Added");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Passing");
        return list;
    }

    @Override
    public Profile getProfiles(String email) {
        Profile p=new Profile();
        try {
            conn=database.Database.getInstance().getConnection();
            String query="select * from PROFILES where email like '"+email+"' order by First_NAME";
            PreparedStatement ps=conn.prepareStatement(query);
                        
            ResultSet rs=ps.executeQuery();
            
            while(rs.next()){                
                p.setId(rs.getInt("ID"));
                p.setfName(rs.getString("FIRST_NAME"));
                p.setlName(rs.getString("LAST_NAME"));
                p.setDOB(rs.getString("DOB"));
                p.setGender(rs.getString("GENDER"));
                p.setEmail(rs.getString("EMAIL"));
                p.setPassword(rs.getString("PASSWORD"));
                p.setRole(rs.getString("ROLE"));
                p.setContact(rs.getString("CONTACT_NUMBER"));
                p.setAddress(rs.getString("ADDRESS"));
            return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }
}
