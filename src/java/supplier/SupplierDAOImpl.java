package supplier;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAOImpl implements SupplierDAO{

    private Connection conn;
    
    @Override
    public void insert(Supplier s) {
        try {
            conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("insert into Supplier_Detials(Company_id,Supplier_id) values(?,?)");
            ps.setInt(1, s.getcId());
            ps.setInt(2, s.getsId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        try {
            conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("delete from Supplier_Detials where id="+id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Supplier getSupplier(int id) {
        Supplier s=new Supplier();
        try {
            conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("select * from Supplier_Detials where id="+id+" order by Supplier_id");
            s.setId(id);
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                s.setcId(rs.getInt("Company_id"));
                s.setsId(rs.getInt("Supplier_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }

    @Override
    public List<Supplier> getSupplier() {
        List<Supplier> list=new ArrayList<>();
        try {
            conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("select * from Supplier_Detials order by Supplier_id");
            
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                Supplier s=new Supplier();
                s.setId(rs.getInt("id"));
                s.setcId(rs.getInt("Company_id"));
                s.setsId(rs.getInt("Supplier_id"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Supplier getSupplierS(int sid) {
        Supplier s=new Supplier();
        try {
            conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("select * from Supplier_Detials where Supplier_id="+sid+" order by Supplier_id");
            s.setId(sid);
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                s.setId(rs.getInt("id"));
                s.setcId(rs.getInt("Company_id"));
                s.setsId(rs.getInt("Supplier_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }

    @Override
    public List<Supplier> getSuppliers(int cid) {
        
        List<Supplier> list = new ArrayList<>();
        
        try {
            conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("select * from Supplier_Detials where company_id="+cid+" order by Supplier_id");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                
                list.add( getSupplierS( rs.getInt("Supplier_id") ) );
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
        
    }

    @Override
    public void deleteS(int Sid) {
        try {
            conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("delete from Supplier_Detials where supplier_id="+Sid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Supplier s) {
        try {
            conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("update supplier_Detials set company_id="+s.getcId()+" where id="+s.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }

    @Override
    public List<Supplier> getSupplierD() {
        List<Supplier> list = new ArrayList<>();
        
        try {
            conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("select distinct Supplier_id from Supplier_Detials order by Supplier_id");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                
                list.add( getSupplierS( rs.getInt("Supplier_id") ) );
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
}
