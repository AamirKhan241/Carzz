package order;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class OrderDAOImpl implements OrderDAO{

    @Override
    public void insert(Order o) {
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("insert into ORDERS(PRODUCT_ID,TRANSACTION_ID,STATUS,Buyer_id,Seller_id) values(?,?,?,?,?)");
            
            ps.setInt(1, o.getPid());
            ps.setInt(2, o.getTid());
            ps.setString(3, o.getStatus());
            ps.setInt(4, o.getBid());
            ps.setInt(5, o.getSid());
            
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("delete from orders where id="+id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Order o) {
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("update orders set status = '"+o.getStatus()+"' where id="+o.getId());
            
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Order getOrder(int id) {
        Order o=new Order();
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("select * from orders where id=" +id);
            
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                o.setId(rs.getInt("id"));
                o.setPid(rs.getInt("Product_id"));
                o.setBid(rs.getInt("buyer_id"));
                o.setSid(rs.getInt("seller_id"));
                o.setTid(rs.getInt("transaction_id"));
                o.setStatus(rs.getString("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return o;
    }

    @Override
    public List<Order> getOrder() {
        List<Order> list=new ArrayList<>();
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("select * from orders");
            
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                Order o=new Order();
                
                o.setId(rs.getInt("id"));
                o.setPid(rs.getInt("Product_id"));
                o.setBid(rs.getInt("buyer_id"));
                o.setSid(rs.getInt("seller_id"));
                o.setTid(rs.getInt("transaction_id"));
                o.setStatus(rs.getString("status"));
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Order getOrderT(int Tid) {
        Order o=new Order();
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("select * from orders where transaction_id=" +Tid);
            
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                o.setId(rs.getInt("id"));
                o.setPid(rs.getInt("Product_id"));
                o.setBid(rs.getInt("buyer_id"));
                o.setSid(rs.getInt("seller_id"));
                o.setTid(rs.getInt("transaction_id"));
                o.setStatus(rs.getString("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return o;
    }

    @Override
    public void deleteS(int Sid) {
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("delete from orders where Seller_id="+Sid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
