package company;

import java.util.List;

public interface CompanyDAO {
    void insert(Company s);
    void update(Company s);
    void delete(int id);
    
    Company getCompany(int id);
    Company getCompany(String cName);
    List<Company> getCompany();
}