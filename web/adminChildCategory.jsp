<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    Connection conSelect = null;
    PreparedStatement selectStatement = null;
    ResultSet result = null;
    try {
        conSelect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "admin");
        selectStatement = conSelect.prepareStatement("select * from products where category=?");
        selectStatement.setString(1, "Child");
        result = selectStatement.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>ECOMMERCE - Category</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
        <link rel="stylesheet" href="./css/header.css" />
        <link rel="stylesheet" href="./css/footer.css" />
        <link rel="stylesheet" href="./css/root.css" />
        <link rel="stylesheet" href="./css/category.css" />


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

        <section class="section">
            <!-- Your Main Content Goes Here -->
            <div class="container mt-5">
                <p id="category-header">Your Passion Our Fashion</p>
                <div class="row">
                    <% if (result != null) {
                while (result.next()) { %>
                    <!-- Product Card 1 -->
                    <div class="col-12 col-md-6 col-lg-3 product-card">
                        <div class="card">
                            <img src="assets/<%= result.getString("image")%>"
                                 alt="Product Image" class="card-img-top product-img"/>
                            <div class="card-body">
                                <h5 class="card-title"><%= result.getString("name") %></h5>
                                <p class="card-text"><%= result.getString("description") %></p>
                                <p class="card-text"><%= result.getString("price") %></p>
                                <a href="admin-product-details.jsp?id=<%= result.getInt("id")%>" class="btn btn-info btn-more-details">
                                    More Details
                                </a>
                            </div>
                        </div>
                    </div>
                    <% }
            } %>
                </div>
            </div>
        </section>

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

        <!-- Bootstrap JS and Popper.js -->
        <script src="https://code.jquery.com/jquery-3.5.
