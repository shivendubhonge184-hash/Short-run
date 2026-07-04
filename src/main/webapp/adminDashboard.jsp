<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("admin")==null){

response.sendRedirect("adminLogin.jsp");

return;

}

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

int students=0;
int aptitudeQuestions=0;
int codingQuestions=0;
int studyMaterials=0;
int communityPosts=0;
int quizAttempts=0;
int codingSubmissions=0;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

//Students

ps=con.prepareStatement(

"SELECT COUNT(*) FROM users"

);

rs=ps.executeQuery();

if(rs.next())

students=rs.getInt(1);

rs.close();

ps.close();

//Aptitude Questions

ps=con.prepareStatement(

"SELECT COUNT(*) FROM questions"

);

rs=ps.executeQuery();

if(rs.next())

aptitudeQuestions=rs.getInt(1);

rs.close();

ps.close();

//Coding Questions

ps=con.prepareStatement(

"SELECT COUNT(*) FROM coding_questions"

);

rs=ps.executeQuery();

if(rs.next())

codingQuestions=rs.getInt(1);

rs.close();

ps.close();

//Study Materials

ps=con.prepareStatement(

"SELECT COUNT(*) FROM study_materials"

);

rs=ps.executeQuery();

if(rs.next())

studyMaterials=rs.getInt(1);

rs.close();

ps.close();

//Community Posts

ps=con.prepareStatement(

"SELECT COUNT(*) FROM discussion_posts"

);

rs=ps.executeQuery();

if(rs.next())

communityPosts=rs.getInt(1);

rs.close();

ps.close();

//Quiz Attempts

ps=con.prepareStatement(

"SELECT COUNT(*) FROM quiz_attempts"

);

rs=ps.executeQuery();

if(rs.next())

quizAttempts=rs.getInt(1);

rs.close();

ps.close();

//Coding Submissions

ps=con.prepareStatement(

"SELECT COUNT(*) FROM coding_submissions"

);

rs=ps.executeQuery();

if(rs.next())

codingSubmissions=rs.getInt(1);

rs.close();

ps.close();

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Admin Dashboard</title>

<link rel="preconnect" href="https://fonts.googleapis.com">

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

display:flex;

}

.sidebar{

width:260px;

height:100vh;

background:#111827;

position:fixed;

left:0;

top:0;

padding:25px 0;

overflow:auto;

}

.sidebar h2{

color:white;

text-align:center;

margin-bottom:35px;

}

.sidebar a{

display:block;

padding:15px 30px;

color:white;

text-decoration:none;

transition:.3s;

}

.sidebar a:hover{

background:#2563eb;

}

.main{

margin-left:260px;

width:calc(100% - 260px);

padding:35px;

}

