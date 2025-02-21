package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import constants.DBConfig;

public class DatabaseInstance {

  private static Connection connection;

  private static String getConnectUrl() {
    return String.format("jdbc:sqlserver://%s:%s;databaseName=%s;user=%s;password=%s;",
        DBConfig.HOST_NAME, DBConfig.DB_PORT, DBConfig.DB_NAME, DBConfig.USERNAME, DBConfig.PASSWORD);
  }

  public static void connectToDatabase() {
    try {
      Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
      connection = DriverManager.getConnection(getConnectUrl());
      System.out.println("Connected to database.");
    } catch (ClassNotFoundException | SQLException e) {
      System.out.println(e);
    }
  }

  public static ResultSet query(String string) {
    try {
      return connection.createStatement().executeQuery(string);
    } catch (SQLException ex) {
      Logger.getLogger(DatabaseInstance.class.getName()).log(Level.SEVERE, null, ex);
    }
    return null;
  }

  public static void closeConnection() {
    try {
      connection.close();
      System.out.println("Connection closed.");
    } catch (SQLException e) {
      System.out.println(e.getMessage());
    }
  }
}
