<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){

response.sendRedirect("studentLogin.jsp");

return;

}

String keyword=request.getParameter("keyword");
String category=request.getParameter("category");

if(keyword==null) keyword="";
if(category==null) category="";

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

String sql="SELECT p.post_id,p.title,p.category,p.created_at,u.username "
+"FROM discussion_posts p "
+"JOIN users u ON p.user_id=u.user_id ";

if(!keyword.trim().equals("")){

sql+="WHERE p.title LIKE ? OR p.content LIKE ? ";

}else if(!category.trim().equals("")){

sql+="WHERE p.category=? ";

}

sql+="ORDER BY p.created_at DESC";

ps=con.prepareStatement(sql);

if(!keyword.trim().equals("")){

ps.setString(1,"%"+keyword+"%");
ps.setString(2,"%"+keyword+"%");

}else if(!category.trim().equals("")){

ps.setString(1,category);

}

rs=ps.executeQuery();

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Search Discussions</title>

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

.container{

width:1200px;

margin:40px auto;

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

text-align:center;

border-bottom:1px solid #e5e7eb;

}

.btn{

display:inline-block;

padding:9px 20px;

background:#2563eb;

color:white;

text-decoration:none;

border-radius:8px;

font-weight:600;

}

.btn:hover{

background:#1d4ed8;

}

.back{

background:#6b7280;

margin-top:25px;

}

.back:hover{

background:#4b5563;

}

.no-data{

text-align:center;

padding:40px;

font-size:18px;

color:#6b7280;

}

</style>

</head>

<body>

<div class="header">

<h1>

<i class="fa-solid fa-magnifying-glass"></i>

Search Results

</h1>

<p>

Find discussions based on keywords or categories.

</p>

</div>

<div class="container">

<div class="table-box">

<table>

<tr>

<th>Title</th>

<th>Category</th>

<th>Author</th>

<th>Date</th>

<th>Action</th>

</tr>

<%

boolean found=false;

while(rs.next()){

found=true;

%>

<tr>

<td>

<%=rs.getString("title")%>

</td>

<td>

<%=rs.getString("category")%>

</td>

<td>

<%=rs.getString("username")%>

</td>

<td>

<%=rs.getString("created_at")%>

</td>

<td>

<a

class="btn"

href="viewPost.jsp?post_id=<%=rs.getInt("post_id")%>">

View

</a>

</td>

</tr>

<%

}

if(!found){

%>

<tr>

<td colspan="5" class="no-data">

No discussions found.

</td>

</tr>

<%

}

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