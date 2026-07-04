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

ResultSet rs=null;

String error="";

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

//Update Discussion

if("POST".equalsIgnoreCase(request.getMethod())){

String title=request.getParameter("title");

String category=request.getParameter("category");

String content=request.getParameter("content");

ps=con.prepareStatement(

"UPDATE discussion_posts SET title=?,category=?,content=? WHERE post_id=? AND user_id=?"

);

ps.setString(1,title);

ps.setString(2,category);

ps.setString(3,content);

ps.setInt(4,postId);

ps.setInt(5,userId);

int i=ps.executeUpdate();

ps.close();

if(i>0){

response.sendRedirect("viewPost.jsp?post_id="+postId);

return;

}else{

error="You are not authorized to edit this discussion.";

}

}

//Load Existing Data

ps=con.prepareStatement(

"SELECT * FROM discussion_posts WHERE post_id=? AND user_id=?"

);

ps.setInt(1,postId);

ps.setInt(2,userId);

rs=ps.executeQuery();

if(rs.next()){

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Edit Discussion</title>

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

input[type=text],

select,

textarea{

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

display:flex;

gap:15px;

margin-top:30px;

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

.update{

background:#2563eb;

color:white;

}

.update:hover{

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

<i class="fa-solid fa-pen"></i>

Edit Discussion

</h1>

<p>

Update your discussion and save the changes.

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

value="<%=rs.getString("title")%>"

required>

</div>

<div class="form-group">

<label>Category</label>

<select name="category" required>

<option value="Aptitude"
<%=rs.getString("category").equals("Aptitude")?"selected":""%>>
Aptitude
</option>

<option value="Coding"
<%=rs.getString("category").equals("Coding")?"selected":""%>>
Coding
</option>

<option value="Technical"
<%=rs.getString("category").equals("Technical")?"selected":""%>>
Technical
</option>

<option value="HR"
<%=rs.getString("category").equals("HR")?"selected":""%>>
HR Interview
</option>

<option value="Placement"
<%=rs.getString("category").equals("Placement")?"selected":""%>>
Placement
</option>

<option value="General"
<%=rs.getString("category").equals("General")?"selected":""%>>
General
</option>

</select>

</div>

<div class="form-group">

<label>Discussion Content</label>

<textarea

name="content"

required><%=rs.getString("content")%></textarea>

</div>

<div class="buttons">

<button

type="submit"

class="btn update">

<i class="fa-solid fa-floppy-disk"></i>

Update Discussion

</button>

<a

href="viewPost.jsp?post_id=<%=postId%>"

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

<%

}else{

%>



<html>

<head>

<meta charset="UTF-8">

<title>Edit Discussion</title>

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

.box h2{

margin-bottom:15px;

color:#dc2626;

}

.box p{

color:#6b7280;

margin-bottom:25px;

}

a{

display:inline-block;

padding:12px 25px;

background:#2563eb;

color:white;

text-decoration:none;

border-radius:10px;

font-weight:600;

}

a:hover{

background:#1d4ed8;

}

</style>

</head>

<body>

<div class="box">

<h2>Discussion Not Found</h2>

<p>

This discussion does not exist or you are not authorized to edit it.

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