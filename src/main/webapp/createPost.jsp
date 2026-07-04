<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){

response.sendRedirect("studentLogin.jsp");

return;

}

Connection con=null;
PreparedStatement ps=null;

String message="";
String error="";

if("POST".equalsIgnoreCase(request.getMethod())){

String title=request.getParameter("title");

String category=request.getParameter("category");

String content=request.getParameter("content");

int userId=(Integer)session.getAttribute("user_id");

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

ps=con.prepareStatement(

"INSERT INTO discussion_posts(user_id,title,content,category) VALUES(?,?,?,?)"

);

ps.setInt(1,userId);

ps.setString(2,title);

ps.setString(3,content);

ps.setString(4,category);

int i=ps.executeUpdate();

if(i>0){

response.sendRedirect("community.jsp");

return;

}

}catch(Exception e){

error=e.getMessage();

}finally{

try{

if(ps!=null)

ps.close();

}catch(Exception e){}

try{

if(con!=null)

con.close();

}catch(Exception e){}

}

}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Create Discussion</title>

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

text-align:center;

color:white;

}

.container{

width:800px;

margin:40px auto;

}
.form-box{

background:white;

padding:40px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}

.form-group{

margin-bottom:22px;

}

label{

display:block;

font-weight:600;

margin-bottom:8px;

color:#374151;

}

input[type=text],select,textarea{

width:100%;

padding:14px;

border:1px solid #d1d5db;

border-radius:10px;

font-size:15px;

outline:none;

transition:.3s;

}

input[type=text]:focus,

select:focus,

textarea:focus{

border-color:#2563eb;

}

textarea{

resize:vertical;

min-height:220px;

}

.buttons{

margin-top:30px;

display:flex;

gap:15px;

}

.btn{

display:inline-block;

padding:12px 28px;

border:none;

border-radius:10px;

font-size:15px;

font-weight:600;

cursor:pointer;

text-decoration:none;

transition:.3s;

}

.submit{

background:#2563eb;

color:white;

}

.submit:hover{

background:#1d4ed8;

}

.cancel{

background:#6b7280;

color:white;

}

.cancel:hover{

background:#4b5563;

}

.error{

background:#fee2e2;

color:#b91c1c;

padding:15px;

border-radius:10px;

margin-bottom:20px;

}

</style>

</head>

<body>

<div class="header">

<h1>

<i class="fa-solid fa-pen-to-square"></i>

Create New Discussion

</h1>

<p>

Ask your doubts and share your knowledge with the community.

</p>

</div>

<div class="container">

<div class="form-box">

<%

if(!error.equals("")){

%>

<div class="error">

<%=error%>

</div>

<%

}

%>

<form method="post">

<div class="form-group">

<label>Discussion Title</label>

<input

type="text"

name="title"

placeholder="Enter discussion title"

required>

</div>

<div class="form-group">

<label>Category</label>

<select name="category" required>

<option value="">Select Category</option>

<option value="Aptitude">Aptitude</option>

<option value="Coding">Coding</option>

<option value="Technical">Technical</option>

<option value="HR">HR Interview</option>

<option value="Placement">Placement</option>

<option value="General">General</option>

</select>

</div>

<div class="form-group">

<label>Description</label>

<textarea

name="content"

placeholder="Write your discussion here..."

required></textarea>

</div>

<div class="buttons">

<button

type="submit"

class="btn submit">

<i class="fa-solid fa-paper-plane"></i>

Post Discussion

</button>

<a

href="community.jsp"

class="btn cancel">

<i class="fa-solid fa-arrow-left"></i>

Cancel

</a>

</div>
</form>

</div>

</div>

</body>

</html>