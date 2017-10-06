package transaction;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAOImpl implements TransactionDAO{

    @Override
    public void insert(Transaction t) {
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("insert into TRANSACTIONS(BANK,CARD,EXPIRE,CVV,HOLDER,AMOUNT,transaction_by) VALUES(?,?,?,?,?,?,?)");
            
            
            ps.setString(1, t.getBank());
            ps.setString(2, t.getCard());
            ps.setString(3, t.getExpiry());
            ps.setString(4, t.getCvv());
            ps.setString(5, t.getHolder());
            ps.setString(6, t.getAmount());
            ps.setInt(7, t.getBid());
            
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Transaction getTransaction(int id) {
        Transaction t=new Transaction();
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("Select * From Transactions where id="+id);
            
            ResultSet rs=ps.executeQuery();
            
            while(rs.next()){
                t.setId(rs.getInt("id"));
                t.setBid(rs.getInt("Transaction_by"));
                t.setBank(rs.getString("bank"));
                t.setCard(rs.getString("card"));
                t.setExpiry(rs.getString("expire"));
                t.setCvv(rs.getString("cvv"));
                t.setHolder(rs.getString("holder"));
                t.setAmount(rs.getString("amount"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }

    @Override
    public List<Transaction> getTransaction() {
        List<Transaction> list=new ArrayList<>();
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("Select * From Transactions");
            
            ResultSet rs=ps.executeQuery();
            
            while(rs.next()){
                Transaction t=new Transaction();
                
                t.setId(rs.getInt("id"));
                t.setBid(rs.getInt("Transaction_by"));
                t.setBank(rs.getString("bank"));
                t.setCard(rs.getString("card"));
                t.setExpiry(rs.getString("expire"));
                t.setCvv(rs.getString("cvv"));
                t.setHolder(rs.getString("holder"));
                t.setAmount(rs.getString("amount"));
                
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Transaction> getTransactionB(int Bid) {
        List<Transaction> list=new ArrayList<>();
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("Select * From Transactions where transaction_by =" +Bid);
            
            ResultSet rs=ps.executeQuery();
            
            while(rs.next()){
                Transaction t=new Transaction();
                
                t.setId(rs.getInt("id"));
                t.setBid(rs.getInt("Transaction_by"));
                t.setBank(rs.getString("bank"));
                t.setCard(rs.getString("card"));
                t.setExpiry(rs.getString("expire"));
                t.setCvv(rs.getString("cvv"));
                t.setHolder(rs.getString("holder"));
                t.setAmount(rs.getString("amount"));
                
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Transaction getTransactionL() {
        Transaction t=new Transaction();
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("Select max(id) From Transactions ");
            
            ResultSet rs=ps.executeQuery();
            
            while(rs.next()){
                t.setId(rs.getInt("1"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }

    @Override
    public void delete(int id) {
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("delete from TRANSACTIONS where id="+id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteB(int Bid) {
        try {
            Connection conn=database.Database.getInstance().getConnection();
            PreparedStatement ps=conn.prepareStatement("delete from TRANSACTIONS where Transaction_by="+Bid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
