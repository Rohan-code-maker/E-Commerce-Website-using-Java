<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*,jakarta.servlet.http.*" %>

<%
    Connection conSelect = null;
    PreparedStatement selectStatement = null;
    ResultSet result = null;

    try {
        conSelect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "admin");
        selectStatement = conSelect.prepareStatement("select * from project");
        result = selectStatement.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User's Details</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
        <link rel="stylesheet" href="./css/header.css" />
        <link rel="stylesheet" href="./css/footer.css" />
        <link rel="stylesheet" href="./css/root.css" />
        <style>
            body{
                min-height: 0;
            }
            .container-product-details{
                margin: 65px auto;
                min-height:65vh;
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
        <div class="container-product-details">
            <table class="table">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Address</th>
                        <th scope="col">Sport</th>
                        <th scope="col">Last Login</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (result != null) { 
                 while (result.next()) { %>
                    <tr>
                        <td><%= result.getString("name") %></td>
                        <td><%= result.getString("email") %></td>
                        <td><%= result.getString("address") %></td>
                        <td><%= result.getString("sport") %></td>
                        <%
                            Cookie[] cookies = request.getCookies();
                            String value = "";
                            for(Cookie c:cookies){
                            String tname = c.getName();
                            if(tname.equals("date")){
                            value = c.getValue();
                        %>
                        <td><%= result.getString("sport") %></td>

                        <%
                            }
                            }
                        %>
                    </tr>
                    <% } 
             } %>
                </tbody>
            </table>
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
    </body>
</html>
