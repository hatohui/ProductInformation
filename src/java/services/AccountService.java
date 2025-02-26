package services;

import interfaces.Workable;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import utils.DatabaseInstance;

public class AccountService implements Workable<Account> {

    @Override
    public List<Account> getAll() {
        List<Account> list = new ArrayList<>();
        String query = "SELECT account, lastName, firstName, birthday, gender, phone, isUse, roleInSystem "
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

    public Account authenticate(String username, String password) {
        Account account = null;
        String query = "SELECT lastName, firstName, birthday, gender, phone, isUse, roleInSystem "
                + "FROM accounts "
                + "WHERE account = ? "
                + "AND pass = ?";
        try {
            DatabaseInstance.connectToDatabase();

            ResultSet result = DatabaseInstance.query(query, username, password);
            while (result.next()) {
                Boolean isUse = result.getBoolean("isUse");
                if (!isUse) {
                    return null;
                }

                String lastName = result.getString("lastName");
                String firstName = result.getString("firstName");
                Date birthday = result.getDate("birthday");
                Boolean gender = result.getBoolean("gender");
                String phone = result.getString("phone");
                int roleInSystem = result.getInt("roleInSystem");

                account = new Account(username, lastName, firstName, birthday, gender, phone, isUse, roleInSystem);
            }
            DatabaseInstance.close();
            return account;
        } catch (SQLException exception) {
            System.out.println("Error at AccountDAO: " + exception.getMessage());
            return null;
        }
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
