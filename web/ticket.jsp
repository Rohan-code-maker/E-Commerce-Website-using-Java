<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
    
    // Declare variables
    List<Map<String, String>> productList = new ArrayList<>();
    double totalPrice = 0.0;
    double vatRate = 0.1;
    double discountRate = 0.05;
    double vatAmount = 0.0;
    double discountAmount = 0.0;
    double finalAmount = 0.0;

    // Database connection and query
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        Connection conSelect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "admin");
        PreparedStatement selectStatement = conSelect.prepareStatement("select * from products where id =?");
        selectStatement.setInt(1, id);
        ResultSet result = selectStatement.executeQuery();

        // Calculate total price and store product data
        while (result.next()) {
            Map<String, String> product = new HashMap<>();
            product.put("name", result.getString("name"));
            product.put("price", result.getString("price"));
            productList.add(product);
            
            double price = Double.parseDouble(result.getString("price"));
            totalPrice += price;
        }
        
        vatAmount = totalPrice * vatRate;
        discountAmount = totalPrice * discountRate;
        finalAmount = totalPrice + vatAmount - discountAmount;

        conSelect.close();
    } catch (Exception e) {
        e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Ticket Invoice</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto py-8">
        <h1 class="text-3xl font-bold mb-4">Ticket Invoice</h1>
        <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
            <!-- Invoice content -->
            <div class="text-lg font-bold mb-4">Invoice #0472</div>
            <div>Online Booking</div>
            <div>Tramba-22, Rajkot, India</div>
            <div>March 23, 2024</div>
            <div class="mt-8 font-bold">BILL TO</div>
            <div><%= session.getAttribute("name") %></div>
            <table class="table-auto w-full mt-8">
                <thead>
                    <tr>
                        <th class="px-4 py-2">ITEM</th>
                        <th class="px-4 py-2">PRICE</th>
                        <th class="px-4 py-2">QTY</th>
                        <th class="px-4 py-2">OFF</th>
                        <th class="px-4 py-2">TOTAL</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, String> product : productList) { %>
                        <tr>
                            <td class="border px-4 py-2"><%= product.get("name") %></td>
                            <td class="border px-4 py-2">$<%= product.get("price") %></td>
                            <td class="border px-4 py-2">1</td>
                            <td class="border px-4 py-2">0%</td>
                            <td class="border px-4 py-2">$<%= product.get("price") %></td>
                        </tr>
                    <% } %>
                </tbody>
                <tfoot>
                    <tr>
                        <td class="border px-4 py-2 font-bold">SUBTOTAL</td>
                        <td class="border px-4 py-2" colspan="4">$<%= totalPrice %></td>
                    </tr>
                    <tr>
                        <td class="border px-4 py-2 font-bold">TAX RATE</td>
                        <td class="border px-4 py-2" colspan="4">10%</td>
                    </tr>
                    <tr>
                        <td class="border px-4 py-2 font-bold">DISCOUNT</td>
                        <td class="border px-4 py-2" colspan="4">$<%= discountAmount %></td>
                    </tr>
                    <tr>
                        <td class="border px-4 py-2 font-bold">TOTAL</td>
                        <td class="border px-4 py-2" colspan="4">$<%= finalAmount %></td>
                    </tr>
                </tfoot>
            </table>

            <button id="downloadBtn" class="mt-4 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                Download PDF
            </button>
        </div>
    </div>
    <script>
        document.getElementById('downloadBtn').addEventListener('click', function () {
            console.log('Download button clicked');
            var doc = new window.jspdf.jsPDF();
            doc.setFontSize(16);
            doc.setFont('helvetica', 'bold');
            doc.text('Invoice', 10, 15);

            doc.setFontSize(12);
            doc.setFont('helvetica', 'normal');
            doc.text('Invoice #0472', 10, 30);
            doc.text('Date: March 23, 2024', 10, 45);
            doc.text('Customer: <%= session.getAttribute("name") %>', 10, 60);
            doc.text('Address: Tramba-22, Rajkot, India', 10, 75);

            doc.setFont('helvetica', 'bold');
            doc.text('-------------------------------------------------------------------------------------------------', 10, 90);
            doc.text('ITEM', 10, 105);
            doc.text('PRICE', 60, 105);
            doc.text('QTY', 100, 105);
            doc.text('DISCOUNT', 140, 105);
            doc.text('TOTAL', 180, 105);
            doc.text('--------------------------------------------------------------------------------------------------', 10, 110);

            var yPosition = 125; // Initial position for product details
            <% for (Map<String, String> product : productList) { %>
                doc.setFont('helvetica', 'normal');
                doc.text('<%= product.get("name") %>', 10, yPosition);
                doc.text('$<%= product.get("price") %>', 60, yPosition);
                doc.text('0%', 100, yPosition);
                doc.text('$<%= product.get("price") %>', 140, yPosition);
                yPosition += 15; // Increment y position for next product
            <% } %>

            doc.setFont('helvetica', 'bold');
            doc.text('---------------------------------------------------------------------------------------------------', 10, yPosition);
            doc.text('SUBTOTAL', 10, yPosition + 15);
            doc.text('$<%= totalPrice %>', 140, yPosition + 15);
            doc.text('TAX RATE (10%)', 10, yPosition + 30);
            doc.text('$<%= vatAmount %>', 140, yPosition + 30);
            doc.text('DISCOUNT', 10, yPosition + 45);
            doc.text('$<%= discountAmount %>', 140, yPosition + 45);
            doc.text('TOTAL', 10, yPosition + 60);
            doc.text('$<%= finalAmount %>', 140, yPosition + 60);
            doc.text('-----------------------------------------------------------------------------------------------------', 10, yPosition + 75);
            doc.save('invoice.pdf');
            console.log('PDF saved');
        });
    </script>
</body>
</html>
