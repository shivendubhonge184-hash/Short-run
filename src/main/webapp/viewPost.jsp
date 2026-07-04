<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){

response.sendRedirect("studentLogin.jsp");

return;

}

int userId=(Integer)session.getAttribute("user_id");

int postId=Integer.parseInt(request.getParameter("post_id"));

Connection con=null;

PreparedStatement ps=null;

PreparedStatement ps2=null;

ResultSet rs=null;

ResultSet rsComments=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

//Insert Comment

if("POST".equalsIgnoreCase(request.getMethod())){

String comment=request.getParameter("comment");

if(comment!=null && !comment.trim().equals("")){

ps=con.prepareStatement(

"INSERT INTO discussion_comments(post_id,user_id,comment) VALUES(?,?,?)"

);

ps.setInt(1,postId);

ps.setInt(2,userId);

ps.setString(3,comment);

ps.executeUpdate();

ps.close();

response.sendRedirect("viewPost.jsp?post_id="+postId);

return;

}

}

//Fetch Discussion

ps=con.prepareStatement(

"SELECT p.*,u.username FROM discussion_posts p JOIN users u ON p.user_id=u.user_id WHERE p.post_id=?"

);

ps.setInt(1,postId);

rs=ps.executeQuery();

if(rs.next()){

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title><%=rs.getString("title")%></title>

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

.container{

width:1100px;

margin:40px auto;

}

.post{

background:white;

padding:35px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

margin-bottom:30px;

}

.post h1{

color:#111827;

margin-bottom:15px;

}

.meta{

display:flex;

gap:20px;

color:#6b7280;

margin-bottom:20px;

font-size:15px;

flex-wrap:wrap;

}

.category{

display:inline-block;

background:#2563eb;

color:white;

padding:6px 14px;

border-radius:20px;

font-size:14px;

margin-bottom:20px;

}

.content{

line-height:30px;

font-size:16px;

color:#374151;

margin-top:15px;

white-space:pre-wrap;

}
.actions{

margin-top:30px;

display:flex;

gap:15px;

flex-wrap:wrap;

}

.btn{

display:inline-block;

padding:10px 22px;

border-radius:10px;

text-decoration:none;

font-weight:600;

color:white;

transition:.3s;

}

.like{

background:#16a34a;

}

.like:hover{

background:#15803d;

}

.edit{

background:#2563eb;

}

.edit:hover{

background:#1d4ed8;

}

.delete{

background:#dc2626;

}

.delete:hover{

background:#b91c1c;

}

.back{

background:#6b7280;

}

.back:hover{

background:#4b5563;

}

.comments{

background:white;

padding:35px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

margin-top:30px;

}

.comment{

padding:20px;

border-bottom:1px solid #e5e7eb;

}

.comment:last-child{

border-bottom:none;

}

.comment h4{

color:#2563eb;

margin-bottom:8px;

}

.comment p{

color:#374151;

line-height:28px;

margin-bottom:8px;

}

.comment small{

color:#6b7280;

}

.comment-form{

margin-top:35px;

}

textarea{

width:100%;

padding:15px;

border:1px solid #d1d5db;

border-radius:10px;

resize:vertical;

min-height:130px;

font-size:15px;

outline:none;

margin-bottom:20px;

}

textarea:focus{

border-color:#2563eb;

}

button{

background:#2563eb;

color:white;

border:none;

padding:12px 25px;

border-radius:10px;

font-size:15px;

cursor:pointer;

font-weight:600;

}

button:hover{

background:#1d4ed8;

}

</style>

</head>

<body>

<div class="container">

<div class="post">

<span class="category">

<%=rs.getString("category")%>

</span>

<h1>

<%=rs.getString("title")%>

</h1>

<div class="meta">

<span>

<i class="fa-solid fa-user"></i>

<%=rs.getString("username")%>

</span>

<span>

<i class="fa-solid fa-calendar"></i>

<%=rs.getString("created_at")%>

</span>

</div>

<div class="content">

<%=rs.getString("content")%>

</div>

<div class="actions">

<a

href="likePost.jsp?post_id=<%=postId%>"

class="btn like">

<i class="fa-solid fa-thumbs-up"></i>

Like

</a>

<%

if(userId==rs.getInt("user_id")){

%>

<a

href="editPost.jsp?post_id=<%=postId%>"

class="btn edit">

<i class="fa-solid fa-pen"></i>

Edit

</a>

<a

href="deletePost.jsp?post_id=<%=postId%>"

class="btn delete"

onclick="return confirm('Delete this discussion?')">

<i class="fa-solid fa-trash"></i>

Delete

</a>

<%

}

%>

<a

href="community.jsp"

class="btn back">

<i class="fa-solid fa-arrow-left"></i>

Back

</a>

</div>

</div>

<div class="comments">

<h2>

Comments

</h2>

<br>

<%

ps2=con.prepareStatement(

"SELECT c.*,u.username FROM discussion_comments c JOIN users u ON c.user_id=u.user_id WHERE c.post_id=? ORDER BY c.created_at DESC"

);

ps2.setInt(1,postId);

rsComments=ps2.executeQuery();

while(rsComments.next()){

%>

<div class="comment">

<h4>

<%=rsComments.getString("username")%>

</h4>

<p>

<%=rsComments.getString("comment")%>

</p>

<small>

<%=rsComments.getString("created_at")%>

</small>

</div>

<%

}

%>

<div class="comment-form">

<h3>

Add Comment

</h3>

<br>

<form method="post">

<textarea

name="comment"

placeholder="Write your comment..."

required>

</textarea>

<button type="submit">

<i class="fa-solid fa-paper-plane"></i>

Post Comment

</button>

</form>

</div>

</div>
</div>

</body>

</html>

<%

}else{

%>



<html>

<head>

<meta charset="UTF-8">

<title>Discussion Not Found</title>

<style>

body{

font-family:'Poppins',sans-serif;

background:#eef2ff;

display:flex;

justify-content:center;

align-items:center;

height:100vh;

}

.box{

background:white;

padding:40px;

border-radius:18px;

text-align:center;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}

a{

display:inline-block;

margin-top:20px;

padding:12px 25px;

background:#2563eb;

color:white;

text-decoration:none;

border-radius:10px;

font-weight:600;

}

</style>

</head>

<body>

<div class="box">

<h2>Discussion Not Found</h2>

<p>

The discussion you are looking for does not exist.

</p>

<a href="community.jsp">

Back to Community

</a>

</div>

</body>

</html>

<%

}

}catch(Exception e){

out.println(

"<h2 style='color:red;text-align:center;'>"

+e.getMessage()+

"</h2>"

);

e.printStackTrace();

}finally{

try{

if(rsComments!=null)

rsComments.close();

}catch(Exception e){}

try{

if(rs!=null)

rs.close();

}catch(Exception e){}

try{

if(ps2!=null)

ps2.close();

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