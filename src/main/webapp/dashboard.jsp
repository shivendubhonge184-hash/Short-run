<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){
response.sendRedirect("studentLogin.jsp");
return;
}

int userId=(Integer)session.getAttribute("user_id");
String username=(String)session.getAttribute("username");

int totalTests=0;
double avgScore=0;

int codingSolved=0;
int codingProblems=0;

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

// Aptitude Statistics

ps=con.prepareStatement(
"SELECT COUNT(*),IFNULL(AVG(score),0) FROM quiz_attempts WHERE user_id=?");

ps.setInt(1,userId);

rs=ps.executeQuery();

if(rs.next()){

totalTests=rs.getInt(1);

avgScore=rs.getDouble(2);

}

rs.close();
ps.close();

// Coding Solved

ps=con.prepareStatement(
"SELECT COUNT(DISTINCT question_id) FROM coding_submissions WHERE user_id=?");

ps.setInt(1,userId);

rs=ps.executeQuery();

if(rs.next()){

codingSolved=rs.getInt(1);

}

rs.close();
ps.close();

// Total Coding Questions

ps=con.prepareStatement(
"SELECT COUNT(*) FROM coding_questions");

rs=ps.executeQuery();

if(rs.next()){

codingProblems=rs.getInt(1);

}

}catch(Exception e){

out.println(e);

}
%>

<!DOCTYPE html>

<html>

<head>

<title>Dashboard</title>

<meta charset="UTF-8">

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
}

.sidebar{

position:fixed;

left:0;

top:0;

width:260px;

height:100%;

background:#111827;

padding-top:30px;

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

font-size:15px;

}

.sidebar a:hover{

background:#2563eb;

}

.main{

margin-left:260px;

padding:35px;

}

