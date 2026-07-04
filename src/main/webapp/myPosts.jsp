<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){

response.sendRedirect("studentLogin.jsp");

return;

}

int userId=(Integer)session.getAttribute("user_id");

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

int totalPosts=0;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

ps=con.prepareStatement(

"SELECT COUNT(*) FROM discussion_posts WHERE user_id=?"

);

ps.setInt(1,userId);

rs=ps.executeQuery();

if(rs.next()){

totalPosts=rs.getInt(1);

}

rs.close();

ps.close();

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>My Discussions</title>

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

padding:40px;

color:white;

text-align:center;

}

.header h1{

font-size:38px;

margin-bottom:10px;

}

.container{

width:1200px;

margin:40px auto;

}

.stat{

background:white;

padding:25px;

border-radius:18px;

text-align:center;

box-shadow:0 10px 30px rgba(0,0,0,.08);

margin-bottom:35px;

}

.stat h2{

font-size:40px;

color:#2563eb;

margin-bottom:10px;

}

.table-box{

background:white;

padding:30px;

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

}

.btn{

display:inline-block;

padding:8px 18px;

border-radius:8px;

text-decoration:none;

color:white;

font-size:14px;

font-weight:600;

margin:2px;

}

.view{

background:#2563eb;

}

.edit{

background:#16a34a;

}

.delete{

background:#dc2626;

}

.back{

background:#6b7280;

padding:12px 24px;

margin-top:25px;

}

.btn:hover{

opacity:.9;

}

</style>

</head>

<body>

<div class="header">

<h1>

<i class="fa-solid fa-folder-open"></i>

My Discussions

</h1>

<p>

Manage all your community posts.

</p>

</div>

<div class="container">

<div class="stat">

<h2>

<%=totalPosts%>

</h2>

<p>

Total Discussions Created

</p>

</div>

<div class="table-box">

<table>

<tr>

<th>Title</th>

<th>Category</th>

<th>Date</th>

<th>Actions</th>

</tr>
<%

ps=con.prepareStatement(

"SELECT * FROM discussion_posts WHERE user_id=? ORDER BY created_at DESC"

);

ps.setInt(1,userId);

rs=ps.executeQuery();

while(rs.next()){

%>

<tr>

<td>

<%=rs.getString("title")%>

</td>

<td>

<%=rs.getString("category")%>

</td>

<td>

<%=rs.getString("created_at")%>

</td>

<td>

<a

href="viewPost.jsp?post_id=<%=rs.getInt("post_id")%>"

class="btn view">

<i class="fa-solid fa-eye"></i>

View

</a>

<a

href="editPost.jsp?post_id=<%=rs.getInt("post_id")%>"

class="btn edit">

<i class="fa-solid fa-pen"></i>

Edit

</a>

<a

href="deletePost.jsp?post_id=<%=rs.getInt("post_id")%>"

class="btn delete"

onclick="return confirm('Are you sure you want to delete this discussion?');">

<i class="fa-solid fa-trash"></i>

Delete

</a>

</td>

</tr>

<%

}

rs.close();

ps.close();

%>

</table>

<br>

<a

href="community.jsp"

class="btn back">

<i class="fa-solid fa-arrow-left"></i>

Back to Community

</a>

</div>
</div>

</div>

</body>

</html>

<%

}catch(Exception e){

out.println(

"<h2 style='color:red;text-align:center;'>"

+e.getMessage()+

"</h2>"

);

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