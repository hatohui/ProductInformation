package dao;

import interfaces.Workable;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import utils.DatabaseInstance;

public class CategoryDao implements Workable<Category> {

    @Override
    public List<Category> getAll() {
        List<Category> list = new ArrayList<>();
        String query = "SELECT productId, productName, productImage, brief, postedDate, typeId, account, unit, price, discount "
                + "FROM products;";
        try {
            DatabaseInstance.connectToDatabase();
            List<Category> categories = DatabaseInstance.query(query, Category.class);
            DatabaseInstance.close();
            return categories;
        } catch (SQLException exception) {
            System.out.println(exception);
        }
        return list;
    }

    @Override
    public void post(Category object) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Category update(String id, Category object) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Category delete(Category object) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Category getById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
