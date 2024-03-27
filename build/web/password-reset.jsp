<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.io.PrintWriter" %>

<%
    if(request.getParameter("submit")!=null)
    {
        String email = request.getParameter("email");
        String sport = request.getParameter("sport");
        String pass = request.getParameter("password");

        Connection con = null;
        PreparedStatement pst = null;
        PrintWriter out2 = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "admin");

            pst = con.prepareStatement("select * from project where email=?");
            pst.setString(1, email);
            ResultSet result = pst.executeQuery();

            if (result.next()) {
                if (sport.equals(result.getString("sport"))) {
                    pst = con.prepareStatement("update project set pass=? where email=?");
                    pst.setString(1, pass);
                    pst.setString(2, email);
                    int i = pst.executeUpdate();

                    if (i > 0) {
                        response.sendRedirect("login.jsp");
%>
<script>
    alert("Password Reset Successful");
</script>
<%
} else {
%>
<script>
    alert("Oops! Password is not Updated");
</script>
<%
    out2.println("Data Not Updated");
}
} else {
%>
<script>
    alert("Favorite sport field Doesn't Match");
</script>
<%
out2.println("Favorite sport field Doesn't Match");
}
} else {
%>
<script>
    alert("Email Not Found");
</script>
<%
out2.println("Email not found");
}

} catch (Exception e) {
e.printStackTrace();
} finally {
try {
if (con != null) {
con.close();
}
if (pst != null) {
pst.close();
}
} catch (Exception e) {
e.printStackTrace();
}
}
}
%>        

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Ecommerce - Password reset</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
        <link rel="stylesheet" href="./css/header.css" />
        <link rel="stylesheet" href="./css/footer.css" />
        <link rel="stylesheet" href="./css/root.css" />
        <link rel="stylesheet" href="./css/login.css" />

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
                        <li class="nav-item"><a href="index.jsp" class="nav-link">Home</a></li>
                        <li class="nav-item">
                            <a href="category-three-cards.jsp" class="nav-link">Categories</a>
                        </li>
                        <li class="nav-item"><a href="cart.jsp" class="nav-link">Cart</a></li>
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

        <!-- Your Main Content Goes Here -->
        <section class="login-form">
            <div class="login">
                <form action="#" method="post">
                    <h1>Reset Password</h1>
                    <input type="text" name="email" placeholder="Enter Email" class="form-control" required/>
                    <input type="text" name="sport" placeholder="Enter Your Favourite Sports" class="form-control" required/>
                    <input type="password" name="password"  placeholder="Enter New Password" class="form-control" required/>
                    <button type="submit" name="submit" class="btn btn-primary">Reset Password</button>
                </form>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer mt-auto">
            <div class="container-fluid text-center">
                <p>All rights reserved @ITech</p>
                <ul class="list-inline">
                    <li class="list-inline-item"><a href="about.jsp">About Us</a></li>
                    <li class="list-inline-item"><a href="contact.jsp">Contact Us</a></li>
                </ul>
            </div>
        </footer>
    </body>
</html>
