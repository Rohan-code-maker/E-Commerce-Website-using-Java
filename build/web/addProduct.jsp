<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if(request.getParameter("submit")!=null)
    {
    // Get form data
    String name = request.getParameter("name");
    String description = request.getParameter("description");
    String category = request.getParameter("category");
    int price = Integer.parseInt(request.getParameter("price"));
    String details = request.getParameter("details");
    String image = request.getParameter("image");
    
    // JDBC variables
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // JDBC Connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/mysql";
        String dbUser = "root";
        String dbPassword = "admin";
        connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // SQL query
        String sql = "INSERT INTO products (name, description,category, price,details, image) VALUES (?, ?, ?, ?, ?, ?)";
        preparedStatement = connection.prepareStatement(sql);

        // Set parameters
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, description);
        preparedStatement.setString(3, category);
        preparedStatement.setInt(4, price);
        preparedStatement.setString(5, details);
        preparedStatement.setString(6, image);

        // Execute the query
        int i = preparedStatement.executeUpdate();
        if(i>0){
            out.println("Product inserted successfully!");
%>
<script>
    alert("Product added Successfully");
</script>
<%         response.sendRedirect("adminIndex.jsp");
           }else{
             out.println("Product Not Inserted");
%>
<script>
    alert("Product is not added");
</script>
<%
}
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Close JDBC resources
        try {
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Form</title>
        <link rel="stylesheet" type="text/css" href="style.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
        <link rel="stylesheet" href="./css/header.css" />
        <link rel="stylesheet" href="./css/footer.css" />
        <link rel="stylesheet" href="./css/root.css" />
        <link rel="stylesheet" href="./css/category.css" />
        <style>

            .container-form {
                max-width: 600px;
                margin: 70px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                color: #333;
            }

            form {
                display: grid;
                gap: 10px;
            }

            label {
                font-weight: bold;
            }

/*            input,*/
            textarea {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            input[type="submit"] {
                background-color: #4caf50;
                color: #fff;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

        </style>
    </head>
    <body>
        <!-- Navigation Bar -->
        <header class="navbar navbar-expand-lg navbar-light">
            <div class="container">
                <a href="#" class="navbar-brand">
                    <img src="assets/cart.png" alt="" class="logo" /> Fashion Wear
                </a>

                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <form class="form-inline my-2 my-lg-0 ml-auto" style="padding-right: 3rem" action="SearchServlet" method="post">
                        <input class="form-control mr-sm-2" type="search" id="search-field" placeholder="Search"
                               aria-label="Search" name="search"/>
                        <input type="submit" value="Search" id="search" class="btn search-btn my-2 my-sm-0" />
                    </form>

                    <ul class="navbar-nav">
                        <li class="nav-item"><a href="adminIndex.jsp" class="nav-link">Home</a></li>
                        <li class="nav-item">
                            <a href="adminCategories.jsp" class="nav-link">Categories</a>
                        </li>
                        <%
                            if(session.getAttribute("name")!= null){
                        %>
                        <li class="nav-item nav-link"><a href="logout.jsp"><%= session.getAttribute("name") %></a></li>
                            <%    
                                }else{
                            %>
                        <li class="nav-item"><a href="login.jsp" class="nav-link">Login</a></li>
                            <%        
                                }
                            %>
                    </ul>
                </div>
            </div>
        </header>
        <div class="container-form">
            <h2>Product Information</h2>
            <form id="productForm" action="#" method="post">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>

                <label for="description">Description:</label>
                <textarea id="description" name="description" required></textarea>

                <label for="description">Description:</label>
                <select name="category">
                    <option>Select</option>
                    <option>Men</option>
                    <option>Women</option>
                    <option>Child</option>
                </select>

                <label for="price">Price:</label>
                <input type="number" id="price" name="price" required>
                
                <label for="details">More Details:</label>
                <textarea id="details" name="details" required></textarea>

                <label for="image">Image:</label>
                <input type="file" id="image" name="image" required>

                <input type="submit" value="Submit" name="submit">
            </form>
        </div>
        <!-- Footer -->
        <footer class="footer mt-auto">
            <div class="container-fluid text-center">
                <p>All rights reserved @ITech</p>
                <ul class="list-inline">
                    <li class="list-inline-item"><a href="adminAbout.jsp">About Us</a></li>
                    <li class="list-inline-item"><a href="adminContact.jsp">Contact Us</a></li>
                </ul>
            </div>
        </footer>
        <script src="script.js"></script>
    </body>
</html>
