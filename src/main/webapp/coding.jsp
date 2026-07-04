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

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Coding Practice</title>

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

height:85px;

background:white;

display:flex;

justify-content:space-between;

align-items:center;

padding:0 45px;

box-shadow:0 5px 20px rgba(0,0,0,.08);

}

.logo{

font-size:28px;

font-weight:700;

color:#2563eb;

}

.back{

padding:12px 24px;

background:#2563eb;

color:white;

text-decoration:none;

border-radius:10px;

font-weight:600;

transition:.3s;

}

.back:hover{

background:#1d4ed8;

}

.title{

text-align:center;

margin-top:40px;

}

.title h1{

font-size:38px;

color:#111827;

}

.title p{

margin-top:10px;

color:#6b7280;

font-size:17px;

}

.container{

width:1200px;

margin:40px auto;

display:grid;

grid-template-columns:repeat(auto-fit,minmax(330px,1fr));

gap:30px;

}

.card{

background:white;

padding:35px;

border-radius:20px;

box-shadow:0 15px 35px rgba(0,0,0,.08);

transition:.3s;

}

.card:hover{

transform:translateY(-8px);

}

.icon{

width:75px;

height:75px;

border-radius:50%;

background:#eff6ff;

display:flex;

justify-content:center;

align-items:center;

margin:auto;

font-size:32px;

color:#2563eb;

margin-bottom:20px;

}

.card h2{

text-align:center;

margin-bottom:12px;

color:#111827;

}

.desc{

text-align:center;

color:#6b7280;

margin-bottom:25px;

line-height:25px;

}

.stats{

display:grid;

grid-template-columns:repeat(3,1fr);

gap:12px;

margin-bottom:25px;

}

.box{

background:#f8fafc;

padding:15px;

border-radius:12px;

text-align:center;

}

.box h3{

color:#2563eb;

font-size:24px;

}

.box span{

font-size:13px;

color:#6b7280;

}

.start{

display:block;

width:100%;

padding:15px;

background:#2563eb;

color:white;

text-align:center;

text-decoration:none;

border-radius:10px;

font-weight:600;

transition:.3s;

}

.start:hover{

background:#1d4ed8;

}

.footer{

text-align:center;

padding:45px;

color:#6b7280;

}

</style>

</head>

<body>

<div class="header">

<div class="logo">

<i class="fa-solid fa-code"></i>

Coding Practice

</div>

<a href="dashboard.jsp" class="back">

<i class="fa-solid fa-arrow-left"></i>

Dashboard

</a>

</div>

<div class="title">

<h1>Coding Practice Module</h1>

<p>

Practice coding interview questions from different topics and companies.

</p>

</div>

<div class="container">
<%

String sql=

"SELECT cc.category_id,cc.category_name,cc.description,cc.icon,"+

"COUNT(DISTINCT cq.question_id) total_questions,"+

"COUNT(DISTINCT cs.submission_id) submissions,"+

"IFNULL(MAX(ca.score),0) best_score "+

"FROM coding_categories cc "+

"LEFT JOIN coding_questions cq ON cc.category_id=cq.category_id "+

"LEFT JOIN coding_submissions cs ON cq.question_id=cs.question_id AND cs.user_id=? "+

"LEFT JOIN coding_attempts ca ON cc.category_id=ca.category_id AND ca.user_id=? "+

"GROUP BY cc.category_id "+

"ORDER BY cc.category_id";

ps=con.prepareStatement(sql);

ps.setInt(1,userId);

ps.setInt(2,userId);

rs=ps.executeQuery();

while(rs.next()){

%>

<div class="card">

<div class="icon">

<i class="fa-solid <%=rs.getString("icon")%>"></i>

</div>

<h2>

<%=rs.getString("category_name")%>

</h2>

<p class="desc">

<%=rs.getString("description")%>

</p>

<div class="stats">

<div class="box">

<h3>

<%=rs.getInt("total_questions")%>

</h3>

<span>

Questions

</span>

</div>

<div class="box">

<h3>

<%=rs.getInt("submissions")%>

</h3>

<span>

Submissions

</span>

</div>

<div class="box">

<h3>

<%=rs.getInt("best_score")%>

</h3>

<span>

Best Score

</span>

</div>

</div>

<a

class="start"

href="codingInstructions.jsp?category_id=<%=rs.getInt("category_id")%>">

<i class="fa-solid fa-play"></i>

Start Practice

</a>

</div>

<%

}

%>
</div>

<div class="footer">

<h2 style="color:#111827;margin-bottom:10px;">

Placement Preparation Portal

</h2>

<p>

Sharpen your coding skills with company-wise interview questions and track your progress.

</p>

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