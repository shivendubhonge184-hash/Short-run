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

"SELECT cc.category_name,cc.description,"+

"COUNT(DISTINCT cq.question_id) total_questions,"+

"COUNT(DISTINCT ca.attempt_id) attempts,"+

"IFNULL(MAX(ca.score),0) best_score "+

"FROM coding_categories cc "+

"LEFT JOIN coding_questions cq ON cc.category_id=cq.category_id "+

"LEFT JOIN coding_attempts ca ON cc.category_id=ca.category_id AND ca.user_id=? "+

"WHERE cc.category_id=? "+

"GROUP BY cc.category_id";

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

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Coding Instructions</title>

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

background:linear-gradient(135deg,#2563eb,#4f46e5);

padding:40px;

display:flex;

justify-content:space-between;

align-items:center;

color:white;

}

.back{

background:white;

padding:12px 25px;

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

.side{

background:white;

padding:30px;

border-radius:18px;

box-shadow:0 15px 35px rgba(0,0,0,.08);

height:fit-content;

}

.info{

display:grid;

grid-template-columns:repeat(2,1fr);

gap:20px;

margin:30px 0;

}

.box{

background:#f8fafc;

padding:22px;

border-radius:12px;

text-align:center;

}

.box i{

font-size:30px;

color:#2563eb;

margin-bottom:10px;

}

.box h3{

font-size:28px;

}

.box span{

color:#6b7280;

}

.rules{

margin-top:25px;

line-height:35px;

}

.start{

display:block;

width:100%;

padding:16px;

margin-top:35px;

background:#2563eb;

color:white;

text-decoration:none;

text-align:center;

border-radius:12px;

font-weight:600;

font-size:17px;

}

.stat{

background:#f8fafc;

padding:20px;

border-radius:12px;

margin-bottom:20px;

text-align:center;

}

.stat h1{

font-size:34px;

color:#2563eb;

}

</style>

</head>

<body>

<div class="header">

<div>

<h1><%=categoryName%></h1>

<p>Coding Practice Instructions</p>

</div>

<a href="coding.jsp" class="back">

<i class="fa-solid fa-arrow-left"></i>

Back

</a>

</div>

<div class="container">

<div class="card">

<h2><%=categoryName%></h2>

<p style="margin-top:15px;color:#6b7280;">

<%=description%>

</p>
<div class="info">

<div class="box">

<i class="fa-solid fa-code"></i>

<h3><%=totalQuestions%></h3>

<span>Total Coding Problems</span>

</div>

<div class="box">

<i class="fa-solid fa-layer-group"></i>

<h3>3</h3>

<span>Difficulty Levels</span>

</div>

<div class="box">

<i class="fa-solid fa-building"></i>

<h3>20+</h3>

<span>Top Companies</span>

</div>

<div class="box">

<i class="fa-solid fa-laptop-code"></i>

<h3>Java</h3>

<span>Programming Language</span>

</div>

</div>

<h2 style="margin-bottom:20px;">

Instructions

</h2>

<ul class="rules">

<li>Read the complete problem statement carefully before writing your solution.</li>

<li>Choose the appropriate algorithm before starting to code.</li>

<li>Practice Easy, Medium and Hard problems regularly.</li>

<li>Company-wise coding questions are available for interview preparation.</li>

<li>Write clean, readable and optimized code.</li>

<li>You can view the sample solution after submitting your code.</li>

<li>Your coding progress will be saved automatically.</li>

<li>Try to solve problems without looking at the solution first.</li>

</ul>

<a class="start"

href="codingQuestions.jsp?category_id=<%=categoryId%>">

<i class="fa-solid fa-play"></i>

Start Coding Practice

</a>

</div>

<div class="side">

<div class="stat">

<h1><%=totalQuestions%></h1>

<p>Available Problems</p>

</div>

<div class="stat">

<h1><%=attempts%></h1>

<p>Your Attempts</p>

</div>

<div class="stat">

<h1><%=bestScore%></h1>

<p>Best Score</p>

</div>

<div style="background:#eff6ff;padding:20px;border-radius:12px;text-align:center;color:#2563eb;font-weight:600;line-height:28px;">

<i class="fa-solid fa-lightbulb"></i>

<br><br>

Consistency is the key to cracking coding interviews.

Practice every day and improve your problem-solving skills.

</div>
</div>

</div>

</body>

</html>

<%

}catch(Exception e){

out.println("<div style='width:900px;margin:80px auto;background:white;padding:30px;border-radius:15px;'>");

out.println("<h2 style='color:red;'>Error</h2>");

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