
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
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
        String fabric = request.getParameter("fabric");
        String color = request.getParameter("color");
        String size = request.getParameter("size");
        String name = (String) session.getAttribute("name");

        // JDBC variables
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet result = null;
        PrintWriter out = response.getWriter();

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            String jdbcUrl = "jdbc:mysql://localhost:3306/mysql";
            String dbUser = "root";
            String dbPassword = "admin";
            connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            if (session.getAttribute("name") == null) {
                preparedStatement = connection.prepareStatement("SELECT * FROM cart WHERE name IS NULL AND product_id = ?");
                preparedStatement.setInt(1, productId);

                result = preparedStatement.executeQuery();
                if (!result.next()) {
                    // SQL query
                    String sql = "INSERT INTO cart (product_id, product_name, product_desc, product_price, product_category, fabric, color, size, image, quantity, name) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 1, NULL)";
                    preparedStatement = connection.prepareStatement(sql);

                    // Set parameters
                    preparedStatement.setInt(1, productId);
                    preparedStatement.setString(2, product_name);
                    preparedStatement.setString(3, product_desc);
                    preparedStatement.setInt(4, product_price);
                    preparedStatement.setString(5, product_category);
                    preparedStatement.setString(6, fabric);
                    preparedStatement.setString(7, color);
                    preparedStatement.setString(8, size);
                    preparedStatement.setString(9, image);
                } else {
                    out.println("You have already added the item to the cart.");
                }
            } else {
                preparedStatement = connection.prepareStatement("SELECT * FROM cart WHERE name=? AND product_id = ?");
                preparedStatement.setString(1, name);
                preparedStatement.setInt(2, productId);

                result = preparedStatement.executeQuery();
                if (!result.next()) {
                    // SQL query
                    String sql = "INSERT INTO cart (product_id, product_name, product_desc, product_price, product_category, fabric, color, size, name, image, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1)";
                    preparedStatement = connection.prepareStatement(sql);

                    // Set parameters
                    preparedStatement.setInt(1, productId);
                    preparedStatement.setString(2, product_name);
                    preparedStatement.setString(3, product_desc);
                    preparedStatement.setInt(4, product_price);
                    preparedStatement.setString(5, product_category);
                    preparedStatement.setString(6, fabric);
                    preparedStatement.setString(7, color);
                    preparedStatement.setString(8, size);
                    preparedStatement.setString(9, name);
                    preparedStatement.setString(10, image);
                } else {
                    out.println("You have already added the item to the cart.");
                }
            }

            // Execute the query
            int i = preparedStatement.executeUpdate();
            if (i > 0) {
                response.sendRedirect("cart.jsp");
            } else {
                out.println("Data Not Added");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            out.println("Something Error");
            Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Close PreparedStatement and Connection
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        }

    }
}
