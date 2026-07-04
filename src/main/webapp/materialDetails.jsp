<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){

response.sendRedirect("studentLogin.jsp");

return;

}

int materialId=Integer.parseInt(request.getParameter("material_id"));

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006");

ps=con.prepareStatement(

"SELECT * FROM study_materials WHERE material_id=?"

);

ps.setInt(1,materialId);

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

width:900px;

margin:40px auto;

}

.card{

background:white;

padding:35px;

border-radius:20px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}

.title{

font-size:34px;

color:#2563eb;

margin-bottom:15px;

}

.info{

display:grid;

grid-template-columns:repeat(2,1fr);

gap:20px;

margin:30px 0;

}

.box{

background:#f8fafc;

padding:18px;

border-radius:12px;

}

.box h4{

color:#2563eb;

margin-bottom:8px;

}

.description{

background:#f8fafc;

padding:25px;

border-radius:12px;

margin:25px 0;

line-height:28px;

}

.actions{

margin-top:30px;

display:flex;

gap:20px;

flex-wrap:wrap;

}

.btn{

display:inline-block;

padding:12px 24px;

background:#2563eb;

color:white;

text-decoration:none;

border-radius:10px;

font-weight:600;

}

.btn:hover{

background:#1d4ed8;

}

.back{

background:#6b7280;

}

.back:hover{

background:#4b5563;

}

</style>

</head>

<body>

<div class="container">

<div class="card">

<h1 class="title">

<%=rs.getString("title")%>

</h1>
<div class="info">

<div class="box">

<h4>Subject</h4>

<p>

<%=rs.getString("subject")%>

</p>

</div>

<div class="box">

<h4>Resource Type</h4>

<p>

<%=rs.getString("resource_type")%>

</p>

</div>

<%

if(rs.getString("company_name")!=null &&
!rs.getString("company_name").trim().equals("")){

%>

<div class="box">

<h4>Company</h4>

<p>

<%=rs.getString("company_name")%>

</p>

</div>

<%

}

%>

<div class="box">

<h4>Uploaded On</h4>

<p>

<%=rs.getString("upload_date")%>

</p>

</div>

</div>

<div class="description">

<h3 style="color:#2563eb;margin-bottom:15px;">

Description

</h3>

<p>

<%=rs.getString("description")%>

</p>

</div>

<div class="actions">

<%

String type=rs.getString("resource_type");

if(type.equals("Video")){

%>

<a

class="btn"

target="_blank"

href="<%=rs.getString("video_link")%>">

<i class="fa-solid fa-circle-play"></i>

Watch Video

</a>

<%

}else{

%>

<a

class="btn"

href="downloadMaterial.jsp?material_id=<%=materialId%>">

<i class="fa-solid fa-download"></i>

Download PDF

</a>

<%

}

%>

<a

class="btn back"

href="viewMaterial.jsp?type=<%=type%>">

<i class="fa-solid fa-arrow-left"></i>

Back

</a>

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

<title>Material Not Found</title>

<style>

body{

font-family:Arial;

background:#eef2ff;

display:flex;

justify-content:center;

align-items:center;

height:100vh;

}

.box{

background:white;

padding:40px;

border-radius:15px;

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

border-radius:8px;

}

</style>

</head>

<body>

<div class="box">

<h2>

Material Not Found

</h2>

<p>

The requested study material does not exist.

</p>

<a href="studyMaterial.jsp">

Back to Study Materials

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