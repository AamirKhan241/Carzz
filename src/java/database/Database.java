package database;

import java.sql.Connection;
import java.sql.DriverManager;

public class Database {
    
    private static Database obj=new Database();
    private Connection conn;
    
    private Database(){
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn=DriverManager.getConnection("jdbc:derby://localhost:1527/Cars","car","car");
            System.out.println("Connected");
        } catch (Exception e) {
            e.printStackTrace();
        }    
    }
    
    public static Database getInstance(){
        return obj;
    }
    public Connection getConnection(){
        return conn;
    }
}
