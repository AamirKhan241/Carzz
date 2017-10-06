package order;

import java.util.List;

public interface OrderDAO {
    
    void insert(Order o);
    void delete(int id);
    void deleteS(int Sid);
    void update(Order o);
    
    Order getOrder(int id);
    Order getOrderT(int Tid);
    List<Order> getOrder();
    
}
