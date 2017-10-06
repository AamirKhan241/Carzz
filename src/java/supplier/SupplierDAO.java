package supplier;

import java.util.List;

public interface SupplierDAO {
    
    void insert(Supplier s);
    void delete(int id);
    void deleteS(int Sid);
    void update(Supplier s);
    
    Supplier getSupplierS(int sid);
    Supplier getSupplier(int id);
    
    List<Supplier> getSuppliers(int cid);
    List<Supplier> getSupplier();
    List<Supplier> getSupplierD();
    
}
