<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="./css/category-three.css" />

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
        <section class="section">
            <!-- Your Main Content Goes Here -->
            <div class="container mt-5">
                <p id="category-header">Your Categories goes here</p>
                <div class="row">
                    <!-- Category Card 1 (Men) -->
                    <div class="col-12 col-md-4 category-card">
                        <div class="card">
                            <img src="assets/men2.avif" alt="Men Category" class="card-img-top category-img" />
                            <div class="card-body">
                                <h5 class="card-title">Men</h5>
                                <p class="card-text">Explore the latest trends for men.</p>
                                <a href="menCategory.jsp" class="btn btn-info btn-more-details"> Explore </a>
                            </div>
                        </div>
                    </div>
                    <!-- Category Card 2 (Women) -->
                    <div class="col-12 col-md-4 category-card">
                        <div class="card">
                            <img src="assets/women6.avif" alt="Women Category"
                                 class="card-img-top category-img" />
                            <div class="card-body">
                                <h5 class="card-title">Women</h5>
                                <p class="card-text">Discover the latest fashion for women.</p>
                                <a href="womenCategory.jsp" class="btn btn-info btn-more-details"> Explore </a>
                            </div>
                        </div>
                    </div>
                    <!-- Category Card 3 (Child) -->
                    <div class="col-12 col-md-4 category-card">
                        <div class="card">
                            <img src="assets/child2.jpg" alt="Child Category"
                                 class="card-img-top category-img" />
                            <div class="card-body">
                                <h5 class="card-title">Child</h5>
                                <p class="card-text">Cute and comfortable clothing for kids.</p>
                                <a href="childCategory.jsp" class="btn btn-info btn-more-details"> Explore </a>
                            </div>
                        </div>
                    </div>
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

        <!-- Bootstrap JS and Popper.js -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
