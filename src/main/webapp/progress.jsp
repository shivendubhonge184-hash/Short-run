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

int totalAttempts=0;
double avgPercentage=0;
int bestScore=0;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

ps=con.prepareStatement(

"SELECT COUNT(*) totalAttempts, IFNULL(AVG(percentage),0) avgPercentage, IFNULL(MAX(score),0) bestScore FROM quiz_attempts WHERE user_id=?"

);

ps.setInt(1,userId);

rs=ps.executeQuery();

if(rs.next()){

totalAttempts=rs.getInt("totalAttempts");
avgPercentage=rs.getDouble("avgPercentage");
bestScore=rs.getInt("bestScore");

}

rs.close();
ps.close();

ps=con.prepareStatement(

"SELECT qa.*,c.category_name FROM quiz_attempts qa JOIN categories c ON qa.category_id=c.category_id WHERE qa.user_id=? ORDER BY qa.attempt_date DESC"

);

ps.setInt(1,userId);

rs=ps.executeQuery();

%>

<!DOCTYPE html>

<html>

<head>

<title>Progress Report</title>

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

height:80px;
background:#2563eb;
color:white;
display:flex;
justify-content:center;
align-items:center;
font-size:28px;
font-weight:bold;

}

.container{

max-width:1200px;
margin:40px auto;

}

.cards{

display:grid;
grid-template-columns:repeat(3,1fr);
gap:25px;
margin-bottom:35px;

}

.card{

background:white;
padding:30px;
border-radius:18px;
box-shadow:0 15px 35px rgba(0,0,0,.08);
text-align:center;

}

.card h3{

color:#6b7280;
margin-bottom:15px;

}

.card h1{

font-size:42px;
color:#2563eb;

}

.table{

background:white;
border-radius:20px;
overflow:hidden;
box-shadow:0 15px 35px rgba(0,0,0,.08);

}

table{

width:100%;
border-collapse:collapse;

}

th{

background:#2563eb;
color:white;
padding:18px;

}

td{

padding:16px;
text-align:center;
border-bottom:1px solid #e5e7eb;

}

tr:hover{

background:#f9fafb;

}

.badge{

padding:8px 15px;
border-radius:30px;
color:white;
font-weight:bold;

}

.pass{

background:#16a34a;

}

.fail{

background:#dc2626;

}

.btn{

display:inline-block;
margin-top:30px;
padding:14px 30px;
background:#2563eb;
color:white;
text-decoration:none;
border-radius:10px;

}

</style>

</head>

<body>

<div class="header">

My Quiz Progress

</div>

<div class="container">

<div class="cards">

<div class="card">

<h3>Total Attempts</h3>

<h1>

<%=totalAttempts%>

</h1>

</div>

<div class="card">

<h3>Average Percentage</h3>

<h1>

<%=String.format("%.2f",avgPercentage)%>%

</h1>

</div>

<div class="card">

<h3>Best Score</h3>

<h1>

<%=bestScore%>/100

</h1>

</div>

</div>

<div class="table">

<table>

<tr>

<th>Category</th>

<th>Score</th>

<th>Correct</th>

<th>Wrong</th>

<th>Percentage</th>

<th>Time</th>

<th>Date</th>

<th>Status</th>

</tr>
<%
while(rs.next()){

String status="Pass";
String badge="pass";

if(rs.getDouble("percentage")<40){

status="Fail";
badge="fail";

}
%>

<tr>

<td>

<%=rs.getString("category_name")%>

</td>

<td>

<b style="color:#2563eb;">

<%=rs.getInt("score")%>/100

</b>

</td>

<td style="color:#16a34a;font-weight:bold;">

<%=rs.getInt("correct_answers")%>

</td>

<td style="color:#dc2626;font-weight:bold;">

<%=rs.getInt("wrong_answers")%>

</td>

<td>

<%=String.format("%.2f",rs.getDouble("percentage"))%>%

</td>

<td>

<%=rs.getInt("time_taken")%> sec

</td>

<td>

<%=rs.getTimestamp("attempt_date")%>

</td>

<td>

<span class="badge <%=badge%>">

<%=status%>

</span>

</td>

</tr>

<%
}
%>

</table>

</div>

<div style="text-align:center;">

<a href="dashboard.jsp" class="btn">

Back to Dashboard

</a>

</div>

</div>

</body>

</html>

<%
}
catch(Exception e){
%>



<html>

<head>

<title>Error</title>

<style>

body{

margin:0;
display:flex;
justify-content:center;
align-items:center;
height:100vh;
background:#f4f7fc;
font-family:'Segoe UI';

}

.box{

background:white;
padding:40px;
border-radius:20px;
box-shadow:0 15px 35px rgba(0,0,0,.12);
width:550px;
text-align:center;

}

h2{

color:#dc2626;
margin-bottom:15px;

}

a{

display:inline-block;
margin-top:20px;
padding:12px 28px;
background:#2563eb;
color:white;
text-decoration:none;
border-radius:10px;

}

</style>

</head>

<body>

<div class="box">

<h2>Database Error</h2>

<p>

<%=e.getMessage()%>

</p>

<a href="dashboard.jsp">

Go Back

</a>

</div>

</body>

</html>

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