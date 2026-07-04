<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){

response.sendRedirect("studentLogin.jsp");

return;

}

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

int totalPosts=0;
int totalComments=0;
int totalLikes=0;
int myPosts=0;

int userId=(Integer)session.getAttribute("user_id");

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006");

//Total Posts

ps=con.prepareStatement(

"SELECT COUNT(*) FROM discussion_posts"

);

rs=ps.executeQuery();

if(rs.next()){

totalPosts=rs.getInt(1);

}

rs.close();

ps.close();

//Total Comments

ps=con.prepareStatement(

"SELECT COUNT(*) FROM discussion_comments"

);

rs=ps.executeQuery();

if(rs.next()){

totalComments=rs.getInt(1);

}

rs.close();

ps.close();

//Total Likes

ps=con.prepareStatement(

"SELECT COUNT(*) FROM post_likes"

);

rs=ps.executeQuery();

if(rs.next()){

totalLikes=rs.getInt(1);

}

rs.close();

ps.close();

//My Posts

ps=con.prepareStatement(

"SELECT COUNT(*) FROM discussion_posts WHERE user_id=?"

);

ps.setInt(1,userId);

rs=ps.executeQuery();

if(rs.next()){

myPosts=rs.getInt(1);

}

rs.close();

ps.close();

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Community Discussion</title>

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

padding:45px;

color:white;

text-align:center;

}

.header h1{

font-size:38px;

margin-bottom:10px;

}

.header p{

font-size:17px;

opacity:.9;

}

.dashboard-btn{

display:inline-block;

margin-top:20px;

padding:12px 25px;

background:white;

color:#2563eb;

text-decoration:none;

border-radius:10px;

font-weight:600;

}

.dashboard-btn:hover{

background:#e5e7eb;

}

.container{

width:1200px;

margin:40px auto;

}

.stats{

display:grid;

grid-template-columns:repeat(4,1fr);

gap:20px;

margin-bottom:35px;

}

.stat{

background:white;

padding:30px;

border-radius:18px;

text-align:center;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}

.stat i{

font-size:40px;

color:#2563eb;

margin-bottom:15px;

}

.stat h2{

font-size:34px;

color:#2563eb;

}

.stat p{

margin-top:10px;

color:#6b7280;

}

.actions{

display:grid;

grid-template-columns:repeat(2,1fr);

gap:25px;

margin-bottom:40px;

}
.search-box{

background:white;

padding:25px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

margin-bottom:35px;

}

.search-box form{

display:grid;

grid-template-columns:1fr 170px;

gap:15px;

}

.search-box input{

padding:14px;

border:1px solid #ddd;

border-radius:10px;

font-size:15px;

outline:none;

}

.search-box button{

border:none;

background:#2563eb;

color:white;

border-radius:10px;

font-size:15px;

font-weight:600;

cursor:pointer;

}

.search-box button:hover{

background:#1d4ed8;

}

.action{

background:white;

padding:30px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

text-align:center;

}

.action i{

font-size:50px;

color:#2563eb;

margin-bottom:20px;

}

.action h2{

margin-bottom:12px;

color:#111827;

}

.action p{

color:#6b7280;

line-height:26px;

margin-bottom:20px;

}

.btn{

display:inline-block;

padding:12px 26px;

background:#2563eb;

color:white;

text-decoration:none;

border-radius:10px;

font-weight:600;

transition:.3s;

}

.btn:hover{

background:#1d4ed8;

}

.categories{

display:grid;

grid-template-columns:repeat(3,1fr);

gap:20px;

margin-top:40px;

}

.category{

background:white;

padding:25px;

border-radius:16px;

text-align:center;

box-shadow:0 10px 30px rgba(0,0,0,.08);

transition:.3s;

}

.category:hover{

transform:translateY(-5px);

}

.category i{

font-size:40px;

color:#2563eb;

margin-bottom:15px;

}

.category h3{

margin-bottom:12px;

}

.category a{

text-decoration:none;

color:#2563eb;

font-weight:600;

}

@media(max-width:1000px){

.container{

width:95%;

}

.stats{

grid-template-columns:repeat(2,1fr);

}

.actions{

grid-template-columns:1fr;

}

.categories{

grid-template-columns:repeat(2,1fr);

}

}

@media(max-width:650px){

.stats{

grid-template-columns:1fr;

}

.categories{

grid-template-columns:1fr;

}

.search-box form{

grid-template-columns:1fr;

}

}

</style>

</head>

<body>

<div class="header">

<h1>

<i class="fa-solid fa-users"></i>

Community Discussion

</h1>

<p>

Ask Questions, Share Knowledge and Help Others Prepare for Placements.

</p>

<a href="dashboard.jsp" class="dashboard-btn">

<i class="fa-solid fa-house"></i>

