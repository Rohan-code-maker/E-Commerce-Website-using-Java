import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Sentmailservlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String host = "smtp.gmail.com";
        String user = "rohan.gupta2059@gmail.com";
        String port = "587";
        String password = "nfrdmcnoqqkhibsw";
        String name = request.getParameter("name");
        String subject = request.getParameter("subject");
        String email = request.getParameter("email");
        String messageBody = request.getParameter("message");
        String to = request.getParameter("recipients");

        String[] recipients = to.split(";"); // Assuming email addresses are separated by ';'

        try {
            EmailUtility.sendEmail(host, port, user, password, recipients, messageBody);
            response.sendRedirect("contact.jsp?result=mail sent Successfully");
        } catch (Exception e) {
            System.out.println("error: " + e.getMessage());
            // You might want to handle this error more gracefully, such as displaying an error message on the page.
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
