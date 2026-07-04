<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){
    response.sendRedirect("studentLogin.jsp");
    return;
}

int userId=(Integer)session.getAttribute("user_id");
int categoryId=Integer.parseInt(request.getParameter("category_id"));

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

String categoryName="";
String description="";
int totalQuestions=0;
int attempts=0;
int bestScore=0;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

String sql=
"SELECT c.category_name,c.description,"+
"COUNT(DISTINCT q.question_id) total_questions,"+
"COUNT(DISTINCT qa.attempt_id) attempts,"+
"IFNULL(MAX(qa.score),0) best_score "+
"FROM categories c "+
"LEFT JOIN questions q ON c.category_id=q.category_id "+
"LEFT JOIN quiz_attempts qa ON c.category_id=qa.category_id AND qa.user_id=? "+
"WHERE c.category_id=? "+
"GROUP BY c.category_id";

ps=con.prepareStatement(sql);

ps.setInt(1,userId);
ps.setInt(2,categoryId);

rs=ps.executeQuery();

if(rs.next()){

categoryName=rs.getString("category_name");
description=rs.getString("description");
totalQuestions=rs.getInt("total_questions");
attempts=rs.getInt("attempts");
bestScore=rs.getInt("best_score");

}

}catch(Exception e){

out.println(e);

}
finally{

try{
if(rs!=null) rs.close();
}catch(Exception e){}

try{
if(ps!=null) ps.close();
}catch(Exception e){}

try{
if(con!=null) con.close();
}catch(Exception e){}

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Quiz Instructions</title>

<link rel="preconnect" href="https://fonts.googleapis.com">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

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

display:flex;

justify-content:space-between;

align-items:center;

}

.header h1{

font-size:32px;

}

.header p{

margin-top:8px;

opacity:.9;

}

.back{

background:white;

padding:12px 24px;

border-radius:10px;

text-decoration:none;

font-weight:600;

color:#2563eb;

}

.container{

width:1100px;

margin:40px auto;

display:grid;

grid-template-columns:2fr 1fr;

gap:30px;

}

.card{

background:white;

padding:35px;

border-radius:18px;

box-shadow:0 15px 35px rgba(0,0,0,.08);

}

.card h2{

margin-bottom:10px;

color:#111827;

}

.desc{

color:#6b7280;

margin-bottom:30px;

}

.info{

display:grid;

grid-template-columns:repeat(2,1fr);

gap:20px;

margin-bottom:35px;

}

.box{

background:#f8fafc;

padding:22px;

border-radius:12px;

text-align:center;

}

.box i{

font-size:28px;

color:#2563eb;

margin-bottom:12px;

}

.box h3{

font-size:28px;

color:#111827;

}

.box span{

display:block;

margin-top:5px;

color:#6b7280;

font-size:14px;

}

.rules{

margin-top:20px;

}

.rules li{

margin-bottom:16px;

color:#374151;

line-height:26px;

}

.start{

width:100%;

margin-top:35px;

padding:16px;

background:#2563eb;

border:none;

border-radius:12px;

color:white;

font-size:17px;

font-weight:600;

cursor:pointer;

transition:.3s;

}

.start:hover{

background:#1d4ed8;

}

.side{

background:white;

padding:30px;

border-radius:18px;

box-shadow:0 15px 35px rgba(0,0,0,.08);

height:fit-content;

}

.stat{

padding:18px;

background:#f8fafc;

border-radius:12px;

margin-bottom:18px;

text-align:center;

}

.stat h1{

font-size:34px;

color:#2563eb;

}

.stat p{

margin-top:6px;

color:#6b7280;

}

.badge{

margin-top:30px;

padding:18px;

background:#eff6ff;

border-radius:12px;

text-align:center;

color:#1d4ed8;

font-weight:600;

}

@media(max-width:900px){

.container{

width:95%;

grid-template-columns:1fr;

}

.header{

flex-direction:column;

gap:20px;

text-align:center;

}

.info{

grid-template-columns:1fr;

}

}

</style>

</head>

<body>

<div class="header">

<div>

<h1><%=categoryName%></h1>

<p>Assessment Instructions</p>

</div>

<a href="aptitude.jsp" class="back">

<i class="fa-solid fa-arrow-left"></i>

Back

</a>

</div>

<div class="container">

<div class="card">

<h2><%=categoryName%></h2>

<p class="desc">

<%=description%>

</p>

<div class="info">

<div class="box">

<i class="fa-solid fa-list-check"></i>

<h3>10</h3>

<span>Questions to Attempt</span>

</div>

<div class="box">

<i class="fa-solid fa-clock"></i>

<h3>15</h3>

<span>Minutes</span>

</div>

<div class="box">

<i class="fa-solid fa-award"></i>

<h3>60%</h3>

<span>Passing Score</span>

</div>

<div class="box">

<i class="fa-solid fa-ban"></i>

<h3>No</h3>

<span>Negative Marking</span>

</div>

</div>

<h2>Instructions</h2>

<ul class="rules">

<li>Read every question carefully before selecting an answer.</li>

<li>Only 10 random questions will appear in this assessment.</li>

<li>Each question carries one mark.</li>

<li>You can move between questions during the assessment.</li>

<li>Click Finish after answering all questions.</li>

<li>Your score will be saved automatically.</li>

<li>Results will be available immediately after submission.</li>

</ul>

<a class="start"

href="quiz.jsp?category_id=<%=categoryId%>">

<i class="fa-solid fa-play"></i>

Start Assessment

</a>

</div>

<div class="side">

<div class="stat">

<h1><%=totalQuestions%></h1>

<p>Questions Available</p>

</div>

<div class="stat">

<h1><%=attempts%></h1>

<p>Your Attempts</p>

</div>

<div class="stat">

<h1><%=bestScore%>/10</h1>

<p>Best Score</p>

</div>

<div class="badge">

<i class="fa-solid fa-trophy"></i>

Practice consistently to improve your placement readiness.

</div>

</div>

</div>

</body>

</html>