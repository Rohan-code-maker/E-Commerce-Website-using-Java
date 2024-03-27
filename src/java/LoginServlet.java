
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.*;
import java.text.*;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        RequestDispatcher dispatcher = null;
        Connection con = null;
        PreparedStatement pst = null;
        HttpSession sessionObj = request.getSession();
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "admin");
            pst = con.prepareStatement("select * from project where email=? and password=?");
            pst.setString(1, email);
            pst.setString(2, pass);

            ResultSet rs = pst.executeQuery();

            // Get the current date and time
            Calendar calendar = Calendar.getInstance();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String formattedDate = dateFormat.format(calendar.getTime());

            if (rs.next()) {
                sessionObj.setAttribute("name", rs.getString("name"));

                if (rs.getString("email").equals("admin@gmail.com") && rs.getString("password").equals("admin")) {
                    dispatcher = request.getRequestDispatcher("adminIndex.jsp");
                } else {
                    dispatcher = request.getRequestDispatcher("index.jsp");
                }
            } else {
                sessionObj.setAttribute("status", "failed");

                // Create and add a cookie
                Cookie cookie = new Cookie("date", formattedDate);
                cookie.setMaxAge(24 * 60 * 60); // Cookie lasts for 1 day (24 hours)
                response.addCookie(cookie);

                response.sendRedirect("login.jsp");
            }

            dispatcher.forward(request, response);
        } catch (Exception e) {
            out.println("Email and Password Field Doesn't Matches");
            out.println("Error: " + e.getMessage());
        } finally {
            // Close JDBC resources
            try {
                if (pst != null) {
                    pst.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
