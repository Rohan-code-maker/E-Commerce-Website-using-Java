
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@WebServlet("/SendEmailServlet")
public class SendEmailServlet extends HttpServlet {

    private static final String FROM_EMAIL = "rohan.gupta2059@gmail.com";
    private static final String TO_EMAIL = "vickterpsk18@gmail.com";
    private static final String EMAIL_HOST = "smtp.gmail.com";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        Properties properties = new Properties();
        properties.put("mail.smtp.host", EMAIL_HOST);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        try (PrintWriter out = response.getWriter()) {
            Session session = Session.getInstance(properties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("rohan.gupta2059@gmail.com", "nfrdmcnoqqkhibsw");
                }
            });

            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(FROM_EMAIL));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(FROM_EMAIL));
                message.setSubject("Contact Us Form Submission");

                String name = request.getParameter("name");
                String subject = request.getParameter("subject");
                String email = request.getParameter("email");
                String messageBody = request.getParameter("message");
                String emailContent = "Name: " + name + "<br/>subject: " + subject + "<br/>Email: " + email + "<br/>Message: " + messageBody;
                message.setContent(emailContent, "text/html");

                // Log the message content to the console
                System.out.println("Message Content:");
                System.out.println(emailContent);

                Transport.send(message);
                out.println("<h1>Thank you for contacting us!</h1>");
            } catch (MessagingException mex) {
                out.println("<h1>Error: Unable to send message. Please try again later.</h1>");
                Logger.getLogger(SendEmailServlet.class.getName()).log(Level.SEVERE, "Error sending email", mex);
            }

        }
    }
}
