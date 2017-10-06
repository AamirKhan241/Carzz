package transaction;

import java.util.List;

public interface TransactionDAO {

    void insert(Transaction t);
    void delete(int id);
    void deleteB(int Bid);
    
    Transaction getTransaction(int id);
    Transaction getTransactionL();
    List<Transaction> getTransaction();
    List<Transaction> getTransactionB(int Bid);
    
}