.header{

background:linear-gradient(135deg,#2563eb,#4f46e5);

padding:35px;

border-radius:18px;

color:white;

margin-bottom:30px;

}

.header h1{

font-size:34px;

margin-bottom:10px;

}

.cards{

display:grid;

grid-template-columns:repeat(auto-fit,minmax(220px,1fr));

gap:20px;

}
.card{

background:white;

padding:28px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

transition:.3s;

text-align:center;

}

.card:hover{

transform:translateY(-6px);

}

.card i{

font-size:42px;

color:#2563eb;

margin-bottom:18px;

}

.card h2{

font-size:34px;

color:#111827;

margin-bottom:8px;

}

.card p{

color:#6b7280;

font-size:15px;

}

.quick-actions{

margin-top:40px;

display:grid;

grid-template-columns:repeat(auto-fit,minmax(250px,1fr));

gap:25px;

}

.action{

background:white;

padding:30px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

text-align:center;

transition:.3s;

}

.action:hover{

transform:translateY(-6px);

}

.action i{

font-size:48px;

color:#2563eb;

margin-bottom:18px;

}

.action h3{

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

@media(max-width:900px){

.sidebar{

width:220px;

}

.main{

margin-left:220px;

width:calc(100% - 220px);

}

}

@media(max-width:700px){

.sidebar{

display:none;

}

.main{

margin-left:0;

width:100%;

padding:20px;

}

.cards{

grid-template-columns:1fr;

}

.quick-actions{

grid-template-columns:1fr;

}

}

</style>

</head>

<body>

<div class="sidebar">

<h2>

<i class="fa-solid fa-user-shield"></i>

Admin Panel

</h2>

<a href="adminDashboard.jsp">

<i class="fa-solid fa-house"></i>

Dashboard

</a>

<a href="manageStudents.jsp">

<i class="fa-solid fa-users"></i>

Students

</a>

<a href="manageQuestions.jsp">

<i class="fa-solid fa-book"></i>

Aptitude

</a>

<a href="manageCodingQuestions.jsp">

<i class="fa-solid fa-code"></i>

Coding

</a>

<a href="manageMaterials.jsp">

<i class="fa-solid fa-book-open"></i>

Study Material

</a>

<a href="managePosts.jsp">

<i class="fa-solid fa-comments"></i>

Community

</a>

<a href="reports.jsp">

<i class="fa-solid fa-chart-column"></i>

Reports

</a>

<a href="adminLogout.jsp">

<i class="fa-solid fa-right-from-bracket"></i>

Logout

</a>

</div>

<div class="main">

<div class="header">

<h1>

Welcome Admin 

</h1>

<p>

Manage Students, Aptitude, Coding, Study Materials and Community from one place.

</p>

</div>

<div class="cards">

<div class="card">

<i class="fa-solid fa-users"></i>

<h2><%=students%></h2>

<p>Total Students</p>

</div>

<div class="card">

<i class="fa-solid fa-book"></i>

<h2><%=aptitudeQuestions%></h2>

<p>Aptitude Questions</p>

</div>

<div class="card">

<i class="fa-solid fa-code"></i>

<h2><%=codingQuestions%></h2>

<p>Coding Questions</p>

</div>

<div class="card">

<i class="fa-solid fa-book-open"></i>

<h2><%=studyMaterials%></h2>

<p>Study Materials</p>

</div>

<div class="card">

<i class="fa-solid fa-comments"></i>

<h2><%=communityPosts%></h2>

<p>Community Posts</p>

</div>

<div class="card">

<i class="fa-solid fa-clipboard-list"></i>

<h2><%=quizAttempts%></h2>

<p>Quiz Attempts</p>

</div>

<div class="card">

<i class="fa-solid fa-laptop-code"></i>

<h2><%=codingSubmissions%></h2>

<p>Coding Submissions</p>

</div>

</div>

<div class="quick-actions">
<div class="action">

<i class="fa-solid fa-users"></i>

<h3>

Student Management

</h3>

<p>

View registered students, check their profiles, monitor activity and remove inactive users.

</p>

<a

href="manageStudents.jsp"

class="btn">

Manage Students

</a>

</div>

<div class="action">

<i class="fa-solid fa-book"></i>

<h3>

Aptitude Module

</h3>

<p>

Add, edit and delete aptitude questions. Organize questions by category and difficulty level.

</p>

<a

href="manageQuestions.jsp"

class="btn">

Manage Aptitude

</a>

</div>

<div class="action">

<i class="fa-solid fa-code"></i>

<h3>

Coding Module

</h3>

<p>

Manage coding problems, difficulty levels, company-wise questions and coding challenges.

</p>

<a

href="manageCodingQuestions.jsp"

class="btn">

Manage Coding

</a>

</div>

<div class="action">

<i class="fa-solid fa-book-open-reader"></i>

<h3>

Study Material

</h3>

<p>

Upload notes, previous year questions, interview experiences and video resources.

</p>

<a

href="manageMaterials.jsp"

class="btn">

Manage Materials

</a>

</div>

<div class="action">

<i class="fa-solid fa-comments"></i>

<h3>

Community Module

</h3>

<p>

View discussions, moderate posts and comments, and maintain a healthy student community.

</p>

<a

href="managePosts.jsp"

class="btn">

Manage Community

</a>

</div>

<div class="action">

<i class="fa-solid fa-chart-line"></i>

<h3>

Reports & Analytics

</h3>

<p>

View portal statistics, student activity, quiz attempts, coding performance and downloads.

</p>

<a

href="reports.jsp"

class="btn">

View Reports

</a>

</div>

</div>

<div style="margin-top:40px;
background:white;
padding:30px;
border-radius:18px;
box-shadow:0 10px 30px rgba(0,0,0,.08);">

<h2 style="margin-bottom:25px;">

<i class="fa-solid fa-bolt"></i>

Quick Overview

</h2>

<p style="color:#6b7280;line-height:30px;font-size:16px;">

Welcome to the Placement Preparation Portal Administration Panel. From here you can manage students, aptitude questions, coding challenges, study materials, community discussions and monitor the complete portal through one centralized dashboard.

</p>

</div>
<div style="margin-top:40px;
background:white;
padding:30px;
border-radius:18px;
box-shadow:0 10px 30px rgba(0,0,0,.08);">

<h2 style="margin-bottom:25px;">

<i class="fa-solid fa-clock-rotate-left"></i>

Recent Activity

</h2>

<table style="width:100%;border-collapse:collapse;">

<tr style="background:#2563eb;color:white;">

<th style="padding:15px;">Activity</th>

<th>Details</th>

</tr>

<%

//Latest Student

ps=con.prepareStatement(

"SELECT username FROM users ORDER BY user_id DESC LIMIT 1"

);

rs=ps.executeQuery();

if(rs.next()){

%>

<tr>

<td style="padding:15px;border-bottom:1px solid #eee;">

Latest Registered Student

</td>

<td style="border-bottom:1px solid #eee;">

<%=rs.getString("username")%>

</td>

</tr>

<%

}

rs.close();

ps.close();

//Latest Study Material

ps=con.prepareStatement(

"SELECT title FROM study_materials ORDER BY material_id DESC LIMIT 1"

);

rs=ps.executeQuery();

if(rs.next()){

%>

<tr>

<td style="padding:15px;border-bottom:1px solid #eee;">

Latest Study Material

</td>

<td style="border-bottom:1px solid #eee;">

<%=rs.getString("title")%>

</td>

</tr>

<%

}

rs.close();

ps.close();

//Latest Community Post

ps=con.prepareStatement(

"SELECT title FROM discussion_posts ORDER BY post_id DESC LIMIT 1"

);

rs=ps.executeQuery();

if(rs.next()){

%>

<tr>

<td style="padding:15px;border-bottom:1px solid #eee;">

Latest Community Post

</td>

<td style="border-bottom:1px solid #eee;">

<%=rs.getString("title")%>

</td>

</tr>

<%

}

rs.close();

ps.close();

//Latest Coding Question

ps=con.prepareStatement(

"SELECT title FROM coding_questions ORDER BY question_id DESC LIMIT 1"

);

rs=ps.executeQuery();

if(rs.next()){

%>

<tr>

<td style="padding:15px;border-bottom:1px solid #eee;">

Latest Coding Question

</td>

<td style="border-bottom:1px solid #eee;">

<%=rs.getString("title")%>

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