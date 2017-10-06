package category;

public class Category {
    
    private int id;
    private String Category_Name;
    private String Description;
    private String Image;

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategory_Name() {
        return Category_Name;
    }

    public void setCategory_Name(String Category_Name) {
        this.Category_Name = Category_Name;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    
    public Category() {
    }
    
    public Category(int i){
        
    }
    
}
