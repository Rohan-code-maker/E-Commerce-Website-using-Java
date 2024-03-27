<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    Connection conSelect = null;
    PreparedStatement selectStatement = null;
    ResultSet result = null;
    String name = (String) session.getAttribute("name");
    try {
        conSelect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "admin");
        selectStatement = conSelect.prepareStatement("select * from cart where name = ?");
        selectStatement.setString(1,name);
        result = selectStatement.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Ecommerce - Cart</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="./css/header.css"/>
        <link rel="stylesheet" href="./css/footer.css"/>
        <link rel="stylesheet" href="./css/root.css"/>
        <link rel="stylesheet" href="./css/login.css"/>
        <link rel="stylesheet" href="./css/cart.css">
        <style>
            .Products {
                text-align: start;
                display: flex;
                justify-content: space-between;
                padding-right: 100px;
                border: 1px solid black;
            }

            .Products img {
                width: 150px;
                height: 150px;
            }
            .product-card{
                overflow-y: auto;
                max-height: 400px; 
            }
            .cart-summary{
                /*height: 450px;*/
            }

            .product-cart-details {
                padding-top: 45px;
                padding-left: 20px;
                border-left: 1px solid black;

            }
        </style>
    </head>
    <body>
        <!-- Navigation Bar -->
        <header class="navbar navbar-expand-lg navbar-light">
            <div class="container">
                <a href="#" class="navbar-brand">
                    <img src="assets/cart.png" alt="" class="logo"/> Fashion Wear
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
        <section class="cart-summary section">
            <div class="user-greeting">Hello User</div>
            <div class="cart-container cart-con">
                <!-- Product Cards (Horizontal) -->
                <div class="product-card">
                    <% if (result != null) {
                while (result.next()) { %>
                    <!-- Add content for Product Card here -->
                    <div class="Products">
                        <img src="assets/<%= result.getString("image")%>" alt="Photo Reloading">
                        <div class="product-cart-details">
                            <p id="product-name">Name: <%= result.getString("product_name") %></p>
                            <p id="product-price">Price: <%= result.getString("product_price") %></p>
                            <a href="deleteFromCart.jsp?id=<%= result.getInt("id") %>"><button class="btn btn-danger">Delete</button></a>
                        </div>
                    </div>
                    <% }
    } else { %>
                    <div class="empty-cart-message">Your cart is empty</div>
                    <% } %>
                </div>

                <div class="cart-summary card m1">
                    <h4>Cart Summary</h4>
                    <!-- Add content for Cart Summary here -->
                    <div class="cart-summary-line"></div>
                    <div>Total | Checkout | Payment</div>
                    <div class="cart-summary-line"></div>
                    <div>Total Amount</div>
                    <div>Current Address</div>

                    <!-- Payment Method and Make Payment Button -->
                    <div class="payment-method">
                        <label for="payment-method">Choose Payment Method:</label>
                        <select id="payment-method" class="form-control">
                            <option value="credit-card">Credit Card</option>
                            <option value="debit-card">Debit Card</option>
                            <option value="paypal">PayPal</option>
                        </select>
                    </div>
                    <button class="btn btn-primary make-payment-btn">Make Payment</button>
                </div>
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
