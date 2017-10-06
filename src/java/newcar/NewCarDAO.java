package newcar;

import java.util.List;

public interface NewCarDAO {
    
    void insert(NewCar nc);
    void update(NewCar nc);
    void delete(int id);
    void deleteS(int Sid);
    
    NewCar getCar(int id);
    List<NewCar> getCar();
    List<NewCar> getCarC(int cat);
    List<NewCar> getCarM(int man);
    
}
