package category;

import java.io.File;
import java.util.List;

public interface CategoryDAO {
    
    void insert(Category c);
    void delete(int id);
    void update(Category c);
    
    Category getCategory(int id);
    Category getCategory(String name);
    List<Category> getCategory();
}
