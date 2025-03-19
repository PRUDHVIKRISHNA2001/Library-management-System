<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Book</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Sedan+SC&display=swap');
        body {
            font-family: "Sedan SC", serif;
            font-size: 18.1px;
            font-style: normal;
            margin: 0;
            padding: 0;
            background-color: skyblue;
            color: white;
            background: url(libhome.jpg) no-repeat;
            background-size: cover;
            background-position: center;
        }
        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 19px;
            background-color: gray;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: white;
            margin-top: 0px;
        }
        form {
            display: grid;
            grid-gap: 20px;
        }
        label {
            font-weight: bold;
        }
        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            background-color: #333;
            color: white;
            font-family: "Sedan SC", serif;
            font-size: 16.2px;
            font-style: normal;
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #009bff;
            color: #333;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Add Book</h1>
    <form action="add-book.jsp" method="post">
        <label for="bookid">Book ID:</label>
        <input type="number" id="bid" name="bid" required>

        <label for="title">Title:</label>
        <input type="text" id="title" name="title" required>

        <label for="author">Author:</label>
        <input type="text" id="author" name="author" required>

        <label for="published_year">Published Year:</label>
        <input type="number" id="published_year" name="published_year" min="1000" max="9999" required>

		<label for="bookid">Quantity:</label>
        <input type="number" id="qty" name="qty" required>
		
        <label for="description">Description:</label>
        <textarea id="description" name="description" required></textarea>
        
        <input type="submit" value="Add Book">
    </form>
</div>
<%
try {
Class.forName("com.mysql.jdbc.Driver"); 
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/library?characterEncoding=latin1","root","Agrawal1683");
PreparedStatement ps = con.prepareStatement("insert into books values(?,?,?,?,?,?)");
ps.setInt(1, Integer.valueOf(request.getParameter("bid")));
ps.setString(2, request.getParameter("title"));
ps.setString(3, request.getParameter("author"));
ps.setInt(4, Integer.valueOf(request.getParameter("published_year")));
ps.setString(5, request.getParameter("description"));
ps.setInt(6, Integer.valueOf(request.getParameter("qty")));
int uq = ps.executeUpdate();
if (uq==1){
	System.out.println("Successfully Inserted");
}
}
catch(SQLException e){
	out.println("Unsuccessful!");
}
catch(Exception e){
	out.println(e);
}

%>
</body>
</html>
