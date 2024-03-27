import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SearchServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("search");
        
        // JDBC variables
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        PrintWriter out = response.getWriter();
        ResultSet result = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String jdbcUrl = "jdbc:mysql://localhost:3306/mysql";
            String dbUser = "root";
            String dbPassword = "admin";
            connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // SQL query
            String sql = "select * from products where name like ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, "%" + name + "%"); // Set parameter properly
            result = preparedStatement.executeQuery();
            if(result.next()){ // Use result.next() to check if there's any result
                response.sendRedirect("search.jsp?id="+result.getInt("id"));
            } else {
                response.sendRedirect("pageNotFound.jsp");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            out.println("Something is error");
            Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (result != null) {
                    result.close();
                }
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
