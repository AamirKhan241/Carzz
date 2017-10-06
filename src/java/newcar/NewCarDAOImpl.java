package newcar;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NewCarDAOImpl implements NewCarDAO{
    private Connection conn;
    @Override
    public void insert(NewCar nc) {
        try {
            conn=database.Database.getInstance().getConnection();
            PreparedStatement ps;
            String query="insert into newcars(car_name,model,color,top_speed,seating_capacity,fuel_type,fuel_capacity,transmission,"
                    + "price,feature,image,manufacturer_id,category_id,supplier_id) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            ps=conn.prepareStatement(query);


            ps.setString(1, nc.getName());
            ps.setString(2, nc.getModel());
            ps.setString(3, nc.getColor());
            ps.setString(4, nc.getSpeed());
            ps.setString(5, nc.getSeat());
            ps.setString(6, nc.getFuel());
            ps.setString(7, nc.getFuelCap());
            ps.setString(8, nc.getTransmission());
            ps.setString(9, nc.getPrice());
            ps.setString(10, nc.getFeature());
            ps.setString(11, nc.getImage());
            ps.setInt(12, nc.getComID());
            ps.setInt(13, nc.getCatID());
            ps.setInt(14, nc.getSuppID());
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(NewCar nc) {
        try {
            conn=database.Database.getInstance().getConnection();
            PreparedStatement ps;
            
            if(nc.getImage().equals(null)){
                ps=conn.prepareStatement("update newcars set model=?,color=?,top_speed=?,fuel_type=?,fuel_capacity=?,transmission=?,"
                    + "price=?,feature=?,seating_capacity=?,car_name=? where id="+nc.getId());
            }else{
                ps=conn.prepareStatement("update newcars set model=?,color=?,top_speed=?,fuel_type=?,fuel_capacity=?,transmission=?,"
                    + "price=?,feature=?,seating_capacity=?,car_name=?,image=? where id="+nc.getId());
                ps.setString(11, nc.getImage());
                
            }
           
            ps.setString(1, nc.getModel());
            ps.setString(2, nc.getColor());
            ps.setString(3, nc.getSpeed());
            ps.setString(4, nc.getFuel());
            ps.setString(5, nc.getFuelCap());
            ps.setString(6, nc.getTransmission());
            ps.setString(7, nc.getPrice());
            ps.setString(8, nc.getFeature());
            ps.setString(9, nc.getSeat());
            ps.setString(10, nc.getName());
            
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        try {
            conn=database.Database.getInstance().getConnection();
            String query="delete from newcars where id="+id;
            PreparedStatement ps=conn.prepareStatement(query);
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public NewCar getCar(int id) {
        NewCar nc=new NewCar();
        try {
            conn=database.Database.getInstance().getConnection();
            String query="select * from newcars where id="+id+" order by Car_NAME";
            PreparedStatement ps=conn.prepareStatement(query);
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {                
                
                nc.setId(rs.getInt("id"));
                nc.setName(rs.getString("Car_Name"));
                nc.setModel(rs.getString("model"));
                nc.setColor(rs.getString("color"));
                nc.setSpeed(rs.getString("top_speed"));
                nc.setSeat(rs.getString("Seating_Capacity"));
                nc.setFuel(rs.getString("Fuel_type"));
                nc.setFuelCap(rs.getString("Fuel_Capacity"));
                nc.setTransmission(rs.getString("Transmission"));
                nc.setPrice(rs.getString("price"));
                nc.setFeature(rs.getString("feature"));
                nc.setComID(rs.getInt("Manufacturer_ID"));
                nc.setSuppID(rs.getInt("Supplier_ID"));
                nc.setCatID(rs.getInt("category_id"));
                nc.setImage(rs.getString("image"));
                return nc;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nc;
    }

    @Override
    public List<NewCar> getCar() {
        List<NewCar> list=new ArrayList<>();
        try {
            conn=database.Database.getInstance().getConnection();
            String query="select * from newcars order by Car_NAME";
            PreparedStatement ps=conn.prepareStatement(query);
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {                
                NewCar nc=new NewCar();
                nc.setId(rs.getInt("id"));
                nc.setName(rs.getString("Car_Name"));
                nc.setModel(rs.getString("model"));
                nc.setColor(rs.getString("color"));
                nc.setSpeed(rs.getString("top_speed"));
                nc.setFuel(rs.getString("Fuel_type"));
                nc.setFuelCap(rs.getString("Fuel_Capacity"));
                nc.setTransmission(rs.getString("Transmission"));
                nc.setPrice(rs.getString("price"));
                nc.setFeature(rs.getString("feature"));
                nc.setComID(rs.getInt("Manufacturer_ID"));
                nc.setSuppID(rs.getInt("Supplier_ID"));
                nc.setCatID(rs.getInt("category_id"));
                nc.setImage(rs.getString("image"));
                list.add(nc);
                System.out.println("Added");
            }
            System.out.println("Returning");
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<NewCar> getCarC(int cat) {
        List<NewCar> list=new ArrayList<>();
        try {
            conn=database.Database.getInstance().getConnection();
            String query="select * from newcars where category_id="+cat+" order by Car_NAME";
            PreparedStatement ps=conn.prepareStatement(query);
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {                
                NewCar nc=new NewCar();
                nc.setId(rs.getInt("id"));
                nc.setName(rs.getString("Car_Name"));
                nc.setModel(rs.getString("model"));
                nc.setColor(rs.getString("color"));
                nc.setSpeed(rs.getString("top_speed"));
                nc.setFuel(rs.getString("Fuel_type"));
                nc.setFuelCap(rs.getString("Fuel_Capacity"));
                nc.setTransmission(rs.getString("Transmission"));
                nc.setPrice(rs.getString("price"));
                nc.setFeature(rs.getString("feature"));
                nc.setComID(rs.getInt("Manufacturer_ID"));
                nc.setSuppID(rs.getInt("Supplier_ID"));
                nc.setCatID(rs.getInt("category_id"));
                nc.setImage(rs.getString("image"));
                list.add(nc);
                System.out.println("Added");
            }
            System.out.println("Returning");
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<NewCar> getCarM(int man) {
        List<NewCar> list=new ArrayList<>();
        try {
            conn=database.Database.getInstance().getConnection();
            String query="select * from newcars where Manufacturer_ID="+man+" order by Car_NAME";
            PreparedStatement ps=conn.prepareStatement(query);
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {                
                NewCar nc=new NewCar();
                nc.setId(rs.getInt("id"));
                nc.setName(rs.getString("Car_Name"));
                nc.setModel(rs.getString("model"));
                nc.setColor(rs.getString("color"));
                nc.setSpeed(rs.getString("top_speed"));
                nc.setFuel(rs.getString("Fuel_type"));
                nc.setFuelCap(rs.getString("Fuel_Capacity"));
                nc.setTransmission(rs.getString("Transmission"));
                nc.setPrice(rs.getString("price"));
                nc.setFeature(rs.getString("feature"));
                nc.setComID(rs.getInt("Manufacturer_ID"));
                nc.setSuppID(rs.getInt("Supplier_ID"));
                nc.setCatID(rs.getInt("category_id"));
                nc.setImage(rs.getString("image"));
                list.add(nc);
                System.out.println("Added");
            }
            System.out.println("Returning");
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void deleteS(int Sid) {
        try {
            conn=database.Database.getInstance().getConnection();
            String query="delete from newcars where supplier_id="+Sid;
            PreparedStatement ps=conn.prepareStatement(query);
            
            ps.executeUpdate();   
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