Back to Dashboard

</a>

</div>

<div class="container">

<div class="stats">

<div class="stat">

<i class="fa-solid fa-comments"></i>

<h2><%=totalPosts%></h2>

<p>Total Posts</p>

</div>

<div class="stat">

<i class="fa-solid fa-message"></i>

<h2><%=totalComments%></h2>

<p>Total Comments</p>

</div>

<div class="stat">

<i class="fa-solid fa-thumbs-up"></i>

<h2><%=totalLikes%></h2>

<p>Total Likes</p>

</div>

<div class="stat">

<i class="fa-solid fa-user"></i>

<h2><%=myPosts%></h2>

<p>My Posts</p>

</div>

</div>

<div class="search-box">

<form action="searchDiscussion.jsp" method="get">

<input

type="text"

name="keyword"

placeholder="Search discussions...">

<button type="submit">

<i class="fa-solid fa-magnifying-glass"></i>

Search

</button>

</form>

</div>

<div class="actions">

<div class="action">

<i class="fa-solid fa-pen-to-square"></i>

<h2>Create New Post</h2>

<p>

Ask doubts, share interview experiences or discuss placement preparation.

</p>

<a href="createPost.jsp" class="btn">

Create Post

</a>

</div>

<div class="action">

<i class="fa-solid fa-folder-open"></i>

<h2>My Discussions</h2>

<p>

View, edit or delete the discussions that you have created.

</p>

<a href="myPosts.jsp" class="btn">

My Posts

</a>

</div>

</div>

<div class="categories">
<!-- Categories -->

<div class="category">

<i class="fa-solid fa-brain"></i>

<h3>Aptitude</h3>

<p style="color:#6b7280;margin-bottom:15px;">

Quantitative Aptitude, Logical Reasoning and Verbal Ability discussions.

</p>

<a href="searchDiscussion.jsp?category=Aptitude">

Explore

</a>

</div>

<div class="category">

<i class="fa-solid fa-code"></i>

<h3>Coding</h3>

<p style="color:#6b7280;margin-bottom:15px;">

Programming problems, DSA, coding interview preparation and solutions.

</p>

<a href="searchDiscussion.jsp?category=Coding">

Explore

</a>

</div>

<div class="category">

<i class="fa-solid fa-laptop-code"></i>

<h3>Technical</h3>

<p style="color:#6b7280;margin-bottom:15px;">

DBMS, OS, CN, OOP, Java, SQL and other technical subjects.

</p>

<a href="searchDiscussion.jsp?category=Technical">

Explore

</a>

</div>

<div class="category">

<i class="fa-solid fa-user-tie"></i>

<h3>HR Interview</h3>

<p style="color:#6b7280;margin-bottom:15px;">

HR questions, communication skills and interview tips.

</p>

<a href="searchDiscussion.jsp?category=HR">

Explore

</a>

</div>

<div class="category">

<i class="fa-solid fa-briefcase"></i>

<h3>Placement</h3>

<p style="color:#6b7280;margin-bottom:15px;">

Company hiring process, placement experiences and career guidance.

</p>

<a href="searchDiscussion.jsp?category=Placement">

Explore

</a>

</div>

<div class="category">

<i class="fa-solid fa-lightbulb"></i>

<h3>General</h3>

<p style="color:#6b7280;margin-bottom:15px;">

General discussions, announcements and miscellaneous doubts.

</p>

<a href="searchDiscussion.jsp?category=General">

Explore

</a>

</div>

</div>

<!-- Recent Discussions -->

<div style="margin-top:45px;
background:white;
padding:30px;
border-radius:18px;
box-shadow:0 10px 30px rgba(0,0,0,.08);">

<h2 style="margin-bottom:25px;">

Recent Discussions

</h2>

<table style="width:100%;border-collapse:collapse;">

<tr style="background:#2563eb;color:white;">

<th style="padding:15px;">Title</th>

<th>Category</th>

<th>Date</th>

<th>View</th>

</tr>

<%

ps=con.prepareStatement(

"SELECT post_id,title,category,created_at FROM discussion_posts ORDER BY created_at DESC LIMIT 10"

);

rs=ps.executeQuery();

while(rs.next()){

%>

<tr>

<td style="padding:15px;border-bottom:1px solid #eee;">

<%=rs.getString("title")%>

</td>

<td style="border-bottom:1px solid #eee;">

<%=rs.getString("category")%>

</td>

<td style="border-bottom:1px solid #eee;">

<%=rs.getString("created_at")%>

</td>

<td style="border-bottom:1px solid #eee;">

<a

class="btn"

href="viewPost.jsp?post_id=<%=rs.getInt("post_id")%>">

View

</a>

</td>

</tr>

<%

}

rs.close();

ps.close();

%>

</table>

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