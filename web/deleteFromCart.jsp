<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    String idParameterStr = request.getParameter("id");
    if (idParameterStr != null && !idParameterStr.isEmpty()) {
        try {
            int idParameter = Integer.parseInt(idParameterStr);

            Connection con = null;
            PreparedStatement deleteStatement = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "admin");

                deleteStatement = con.prepareStatement("DELETE FROM cart WHERE id = ?");
                deleteStatement.setInt(1, idParameter);
                int rowsAffected = deleteStatement.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("cart.jsp");
                } else {
                    out.println("<p>No record found with ID: " + idParameter + "</p>");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                out.println("<p>An error occurred while deleting the ID: " + e.getMessage() + "</p>");
            } finally {
                try {
                    // Close resources
                    if (deleteStatement != null) {
                        deleteStatement.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            out.println("<p>Invalid ID provided.</p>");
        }
    } else {
        out.println("<p>No ID provided.</p>");
    }
%>
