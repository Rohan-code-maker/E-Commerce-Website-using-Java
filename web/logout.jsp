<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
  response.setHeader("Pragma", "no-cache"); // HTTP 1.0
  response.setDateHeader("Expires", 0); // Proxies
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
        <script></script>
</head>
<body>

<%
    // Assuming you have a session variable named "user" that stores user information
    // You may replace this with your actual session management code
    if (session.getAttribute("name") != null) {
        // If the user is logged in, invalidate the session to log them out
        session.invalidate();
        response.sendRedirect("index.jsp");
    } else {
        // If the user is not logged in, redirect them to the login page or display a message
        response.sendRedirect("login.jsp");
    }
%>

</body>
</html>
