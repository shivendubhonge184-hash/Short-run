<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){
    response.sendRedirect("studentLogin.jsp");
    return;
}

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

int notes=0;
int pyqs=0;
int interviews=0;
int videos=0;
int totalResources=0;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

//Total Resources

ps=con.prepareStatement(
"SELECT COUNT(*) FROM study_materials");

rs=ps.executeQuery();

if(rs.next()){

totalResources=rs.getInt(1);

}

rs.close();
ps.close();

//Notes

ps=con.prepareStatement(
"SELECT COUNT(*) FROM study_materials WHERE resource_type='Notes'");

rs=ps.executeQuery();

if(rs.next()){

notes=rs.getInt(1);

}

rs.close();
ps.close();

//PYQs

ps=con.prepareStatement(
"SELECT COUNT(*) FROM study_materials WHERE resource_type='PYQ'");

rs=ps.executeQuery();

if(rs.next()){

pyqs=rs.getInt(1);

}

rs.close();
ps.close();

//Interview Experiences

ps=con.prepareStatement(
"SELECT COUNT(*) FROM study_materials WHERE resource_type='Interview Experience'");

rs=ps.executeQuery();

if(rs.next()){

interviews=rs.getInt(1);

}

rs.close();
ps.close();

//Videos

ps=con.prepareStatement(
"SELECT COUNT(*) FROM study_materials WHERE resource_type='Video'");

rs=ps.executeQuery();

if(rs.next()){

videos=rs.getInt(1);

}

rs.close();
ps.close();

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Study Material</title>

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

padding:28px;

border-radius:16px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

text-align:center;

}

.stat i{

font-size:36px;

color:#2563eb;

margin-bottom:15px;

}

.stat h2{

font-size:34px;

color:#2563eb;

}

.stat p{

margin-top:8px;

color:#6b7280;

}

.resources{

display:grid;

grid-template-columns:repeat(2,1fr);

gap:25px;

}
.subject{

background:white;

padding:30px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

transition:.3s;

}

.subject:hover{

transform:translateY(-6px);

}

.subject i{

font-size:48px;

color:#2563eb;

margin-bottom:20px;

}

.subject h2{

color:#111827;

margin-bottom:12px;

}

.subject p{

color:#6b7280;

line-height:26px;

margin-bottom:18px;

}

.subject h3{

color:#2563eb;

margin-bottom:22px;

}

.btn{

display:inline-block;

padding:12px 28px;

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

@media(max-width:1000px){

.container{

width:95%;

}

.stats{

grid-template-columns:repeat(2,1fr);

}

.resources{

grid-template-columns:1fr;

}

}

@media(max-width:600px){

.stats{

grid-template-columns:1fr;

}

}
.dashboard-btn{

display:inline-block;

margin-top:20px;

padding:12px 28px;

background:white;

color:#2563eb;

text-decoration:none;

border-radius:10px;

font-weight:600;

transition:.3s;

}

.dashboard-btn:hover{

background:#e5e7eb;

}

</style>

</head>

<body>

<div class="header">

<h1>

<i class="fa-solid fa-book-open-reader"></i>

Study Material

</h1>

<p>

Access Notes, Previous Year Questions, Interview Experiences and Video Resources

</p>
<a href="dashboard.jsp" class="dashboard-btn">

<i class="fa-solid fa-house"></i>

Back to Dashboard

</a>

</div>

<div class="container">

<div class="stats">

<div class="stat">

<i class="fa-solid fa-folder-open"></i>

<h2><%=totalResources%></h2>

<p>Total Resources</p>

</div>

<div class="stat">

<i class="fa-solid fa-book"></i>

<h2><%=notes%></h2>

<p>Notes</p>

</div>

<div class="stat">

<i class="fa-solid fa-file-lines"></i>

<h2><%=pyqs%></h2>

<p>PYQs</p>

</div>

<div class="stat">

<i class="fa-solid fa-video"></i>

<h2><%=videos%></h2>

<p>Videos</p>

</div>

</div>

<div class="resources">

<!-- Notes -->

<div class="subject">

<i class="fa-solid fa-book-open"></i>

<h2>Study Notes</h2>

<p>

Download subject-wise notes for Operating Systems, DBMS, Computer Networks, OOP, Aptitude and other placement topics.

</p>

<h3>

<%=notes%> Resources Available

</h3>

<a class="btn"

href="viewMaterial.jsp?type=Notes">

Browse Notes

</a>

</div>

<!-- PYQs -->

<div class="subject">

<i class="fa-solid fa-file-circle-question"></i>

<h2>Previous Year Questions</h2>

<p>

Practice company-wise Previous Year Questions from TCS, Infosys, Accenture, Wipro, Cognizant and more.

</p>

<h3>

<%=pyqs%> Resources Available

</h3>

<a class="btn"

href="viewMaterial.jsp?type=PYQ">

View PYQs

</a>

</div>
<!-- Interview Experiences -->

<div class="subject">

<i class="fa-solid fa-user-tie"></i>

<h2>Interview Experiences</h2>

<p>

Read interview experiences of students placed in top companies to understand the interview process and commonly asked questions.

</p>

<h3>

<%=interviews%> Resources Available

</h3>

<a class="btn"
href="viewMaterial.jsp?type=Interview Experience">

Read Experiences

</a>

</div>

<!-- Video Resources -->

<div class="subject">

<i class="fa-solid fa-circle-play"></i>

<h2>Video Resources</h2>

<p>

Watch high-quality video lectures and placement preparation playlists for technical subjects and aptitude.

</p>

<h3>

<%=videos%> Resources Available

</h3>

<a class="btn"
href="viewMaterial.jsp?type=Video">

Watch Videos

</a>

</div>

</div>

<!-- Recent Resources -->

<div style="margin-top:50px;
background:white;
padding:30px;
border-radius:18px;
box-shadow:0 10px 30px rgba(0,0,0,.08);">

<h2 style="margin-bottom:25px;">

Recently Added Resources

</h2>

<table style="width:100%;border-collapse:collapse;">

<tr style="background:#2563eb;color:white;">

<th style="padding:15px;">Title</th>

<th>Subject</th>

<th>Type</th>

<th>Date</th>

<th>Action</th>

</tr>

<%

ps=con.prepareStatement(

"SELECT material_id,title,subject,resource_type,upload_date FROM study_materials ORDER BY upload_date DESC LIMIT 10"

);

rs=ps.executeQuery();

while(rs.next()){

%>

<tr>

<td style="padding:15px;border-bottom:1px solid #eee;">

<%=rs.getString("title")%>

</td>

<td style="border-bottom:1px solid #eee;">

<%=rs.getString("subject")%>

</td>

<td style="border-bottom:1px solid #eee;">

<%=rs.getString("resource_type")%>

</td>

<td style="border-bottom:1px solid #eee;">

<%=rs.getString("upload_date")%>

</td>

<td style="border-bottom:1px solid #eee;">

<a class="btn"

href="materialDetails.jsp?material_id=<%=rs.getInt("material_id")%>">

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