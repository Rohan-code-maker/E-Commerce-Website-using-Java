<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
  response.setHeader("Pragma", "no-cache"); // HTTP 1.0
  response.setDateHeader("Expires", 0); // Proxies
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Ecommerce - Login</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="./css/header.css"/>
        <link rel="stylesheet" href="./css/footer.css"/>
        <link rel="stylesheet" href="./css/root.css"/>
        <link rel="stylesheet" href="./css/login.css"/>
        <style>
            .forgotRegister {
                justify-content: space-evenly;
            }

            .col-mr-2 {
                width: 60%;
            }

            .col-ml-2 {
                width: 30%;
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
                                if (session.getAttribute("name") != null) {
                            %>
                        <li class="nav-item nav-link"><a href="logout.jsp"><%= session.getAttribute("name") %></a></li>
                            <%
                                } else {
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
                <form action="LoginServlet" method="post">
                    <h1>Login Form</h1>
                    <input type="text" name="email" placeholder="Enter Email" class="form-control" required/>
                    <input type="password" name="pass" placeholder="Enter Password" class="form-control" required/>
                    <input type="submit" name="submit" class="btn btn-primary" value="Login"/>
                    <div class="row forgotRegister">
                        <div class="col-mr-2 ">

                            <a href="password-reset.jsp"> <input type="button" class="btn btn-primary"
                                                                 value="Forgot Password?"/></a>
                        </div>
                        <div class="col-ml-2">
                            <a href="register.jsp"><input type="button" class="btn btn-primary" value="Register"/></a>
                        </div>
                    </div>
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
