import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int productId = Integer.parseInt(request.getParameter("productId"));
        String image = request.getParameter("image");
        String product_name = request.getParameter("name");
        String product_desc = request.getParameter("description");
        int product_price = Integer.parseInt(request.getParameter("price"));
        String product_category = request.getParameter("category");
        String product_details = request.getParameter("details");
        String name = (String) session.getAttribute("name");

        // JDBC variables
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        PrintWriter out = response.getWriter();

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            String jdbcUrl = "jdbc:mysql://localhost:3306/mysql";
            String dbUser = "root";
            String dbPassword = "admin";
            connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // SQL query
            String sql = "INSERT INTO cart (product_id, product_name, product_desc, product_price, product_category, product_details, name, image, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1)";
            preparedStatement = connection.prepareStatement(sql);

            // Set parameters
            preparedStatement.setInt(1, productId);
            preparedStatement.setString(2, product_name);
            preparedStatement.setString(3, product_desc);
            preparedStatement.setInt(4, product_price);
            preparedStatement.setString(5, product_category);
            preparedStatement.setString(6, product_details);
            preparedStatement.setString(7, name);
            preparedStatement.setString(8, image);

            // Execute the query
            int i = preparedStatement.executeUpdate();
            if(i > 0) {
                response.sendRedirect("cart.jsp");
            } else {
                out.println("Data Not Added");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            out.println("You have already Added the item in the cart..");
            Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Close PreparedStatement and Connection
            try {
                if(preparedStatement != null) {
                    preparedStatement.close();
                }
                if(connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }
}
