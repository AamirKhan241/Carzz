package profile;

import java.util.List;

public interface ProfileDAO {
    
    boolean Insert(Profile p);
    boolean update(Profile p);
    boolean delete(int id);
    
    Profile getProfiles(int id);
    Profile getProfiles(String email);
    List<Profile> getProfiles();    
    List<Profile> getSupplier();    
}
