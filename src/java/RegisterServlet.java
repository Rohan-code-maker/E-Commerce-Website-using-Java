import java.sql.*;
import java.io.*;
import java.util.Properties;
import javax.mail.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class RegisterServlet extends HttpServlet {

    // Add your test Gmail server details
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USERNAME = "rohan.gupta2059@gmail.com";
    private static final String SMTP_PASSWORD = "nfrdmcnoqqkhibsw";

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String address = request.getParameter("address");
        String sport = request.getParameter("sport");

        Connection con = null;
        PreparedStatement ps = null;
        PrintWriter out2 = response.getWriter();
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "admin"); 
            
            // Check if the email is already registered
            if (isEmailRegistered(con, email)) {
                out2.println("Email already registered");
            }
            
            ps = con.prepareStatement("INSERT INTO project(name, email, password, address, sport) VALUES(?, ?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, pass);
            ps.setString(4, address);
            ps.setString(5, sport);

            int i = ps.executeUpdate();

            if (i > 0) {
                // Send verification email to the user's email address
                sendVerificationEmail(email);                
                response.sendRedirect("login.jsp");
            } else {
                out2.println("Failed, Please Try again Later");
            }
        }catch (Exception e) {
            out2.println("Failed, Please Try again Later");
            out2.println("Error: " + e.getMessage());
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void sendVerificationEmail(String email) {
        // Create properties for the email session
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        // Create a Session object
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
            }
        });

        try {
            // Create a message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(email));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(SMTP_USERNAME));
            message.setSubject("Login");

            // Get the current date and time
            Calendar calendar = Calendar.getInstance();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String formattedDate = dateFormat.format(calendar.getTime());

            // Concatenate the email address with the verification message
            String verificationMessage = "New User Created: " + email + "\nDate and Time: " + formattedDate;
            message.setText(verificationMessage);
            // Send the message
            Transport.send(message);

            System.out.println("Verification email sent successfully.");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    private boolean isEmailRegistered(Connection con, String email) throws SQLException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String query = "SELECT COUNT(*) FROM project WHERE email = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
            return false;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
    }
}


