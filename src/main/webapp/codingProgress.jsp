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

int totalQuestions=0;
int solvedQuestions=0;
int totalScore=0;
int easySolved=0;
int mediumSolved=0;
int hardSolved=0;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

ps=con.prepareStatement(

"SELECT COUNT(*) total FROM coding_questions"

);

rs=ps.executeQuery();

if(rs.next()){

totalQuestions=rs.getInt("total");

}

rs.close();
ps.close();

ps=con.prepareStatement(

"SELECT COUNT(DISTINCT question_id) solved FROM coding_submissions WHERE user_id=?"

);

ps.setInt(1,userId);

rs=ps.executeQuery();

if(rs.next()){

solvedQuestions=rs.getInt("solved");

}

rs.close();
ps.close();

totalScore=solvedQuestions*10;

ps=con.prepareStatement(

"SELECT q.difficulty,COUNT(DISTINCT s.question_id) total FROM coding_submissions s JOIN coding_questions q ON s.question_id=q.question_id WHERE s.user_id=? GROUP BY q.difficulty"

);

ps.setInt(1,userId);

rs=ps.executeQuery();

while(rs.next()){

String d=rs.getString("difficulty");

int c=rs.getInt("total");

if(d.equals("Easy"))

easySolved=c;

else if(d.equals("Medium"))

mediumSolved=c;

else

hardSolved=c;

}

int progress=0;

if(totalQuestions>0)

progress=(solvedQuestions*100)/totalQuestions;

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Coding Progress</title>

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

.header{

background:#2563eb;

padding:30px;

color:white;

text-align:center;

}

.container{

width:1200px;

margin:40px auto;

}

.cards{

display:grid;

grid-template-columns:repeat(4,1fr);

gap:25px;

margin-bottom:35px;

}

.card{

background:white;

padding:30px;

border-radius:18px;

text-align:center;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}

.card i{

font-size:40px;

color:#2563eb;

margin-bottom:15px;

}

.card h2{

font-size:34px;

color:#111827;

}

.card p{

margin-top:8px;

color:#6b7280;

}

.progress-box{

background:white;

padding:30px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

margin-bottom:35px;

}

.progress{

height:20px;

background:#e5e7eb;

border-radius:20px;

overflow:hidden;

margin-top:20px;

}

.bar{

height:100%;

width:<%=progress%>%;

background:#16a34a;

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

margin-top:20px;

}

th,td{

padding:15px;

text-align:left;

border-bottom:1px solid #e5e7eb;

}

th{

background:#2563eb;

color:white;

}

.easy{

color:#16a34a;

font-weight:600;

}

.medium{

color:#f59e0b;

font-weight:600;

}

.hard{

color:#dc2626;

font-weight:600;

}

.btn{

display:inline-block;

margin-top:30px;

padding:15px 30px;

background:#2563eb;

color:white;

text-decoration:none;

border-radius:10px;

font-weight:600;

}

</style>

</head>

<body>

<div class="header">

<h1>

Coding Progress Dashboard

</h1>

<p>

Track your coding practice and interview preparation

</p>

</div>

<div class="container">

<div class="cards">

<div class="card">

<i class="fa-solid fa-code"></i>

<h2><%=totalQuestions%></h2>

<p>Total Problems</p>

</div>

<div class="card">

<i class="fa-solid fa-circle-check"></i>

<h2><%=solvedQuestions%></h2>

<p>Solved Problems</p>

</div>

<div class="card">

<i class="fa-solid fa-star"></i>

<h2><%=totalScore%></h2>

<p>Total Score</p>

</div>

<div class="card">

<i class="fa-solid fa-chart-line"></i>

<h2><%=progress%>%</h2>

<p>Overall Progress</p>

</div>

</div>

<div class="progress-box">

<h2>

Overall Progress

</h2>

<div class="progress">

<div class="bar"></div>

</div>

<p style="margin-top:15px;">

You have solved

<b><%=solvedQuestions%></b>

out of

<b><%=totalQuestions%></b>

coding problems.

</p>

</div>

<div class="cards">

<div class="card">

<h2 class="easy">

<%=easySolved%>

</h2>

<p>Easy Solved</p>

</div>

<div class="card">

<h2 class="medium">

<%=mediumSolved%>

</h2>

<p>Medium Solved</p>

</div>

<div class="card">

<h2 class="hard">

<%=hardSolved%>

</h2>

<p>Hard Solved</p>

</div>

<div class="card">

<h2>

<%=totalQuestions-solvedQuestions%>

</h2>

<p>Remaining</p>

</div>

</div>

<div class="table-box">

<h2>

Recent Coding Submissions

</h2>

<table>

<tr>

<th>Problem</th>

<th>Language</th>

<th>Difficulty</th>

<th>Status</th>

<th>Date</th>

</tr>

<%

rs.close();

ps.close();

ps=con.prepareStatement(

"SELECT q.title,q.difficulty,s.language,s.status,s.submitted_at FROM coding_submissions s JOIN coding_questions q ON s.question_id=q.question_id WHERE s.user_id=? ORDER BY s.submitted_at DESC LIMIT 10"

);

ps.setInt(1,userId);

rs=ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%=rs.getString("title")%></td>

<td><%=rs.getString("language")%></td>

<td class="<%=rs.getString("difficulty").toLowerCase()%>">

<%=rs.getString("difficulty")%>

</td>

<td><%=rs.getString("status")%></td>

<td><%=rs.getString("submitted_at")%></td>

</tr>

<%

}

%>

</table>

<a href="coding.jsp" class="btn">

<i class="fa-solid fa-code"></i>

Practice More Problems

</a>

</div>
</div>

</body>

</html>

<%

}catch(Exception e){

out.println("<div style='width:900px;margin:80px auto;background:white;padding:30px;border-radius:15px;'>");

out.println("<h2 style='color:red;'>Error Loading Progress</h2>");

out.println("<p>"+e.getMessage()+"</p>");

out.println("</div>");

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