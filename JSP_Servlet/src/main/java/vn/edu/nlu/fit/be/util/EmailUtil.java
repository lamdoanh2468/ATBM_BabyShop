package vn.edu.nlu.fit.be.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.util.Properties;

public class EmailUtil {
    public static void sendOTP(String toEmail, String otp) {
        // 🔍 LOG 1: xác nhận đã vào hàm
        System.out.println("👉 Bắt đầu gửi OTP tới: " + toEmail);
        System.out.println("👉 OTP: " + otp);

        final String fromEmail = "22130014@st.hcmuaf.edu.vn";
        final String password = "kltzwkrylogyuwtl";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(fromEmail, password);
                    }
                });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));
            message.setSubject("Mã OTP đăng ký tài khoản");
            message.setText("Mã OTP của bạn là: " + otp + "\nHiệu lực trong 60 giây.");

            Transport.send(message);
            // ✅ LOG 2: gửi thành công
            System.out.println("✅ Gửi mail OTP thành công!");

        } catch (MessagingException e) {

            // ❌ LOG 3: in toàn bộ lỗi SMTP
            System.out.println("❌ Lỗi khi gửi mail OTP");
            e.printStackTrace(); // ⭐ BẮT BUỘC
        }
    }
}
