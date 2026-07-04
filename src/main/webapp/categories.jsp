<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){
    response.sendRedirect("studentLogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Aptitude Categories</title>

<style>

body{
font-family:'Segoe UI';
background:#f4f7fc;
padding:40px;
}

h1{
text-align:center;
margin-bottom:40px;
}

.grid{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
gap:25px;
}

.card{
background:white;
padding:30px;
border-radius:18px;
box-shadow:0 4px 20px rgba(0,0,0,.08);
text-align:center;
}

.card h2{
margin-bottom:20px;
}

.btn{
display:inline-block;
padding:12px 25px;
background:#2563eb;
color:white;
text-decoration:none;
border-radius:10px;
}

</style>
</head>

<body>

<h1>Select Aptitude Category</h1>

<div class="grid">

<%
try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

Statement st=con.createStatement();

ResultSet rs=st.executeQuery(
"select * from categories");

while(rs.next()){
%>

<div class="card">

<h2><%= rs.getString("category_name") %></h2>

<a class="btn"
href="quiz.jsp?category_id=<%= rs.getInt("category_id") %>">
Start Quiz
</a>

</div>

<%
}

con.close();

}catch(Exception e){
out.println(e);
}
%>

</div>

</body>
</html>