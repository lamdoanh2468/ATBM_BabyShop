package vn.edu.nlu.fit.be.DB;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class DBProperties {
    private static Properties prop = new Properties();

    static {
        try {
            File f = new File("/db.properties");
            if (f.exists()) {
                prop.load(new FileInputStream(f));
            } else {
                prop.load(DBProperties.class.getClassLoader().getResourceAsStream("db.properties"));
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static String get(String envName, String propertyName) {
        String envValue = System.getenv(envName);
        return envValue == null || envValue.isBlank() ? prop.getProperty(propertyName) : envValue;
    }

    public static String host = get("DB_HOST", "db.host");

    public static String port = get("DB_PORT", "db.port");

    public static String user = get("DB_USER", "db.user");

    public static String password = get("DB_PASSWORD", "db.password");

    public static String dbname = get("DB_NAME", "db.dbname");

    public static String option = get("DB_OPTION", "db.option");

    public static void main(String[] args) {
        System.out.println(host);
        System.out.println(port);
        System.out.println(user);
        System.out.println(password);
        System.out.println(dbname);
        System.out.println(option);

    }
}
