package services;

import interfaces.Workable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import utils.DatabaseInstance;

public class ProductService implements Workable<Product> {

    @Override
    public List<Product> getAll() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products;";

        try {
            DatabaseInstance.connectToDatabase();
            ResultSet result = DatabaseInstance.query(query);

            while (result.next()) {
                Product product = new Product(
                        result.getString("productId"),
                        result.getString("productName"),
                        result.getString("productImage"),
                        result.getString("brief"),
                        result.getDate("postedDate"),
                        result.getInt("typeId"),
                        result.getString("account"),
                        result.getString("unit"),
                        result.getInt("price"),
                        result.getInt("discount")
                );
                products.add(product);
            }
            DatabaseInstance.close();
        } catch (SQLException exception) {
            System.out.println("Error fetching products: " + exception.getMessage());
        }
        return products;
    }

    @Override
    public boolean post(Product newProduct) {
        try {
            DatabaseInstance.connectToDatabase();
            boolean success = DatabaseInstance.insertQuery("products", newProduct);
            DatabaseInstance.close();
            return success;
        } catch (SQLException | IllegalAccessException error) {
            System.out.println("Error adding product: " + error.getMessage());
            return false;
        }
    }

    @Override
    public Product update(String id, Product newProductData) {
        String query = "UPDATE products SET productName = ?, productImage = ?, brief = ?, postedDate = ?, typeId = ?, account = ?, unit = ?, price = ?, discount = ? WHERE productId = ?;";

        try {
            DatabaseInstance.connectToDatabase();
            boolean updated = DatabaseInstance.updateQuery(query,
                    newProductData.getProductName(),
                    newProductData.getProductImage(),
                    newProductData.getBrief(),
                    String.valueOf(newProductData.getPostedDate()),
                    String.valueOf(newProductData.getTypeId()),
                    newProductData.getAccount(),
                    newProductData.getUnit(),
                    String.valueOf(newProductData.getPrice()),
                    String.valueOf(newProductData.getDiscount()),
                    id
            );
            DatabaseInstance.close();

            return updated ? newProductData : null;
        } catch (SQLException e) {
            System.out.println("Error updating product: " + e.getMessage());
        }
        return null;
    }

    @Override
    public boolean delete(String productId) {
        String query = "DELETE FROM products WHERE productId = ?;";

        try {
            DatabaseInstance.connectToDatabase();
            boolean deleted = DatabaseInstance.updateQuery(query, productId);
            DatabaseInstance.close();

            return deleted;
        } catch (SQLException e) {
            System.out.println("Error deleting product: " + e.getMessage());
            return false;
        }
    }

    @Override
    public Product getById(String id) {
        String query = "SELECT * FROM products WHERE productId = ?;";
        Product product = null;

        try {
            DatabaseInstance.connectToDatabase();
            ResultSet result = DatabaseInstance.query(query, id);

            if (result.next()) {
                product = new Product(
                        result.getString("productId"),
                        result.getString("productName"),
                        result.getString("productImage"),
                        result.getString("brief"),
                        result.getDate("postedDate"),
                        result.getInt("typeId"),
                        result.getString("account"),
                        result.getString("unit"),
                        result.getInt("price"),
                        result.getInt("discount")
                );
            }
            DatabaseInstance.close();
        } catch (SQLException e) {
            System.out.println("Error fetching product by ID: " + e.getMessage());
        }
        return product;
    }
}
