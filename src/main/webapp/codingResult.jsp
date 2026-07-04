<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){

response.sendRedirect("studentLogin.jsp");

return;

}

String status=(String)session.getAttribute("coding_status");

String language=(String)session.getAttribute("coding_language");

Integer questionId=(Integer)session.getAttribute("coding_question");

Integer score=(Integer)session.getAttribute("coding_score");

if(status==null){

response.sendRedirect("coding.jsp");

return;

}

Connection con=null;

PreparedStatement ps=null;

ResultSet rs=null;

String title="";

String company="";

String difficulty="";

String sampleSolution="";

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

ps=con.prepareStatement(

		"SELECT category_id,title,company_name,difficulty,sample_solution FROM coding_questions WHERE question_id=?"

);

ps.setInt(1,questionId);

rs=ps.executeQuery();

if(rs.next()){

title=rs.getString("title");

company=rs.getString("company_name");

difficulty=rs.getString("difficulty");

sampleSolution=rs.getString("sample_solution");

}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Coding Result</title>

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

.container{

width:900px;

margin:50px auto;

background:white;

padding:40px;

border-radius:20px;

box-shadow:0 15px 35px rgba(0,0,0,.08);

text-align:center;

}

.success{

width:100px;

height:100px;

background:#22c55e;

border-radius:50%;

margin:auto;

display:flex;

justify-content:center;

align-items:center;

font-size:50px;

color:white;

margin-bottom:25px;

}

h1{

color:#16a34a;

margin-bottom:10px;

}

.subtitle{

color:#6b7280;

margin-bottom:40px;

}

.stats{

display:grid;

grid-template-columns:repeat(2,1fr);

gap:20px;

margin-bottom:35px;

}

.box{

background:#f8fafc;

padding:25px;

border-radius:15px;

}

.box h2{

color:#2563eb;

margin-bottom:8px;

}

.box span{

color:#6b7280;

}

.solution{

margin-top:30px;

text-align:left;

background:#f8fafc;

padding:20px;

border-radius:12px;

display:none;

}

pre{

white-space:pre-wrap;

font-family:Consolas;

}

.btn{

display:inline-block;

padding:15px 28px;

margin:10px;

border-radius:10px;

text-decoration:none;

color:white;

font-weight:600;

}

.green{

background:#16a34a;

}

.blue{

background:#2563eb;

}

.orange{

background:#f59e0b;

}

.gray{

background:#64748b;

}

</style>

</head>

<body>

<div class="container">

<div class="success">

<i class="fa-solid fa-check"></i>

</div>

<h1>Submission Successful</h1>

<p class="subtitle">

Your code has been submitted successfully.

</p>

<div class="stats">
<div class="box">

<h2><%=title%></h2>

<span>Problem</span>

</div>

<div class="box">

<h2><%=company%></h2>

<span>Company</span>

</div>

<div class="box">

<h2><%=difficulty%></h2>

<span>Difficulty</span>

</div>

<div class="box">

<h2><%=language%></h2>

<span>Language Used</span>

</div>

<div class="box">

<h2><%=status%></h2>

<span>Submission Status</span>

</div>

<div class="box">

<h2><%=score%></h2>

<span>Score</span>

</div>

</div>

<a href="#"

class="btn green"

onclick="toggleSolution();return false;">

<i class="fa-solid fa-lightbulb"></i>

View Sample Solution

</a>

<a

href="codingQuestions.jsp?category_id=<%=rs.getInt("category_id")%>"

class="btn blue">

<i class="fa-solid fa-code"></i>

Solve Another Problem

</a>

<a

href="codingProgress.jsp"

class="btn orange">

<i class="fa-solid fa-chart-line"></i>

View Progress

</a>

<a

href="dashboard.jsp"

class="btn gray">

<i class="fa-solid fa-house"></i>

Dashboard

</a>

<div

id="solution"

class="solution">

<h2 style="margin-bottom:15px;">

Sample Solution

</h2>

<pre>

<%=sampleSolution%>

</pre>

</div>

</div>

<script>

function toggleSolution(){

var box=document.getElementById("solution");

if(box.style.display=="block"){

box.style.display="none";

}else{

box.style.display="block";

}

}

</script>
</body>

</html>

<%

// Clear result session variables

session.removeAttribute("coding_status");
session.removeAttribute("coding_language");
session.removeAttribute("coding_question");
session.removeAttribute("coding_score");

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