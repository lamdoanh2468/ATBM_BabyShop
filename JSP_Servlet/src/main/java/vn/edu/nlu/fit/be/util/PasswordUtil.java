package vn.edu.nlu.fit.be.util;


import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
    // sinh hash
    public static String hash(String plain) {
        return BCrypt.hashpw(plain, BCrypt.gensalt(12));
    }

    // so sánh mật khẩu
    public static boolean verify(String plain, String hash) {
        if (hash == null || hash.length() == 0) return false;
        return BCrypt.checkpw(plain, hash);
    }
}