.header{

background:linear-gradient(135deg,#2563eb,#4f46e5);

padding:40px;

border-radius:20px;

color:white;

}

.header h1{

font-size:36px;

margin-bottom:10px;

}

.cards{

margin-top:35px;

display:grid;

grid-template-columns:repeat(auto-fit,minmax(240px,1fr));

gap:25px;

}

.card{

background:white;

padding:30px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

transition:.3s;

}

.card:hover{

transform:translateY(-5px);

}

.card i{

font-size:38px;

color:#2563eb;

margin-bottom:15px;

}

.card h1{

margin-top:10px;

color:#2563eb;

font-size:32px;

}

.card p{

color:#6b7280;

}
</style>

</head>

<body>

<div class="sidebar">

<h2>Placement Portal</h2>

<a href="dashboard.jsp">
<i class="fa-solid fa-house"></i>
&nbsp; Dashboard
</a>

<a href="profile.jsp">
<i class="fa-solid fa-user"></i>
&nbsp; Profile
</a>

<a href="aptitude.jsp">
<i class="fa-solid fa-book-open"></i>
&nbsp; Aptitude Practice
</a>

<a href="coding.jsp">
<i class="fa-solid fa-code"></i>
&nbsp; Coding Practice
</a>

<a href="studyMaterial.jsp">
<i class="fa-solid fa-file-pdf"></i>
&nbsp; Study Material
</a>

<a href="community.jsp">
<i class="fa-solid fa-users"></i>
&nbsp; Community
</a>

<a href="progress.jsp">
<i class="fa-solid fa-chart-column"></i>
&nbsp; Aptitude Progress
</a>

<a href="codingProgress.jsp">
<i class="fa-solid fa-laptop-code"></i>
&nbsp; Coding Progress
</a>

<a href="logout.jsp">
<i class="fa-solid fa-right-from-bracket"></i>
&nbsp; Logout
</a>

</div>

<div class="main">

<div class="header">

<h1>

Welcome, <%=username%> 

</h1>

<p>

Prepare • Practice • Learn • Crack Your Dream Placement

</p>

</div>

<div class="cards">

<div class="card">

<i class="fa-solid fa-clipboard-check"></i>

<h3>Total Aptitude Tests</h3>

<h1>

<%=totalTests%>

</h1>

<p>

Quiz attempts completed

</p>

</div>

<div class="card">

<i class="fa-solid fa-chart-line"></i>

<h3>Average Score</h3>

<h1>

<%=String.format("%.2f",avgScore)%>

</h1>

<p>

Across all aptitude tests

</p>

</div>

<div class="card">

<i class="fa-solid fa-code"></i>

<h3>Coding Solved</h3>

<h1>

<%=codingSolved%>/<%=codingProblems%>

</h1>

<p>

Programming questions solved

</p>

</div>

<div class="card">

<i class="fa-solid fa-trophy"></i>

<h3>Placement Readiness</h3>

<h1>

<%=Math.min(100,(totalTests*5)+(codingSolved*2))%>%

</h1>

<p>

Based on your overall activity

</p>

</div>

</div>

<style>

.actions{

margin-top:40px;

display:grid;

grid-template-columns:repeat(auto-fit,minmax(250px,1fr));

gap:25px;

}

.action{

background:white;

padding:30px;

border-radius:18px;

text-align:center;

box-shadow:0 10px 30px rgba(0,0,0,.08);

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

.action h2{

margin-bottom:12px;

}

.action p{

color:#6b7280;

line-height:26px;

margin-bottom:20px;

}

.action a{

display:inline-block;

padding:12px 24px;

background:#2563eb;

color:white;

text-decoration:none;

border-radius:10px;

font-weight:600;

}

.action a:hover{

background:#1d4ed8;

}

</style>

<div class="actions">
<div class="action">

<i class="fa-solid fa-book-open"></i>

<h2>Aptitude Practice</h2>

<p>

Practice Quantitative Aptitude, Logical Reasoning, Verbal Ability and more.

</p>

<a href="aptitude.jsp">

Start Practice

</a>

</div>

<div class="action">

<i class="fa-solid fa-code"></i>

<h2>Coding Practice</h2>

<p>

Solve company coding questions with different difficulty levels.

</p>

<a href="coding.jsp">

Start Coding

</a>

</div>

<div class="action">

<i class="fa-solid fa-file-pdf"></i>

<h2>Study Material</h2>

<p>

Access Notes, PDFs, Interview Resources and Video Tutorials.

</p>

<a href="studyMaterial.jsp">

Open Library

</a>

</div>

<div class="action">

<i class="fa-solid fa-users"></i>

<h2>Community Discussion</h2>

<p>

Ask doubts, share interview experiences and help other students.

</p>

<a href="community.jsp">

Open Forum

</a>

</div>

<div class="action">

<i class="fa-solid fa-chart-column"></i>

<h2>Aptitude Progress</h2>

<p>

View your quiz attempts, scores and improvement statistics.

</p>

<a href="progress.jsp">

View Progress

</a>

</div>

<div class="action">

<i class="fa-solid fa-laptop-code"></i>

<h2>Coding Progress</h2>

<p>

Track solved coding problems and monitor your coding journey.

</p>

<a href="codingProgress.jsp">

View Progress

</a>

</div>

</div>

<style>

.table-box{

margin-top:40px;

background:white;

padding:30px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}

.table-box h2{

margin-bottom:20px;

color:#111827;

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

tr:hover{

background:#f8fafc;

}

</style>

<div class="table-box">

<h2>

Recent Aptitude Quiz Attempts

</h2>

<table>

<tr>

<th>Date</th>

<th>Category</th>

<th>Score</th>

<th>Percentage</th>

</tr>

<%

try{

ps=con.prepareStatement(

"SELECT c.category_name,q.score,q.percentage,q.attempt_date FROM quiz_attempts q JOIN categories c ON q.category_id=c.category_id WHERE q.user_id=? ORDER BY q.attempt_date DESC LIMIT 5"

);

ps.setInt(1,userId);

rs=ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%=rs.getString("attempt_date")%></td>

<td><%=rs.getString("category_name")%></td>

<td><%=rs.getInt("score")%></td>

<td><%=String.format("%.2f",rs.getDouble("percentage"))%>%</td>

</tr>

<%

}

rs.close();

ps.close();

}catch(Exception e){

out.println(e);

}

%>

</table>

</div>
<div class="table-box">

<h2>

Recent Coding Submissions

</h2>

<table>

<tr>

<th>Date</th>

<th>Problem</th>

<th>Difficulty</th>

<th>Language</th>

<th>Status</th>

</tr>

<%

try{

ps=con.prepareStatement(

"SELECT cq.title,cq.difficulty,cs.language,cs.status,cs.submitted_at FROM coding_submissions cs JOIN coding_questions cq ON cs.question_id=cq.question_id WHERE cs.user_id=? ORDER BY cs.submitted_at DESC LIMIT 5"

);

ps.setInt(1,userId);

rs=ps.executeQuery();

while(rs.next()){

String difficulty=rs.getString("difficulty");

String color="#16a34a";

if(difficulty.equalsIgnoreCase("Medium")){

color="#f59e0b";

}

if(difficulty.equalsIgnoreCase("Hard")){

color="#dc2626";

}

%>

<tr>

<td>

<%=rs.getString("submitted_at")%>

</td>

<td>

<%=rs.getString("title")%>

</td>

<td>

<span style="color:<%=color%>;font-weight:bold;">

<%=difficulty%>

</span>

</td>

<td>

<%=rs.getString("language")%>

</td>

<td>

<%

String status=rs.getString("status");

if(status.equalsIgnoreCase("Accepted")){

%>

<span style="color:#16a34a;font-weight:bold;">

✔ Accepted

</span>

<%

}else{

%>

<span style="color:#dc2626;font-weight:bold;">

✖ <%=status%>

</span>

<%

}

%>

</td>

</tr>

<%

}

rs.close();

ps.close();

}catch(Exception e){

out.println("<tr><td colspan='5'>"+e.getMessage()+"</td></tr>");

}

%>

</table>

</div>

<div style="height:40px;"></div>
</div>

<%
try{
if(rs!=null) rs.close();
}catch(Exception e){}

try{
if(ps!=null) ps.close();
}catch(Exception e){}

try{
if(con!=null) con.close();
}catch(Exception e){}
%>

</body>
</html>

