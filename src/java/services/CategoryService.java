package services;

import interfaces.Workable;
import java.sql.SQLException;
import java.util.List;
import model.Category;
import utils.DatabaseInstance;

public class CategoryService implements Workable<Category> {

    @Override
    public List<Category> getAll() {
        try {
            DatabaseInstance.connectToDatabase();
            String query = "SELECT typeId, categoryName, memo FROM categories";

            List<Category> categories = DatabaseInstance.query(query, Category.class);
            DatabaseInstance.close();
            return categories;
        } catch (SQLException exception) {
            System.out.println(exception);
        }
        return null;
    }

    @Override
    public boolean post(Category object) {
        try {
            DatabaseInstance.connectToDatabase();
            String query = "INSERT INTO categories(categoryName, memo) VALUES (?,?);";
            DatabaseInstance.updateQuery(query, object.getCategoryName(), object.getMemo());
            DatabaseInstance.close();
            return true;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    @Override
    public boolean delete(String id
    ) {
        String query = "DELETE FROM categories WHERE typeId = ?";
        try {
            DatabaseInstance.connectToDatabase();
            boolean updated = DatabaseInstance.updateQuery(query, id);
            DatabaseInstance.close();
            return updated;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    @Override
    public Category update(String id, Category object
    ) {
        try {
            DatabaseInstance.connectToDatabase();
            String query = "UPDATE categories SET categoryName = ?, memo = ? WHERE typeId = ?;";
            System.out.println(object.getCategoryName() + " memo:" + object.getMemo());
            DatabaseInstance.updateQuery(query, object.getCategoryName(), object.getMemo(), id);
            DatabaseInstance.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return object;
    }

    @Override
    public Category getById(String id) {
        try {
            DatabaseInstance.connectToDatabase();
            String query = "SELECT * FROM categories WHERE typeId = ?;";
            List<Category> categories = DatabaseInstance.query(query, Category.class, id);
            DatabaseInstance.close();

            if (!categories.isEmpty()) {
                return categories.get(0);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

}
