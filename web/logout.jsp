<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
