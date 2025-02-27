package services;

import interfaces.Workable;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import utils.DatabaseInstance;

public class ProductService implements Workable<Product> {

    @Override
    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();
        String query = "";
        try {
            DatabaseInstance.connectToDatabase();
            DatabaseInstance.close();
        } catch (SQLException exception) {
            return null;
        }
        return list;
    }

    @Override
    public void post(Product object) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Product update(String id, Product object) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Product delete(Product object) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Product getById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
