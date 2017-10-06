package order;

public class Order {
    
    private int id;
    private int Bid;
    private int Tid;
    private int Pid;
    private int Sid;
    private String status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBid() {
        return Bid;
    }

    public void setBid(int Bid) {
        this.Bid = Bid;
    }

    public int getTid() {
        return Tid;
    }

    public void setTid(int Tid) {
        this.Tid = Tid;
    }

    public int getPid() {
        return Pid;
    }

    public void setPid(int Pid) {
        this.Pid = Pid;
    }

    public int getSid() {
        return Sid;
    }

    public void setSid(int Sid) {
        this.Sid = Sid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Order() {
    }
}
