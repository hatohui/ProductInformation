package utils;

import constants.DBConfig;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DatabaseInstance {

    private static final Logger LOGGER = Logger.getLogger(DatabaseInstance.class.getName());
    private static Connection connection;
    private static PreparedStatement statement;
    private static ResultSet result;

    private DatabaseInstance() {
    }

    private static String getConnectUrl() {
        return String.format("jdbc:sqlserver://%s:%s;databaseName=%s;user=%s;password=%s;",
                DBConfig.HOST_NAME, DBConfig.DB_PORT, DBConfig.DB_NAME, DBConfig.USERNAME, DBConfig.PASSWORD);
    }

    public static void connectToDatabase() {
        if (connection == null) {
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                connection = DriverManager.getConnection(getConnectUrl());
                LOGGER.info("Connected to database.");
            } catch (ClassNotFoundException | SQLException e) {
                LOGGER.log(Level.SEVERE, "Database connection failed", e);
                throw new RuntimeException("Database connection error", e);
            }
        }
    }

    public static ResultSet query(String sql, String... params) throws SQLException {
        if (connection == null) {
            throw new IllegalStateException("Database connection has not been initialized.");
        }

        statement = connection.prepareStatement(sql);
        int count = 1;
        for (String arg : params) {
            statement.setString(count, arg);
            count++;
        }
        result = statement.executeQuery();
        return result;
    }

    public static <T> List<T> query(String sql, Class<T> clazz, String... params) throws SQLException {
        if (connection == null) {
            throw new IllegalStateException("Database connection has not been initialized.");
        }

        List<T> resultList = new ArrayList<>();
        statement = connection.prepareStatement(sql);

        int count = 1;
        for (String arg : params) {
            statement.setString(count, arg);
            count++;
        }

        result = statement.executeQuery();
        Field[] fields = clazz.getDeclaredFields();

        while (result.next()) {
            try {
                T instance = clazz.getDeclaredConstructor().newInstance();

                for (Field field : fields) {
                    field.setAccessible(true);
                    String columnName = field.getName();

                    if (field.getType() == String.class) {
                        field.set(instance, result.getString(columnName));
                    } else if (field.getType() == int.class || field.getType() == Integer.class) {
                        field.set(instance, result.getInt(columnName));
                    } else if (field.getType() == boolean.class || field.getType() == Boolean.class) {
                        field.set(instance, result.getBoolean(columnName));
                    } else if (field.getType() == Date.class) {
                        field.set(instance, result.getDate(columnName));
                    }
                }

                resultList.add(instance);
            } catch (IllegalAccessException | IllegalArgumentException
                    | InstantiationException | NoSuchMethodException
                    | SecurityException | InvocationTargetException
                    | SQLException e) {
                throw new RuntimeException("Error mapping ResultSet to " + clazz.getName(), e);
            }
        }
        return resultList;
    }

    public static boolean updateQuery(String sql, String... params) throws SQLException {
        if (connection == null) {
            throw new IllegalStateException("Database connection has not been initialized.");
        }

        statement = connection.prepareStatement(sql);
        for (int i = 0; i < params.length; i++) {
            statement.setString(i + 1, params[i]);
        }

        return statement.executeUpdate() > 0;
    }

    public static <T> boolean insertQuery(String tableName, T object) throws SQLException, IllegalAccessException {
        if (connection == null) {
            throw new IllegalStateException("Database connection has not been initialized.");
        }

        Class<?> clazz = object.getClass();
        Field[] fields = clazz.getDeclaredFields();
        StringBuilder sql = new StringBuilder("INSERT INTO " + tableName + " (");
        StringBuilder placeholders = new StringBuilder();

        for (Field field : fields) {
            sql.append(field.getName()).append(", ");
            placeholders.append("?, ");
        }

        sql.setLength(sql.length() - 2);
        placeholders.setLength(placeholders.length() - 2);
        sql.append(") VALUES (").append(placeholders).append(")");

        try {
            statement = connection.prepareStatement(sql.toString());
            int index = 1;
            for (Field field : fields) {
                field.setAccessible(true);
                Object value = field.get(object);
                statement.setObject(index, value);
                index++;
            }

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        }
    }

    public static void close() throws SQLException {
        if (connection == null) {
            throw new IllegalStateException("Database connection has not been initialized.");
        }

        try {
            if (result != null) {
                result.close();
                result = null;
            }
            if (statement != null) {
                statement.close();
                statement = null;
            }
            if (connection != null) {
                connection.close();
                connection = null;
            }
        } catch (SQLException e) {
            throw new SQLException("Error closing database resources", e);
        }
    }

}
