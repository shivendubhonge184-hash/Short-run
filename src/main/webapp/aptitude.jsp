<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){
    response.sendRedirect("studentLogin.jsp");
    return;
}

int userId=(Integer)session.getAttribute("user_id");
%>

<!DOCTYPE html>
<html>

<head>

<title>Aptitude Practice</title>

<meta charset="UTF-8">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{
background:#f4f7fc;
}

.header{

background:#2563eb;
padding:22px;
color:white;
text-align:center;
font-size:30px;
font-weight:bold;

}

.sub{

text-align:center;
color:#6b7280;
margin:20px 0 40px;
font-size:17px;

}

.container{

max-width:1200px;
margin:auto;
display:grid;
grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
gap:30px;
padding:20px;

}

.card{

background:white;
border-radius:18px;
padding:30px;
box-shadow:0 10px 30px rgba(0,0,0,.08);
transition:.3s;

}

.card:hover{

transform:translateY(-6px);

}

.icon{

width:70px;
height:70px;
background:#2563eb;
color:white;
font-size:28px;
border-radius:50%;
display:flex;
justify-content:center;
align-items:center;
margin:auto;
margin-bottom:20px;

}

h2{

text-align:center;
margin-bottom:25px;
color:#111827;

}

.stats{

display:grid;
grid-template-columns:repeat(2,1fr);
gap:15px;
margin-bottom:25px;

}

.box{

background:#f8fafc;
padding:18px;
border-radius:12px;
text-align:center;

}

.box h3{

color:#2563eb;
font-size:24px;

}

.box p{

font-size:13px;
color:#6b7280;
margin-top:6px;

}

.btn{

display:block;
text-align:center;
background:#2563eb;
color:white;
padding:14px;
text-decoration:none;
border-radius:10px;
font-weight:600;

}

.btn:hover{

background:#1d4ed8;

}

.footer{

margin:50px 0;
text-align:center;
color:#6b7280;

}

</style>

</head>

<body>

<div class="header">

Placement Preparation Portal

</div>

<div class="sub">

Choose any aptitude category and solve 10 random questions.

</div>

<div class="container">

<%

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

ps=con.prepareStatement(

"SELECT * FROM categories ORDER BY category_name"

);

rs=ps.executeQuery();

while(rs.next()){

int categoryId=rs.getInt("category_id");

String categoryName=rs.getString("category_name");

/* Total Questions */

PreparedStatement ps1=

con.prepareStatement(

"SELECT COUNT(*) FROM questions WHERE category_id=?"

);

ps1.setInt(1,categoryId);

ResultSet r1=ps1.executeQuery();

r1.next();

int totalQuestions=r1.getInt(1);

r1.close();

ps1.close();

/* Attempts */

PreparedStatement ps2=

con.prepareStatement(

"SELECT COUNT(*) FROM quiz_attempts WHERE category_id=? AND user_id=?"

);

ps2.setInt(1,categoryId);

ps2.setInt(2,userId);

ResultSet r2=ps2.executeQuery();

r2.next();

int attempts=r2.getInt(1);

r2.close();

ps2.close();

/* Best Score */

PreparedStatement ps3=

con.prepareStatement(

"SELECT IFNULL(MAX(score),0) FROM quiz_attempts WHERE category_id=? AND user_id=?"

);

ps3.setInt(1,categoryId);

ps3.setInt(2,userId);

ResultSet r3=ps3.executeQuery();

r3.next();

int bestScore=r3.getInt(1);

r3.close();

ps3.close();

%>

<div class="card">

<div class="icon">

📝

</div>

<h2>

<%=categoryName%>

</h2>

<div class="stats">

<div class="box">

<h3>

<%=totalQuestions%>

</h3>

<p>

Questions

</p>

</div>

<div class="box">

<h3>

10

</h3>

<p>

Quiz Size

</p>

</div>

<div class="box">

<h3>

<%=attempts%>

</h3>

<p>

Attempts

</p>

</div>

<div class="box">

<h3>

<%=bestScore%>

</h3>

<p>

Best Score

</p>

</div>

</div>

<a
class="btn"
href="instructions.jsp?category_id=<%=categoryId%>">

Start Practice

</a>

</div>

<%

}

}catch(Exception e){

%>

<h2 style="color:red;text-align:center;">

<%=e.getMessage()%>

</h2>

<%

}

finally{

try{
if(rs!=null)rs.close();
}catch(Exception e){}

try{
if(ps!=null)ps.close();
}catch(Exception e){}

try{
if(con!=null)con.close();
}catch(Exception e){}

}

%>

</div>

<div class="footer">

<h3>

Placement Preparation Portal

</h3>

<p>

Practice consistently to improve your aptitude skills and placement readiness.

</p>

</div>

</body>

</html>