package repositories;

import interfaces.Workable;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import utils.DatabaseInstance;

public class AccountDAO implements Workable<Account> {

    @Override
    public List<Account> getAll() {
        List<Account> list = new ArrayList<>();
        String query = "SELECT account, pass, lastName, firstName, birthday, gender, phone, isUse, roleInSystem "
                + "FROM accounts;";
        try {
            DatabaseInstance.connectToDatabase();
            List<Account> accounts = DatabaseInstance.query(query, Account.class);
            DatabaseInstance.close();
            return accounts;
        } catch (SQLException exception) {
            System.out.println(exception);
        }
        return list;
    }

    @Override
    public void post(Account newAccount) {
        throw new UnsupportedOperationException("Not supported yet."); // To change body of generated methods, choose Tools
        // | Templates.
    }

    @Override
    public Account update(String id, Account newAccountData) {
        throw new UnsupportedOperationException("Not supported yet."); // To change body of generated methods, choose Tools
        // | Templates.
    }

    @Override
    public Account delete(Account account) {
        throw new UnsupportedOperationException("Not supported yet."); // To change body of generated methods, choose Tools
        // | Templates.
    }

    @Override
    public Account getById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // To change body of generated methods, choose Tools
        // | Templates.
    }

}
