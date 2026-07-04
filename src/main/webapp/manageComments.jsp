<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("admin")==null){

response.sendRedirect("adminLogin.jsp");

return;

}

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

String search=request.getParameter("search");

if(search==null)
search="";

int totalComments=0;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

ps=con.prepareStatement(

"SELECT COUNT(*) FROM comments"

);

rs=ps.executeQuery();

if(rs.next()){

totalComments=rs.getInt(1);

}

rs.close();

ps.close();

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Manage Comments</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<link rel="stylesheet"

href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<style>

*{

margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;

}

body{

background:#eef2ff;

}

.header{

background:linear-gradient(135deg,#2563eb,#4f46e5);

padding:35px;

text-align:center;

color:white;

}

.container{

width:1300px;

margin:35px auto;

}

.top{

display:flex;

justify-content:space-between;

align-items:center;

margin-bottom:30px;

}

.card{

background:white;

padding:25px 40px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}

.card h2{

font-size:38px;

color:#2563eb;

}

.card p{

margin-top:8px;

color:#6b7280;

}

.filters{

background:white;

padding:25px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

display:grid;

grid-template-columns:2fr auto;

gap:15px;

margin-bottom:30px;

}

.filters input{

padding:13px;

border:1px solid #d1d5db;

border-radius:10px;

outline:none;

font-size:15px;

}

.filters button{

background:#2563eb;

color:white;

border:none;

padding:13px 28px;

border-radius:10px;

cursor:pointer;

font-weight:600;

}

.filters button:hover{

background:#1d4ed8;

}

.table-box{

background:white;

padding:25px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}
table{

width:100%;

border-collapse:collapse;

}

th{

background:#2563eb;

color:white;

padding:15px;

}

td{

padding:15px;

border-bottom:1px solid #e5e7eb;

text-align:center;

vertical-align:top;

}

.action{

padding:8px 18px;

border-radius:8px;

color:white;

text-decoration:none;

font-size:14px;

font-weight:600;

display:inline-block;

}

.delete{

background:#dc2626;

}

.delete:hover{

background:#b91c1c;

}

.back{

display:inline-block;

margin-top:25px;

padding:12px 25px;

background:#6b7280;

color:white;

text-decoration:none;

border-radius:10px;

}

.back:hover{

background:#4b5563;

}

@media(max-width:1100px){

.container{

width:95%;

}

.filters{

grid-template-columns:1fr;

}

}

</style>

</head>

<body>

<div class="header">

<h1>

<i class="fa-solid fa-comments"></i>

Manage Comments

</h1>

<p>

View and Moderate Student Comments

</p>

</div>

<div class="container">

<div class="top">

<div class="card">

<h2><%=totalComments%></h2>

<p>Total Comments</p>

</div>

</div>

<form method="get" class="filters">

<input

type="text"

name="search"

placeholder="Search Comment..."

value="<%=search%>">

<button type="submit">

<i class="fa-solid fa-magnifying-glass"></i>

Search

</button>

</form>

<div class="table-box">

<table>

<tr>

<th>ID</th>

<th>Post ID</th>

<th>User ID</th>

<th>Comment</th>

<th>Created</th>

<th>Action</th>

</tr>

<%

String sql="SELECT * FROM comments WHERE 1=1";

if(!search.trim().equals("")){

sql+=" AND comment LIKE ?";

}

sql+=" ORDER BY created_at DESC";

ps=con.prepareStatement(sql);

if(!search.trim().equals("")){

ps.setString(1,"%"+search+"%");

}

rs=ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%=rs.getInt("comment_id")%></td>

<td><%=rs.getInt("post_id")%></td>

<td><%=rs.getInt("user_id")%></td>

<td style="text-align:left;">

<%=rs.getString("comment")%>

</td>

<td><%=rs.getString("created_at")%></td>

<td>

<a

href="deleteComment.jsp?id=<%=rs.getInt("comment_id")%>"

class="action delete"

onclick="return confirm('Delete this comment?');">

Delete

</a>

</td>

</tr>

<%

}

%>

</table>

<br>

<a href="adminDashboard.jsp" class="back">

<i class="fa-solid fa-arrow-left"></i>

Back to Dashboard

</a>

</div>
</div>

</div>

</body>

</html>

<%

}catch(Exception e){

out.println("<h2 style='color:red;text-align:center;'>");
out.println(e.getMessage());
out.println("</h2>");

e.printStackTrace();

}finally{

try{

if(rs!=null)

rs.close();

}catch(Exception e){}

try{

if(ps!=null)

ps.close();

}catch(Exception e){}

try{

if(con!=null)

con.close();

}catch(Exception e){}

}

%>