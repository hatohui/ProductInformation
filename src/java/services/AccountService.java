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
        String query = "SELECT account, lastName, firstName, birthday, gender, phone, isUse, roleInSystem FROM accounts;";
        List<Account> accountList = new ArrayList<>();

        try {
            DatabaseInstance.connectToDatabase();
            ResultSet accounts = DatabaseInstance.query(query);

            while (accounts.next()) {
                String account = accounts.getString("account");
                String lastName = accounts.getString("lastName");
                String firstName = accounts.getString("firstName");
                Date birthday = accounts.getDate("birthday");
                boolean gender = accounts.getBoolean("gender");
                String phone = accounts.getString("phone");
                boolean isUse = accounts.getBoolean("isUse");
                int roleInSystem = accounts.getInt("roleInSystem");

                accountList.add(new Account(account, "", lastName, firstName, birthday, gender, phone, isUse, roleInSystem));
            }

            DatabaseInstance.close();
        } catch (SQLException exception) {
            System.out.println("Error retrieving accounts: " + exception.getMessage());
        }

        return accountList;
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
    public boolean post(Account newAccount) {
        try {
            DatabaseInstance.connectToDatabase();
            if (!DatabaseInstance.insertQuery("accounts", newAccount)) {
                DatabaseInstance.close();
                throw new SQLException("query not completed");
            }
            DatabaseInstance.close();
            return true;
        } catch (SQLException | IllegalAccessException error) {
            System.out.println(error.getMessage());
            return false;
        }
    }

    @Override
    public Account update(String id, Account newAccountData) {
        String query = "UPDATE accounts SET lastName = ?, firstName = ?, birthday = ?, gender = ?, phone = ?, isUse = ?, roleInSystem = ? WHERE account = ?;";

        try {
            DatabaseInstance.connectToDatabase();
            boolean updated = DatabaseInstance.updateQuery(query,
                    newAccountData.getLastName(),
                    newAccountData.getFirstName(),
                    newAccountData.getBirthday().toString(),
                    String.valueOf(newAccountData.isGender()),
                    newAccountData.getPhone(),
                    String.valueOf(newAccountData.isIsUse()),
                    String.valueOf(newAccountData.getRoleInSystem()),
                    id
            );
            DatabaseInstance.close();

            return updated ? newAccountData : null;
        } catch (SQLException e) {
            System.out.println("Error updating account: " + e.getMessage());
        }
        return null;
    }

    @Override
    public boolean delete(String account) {
        String query = "DELETE FROM accounts WHERE account = ?;";

        try {
            DatabaseInstance.connectToDatabase();
            boolean deleted = DatabaseInstance.updateQuery(query, account);
            DatabaseInstance.close();

            return deleted;
        } catch (SQLException e) {
            System.out.println("Error deleting account: " + e.getMessage());
        }
        return false;
    }

    @Override
    public Account getById(String id) {
        Account account = null;
        String query = "SELECT account, lastName, firstName, birthday, gender, phone, isUse, roleInSystem "
                + "FROM accounts WHERE account = ?;";

        try {
            DatabaseInstance.connectToDatabase();
            List<Account> accounts = DatabaseInstance.query(query, Account.class, id);
            DatabaseInstance.close();

            if (!accounts.isEmpty()) {
                account = accounts.get(0);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving account by ID: " + e.getMessage());
        }

        return account;
    }
}
