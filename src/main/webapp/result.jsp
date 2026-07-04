<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){
    response.sendRedirect("studentLogin.jsp");
    return;
}

Integer score=(Integer)session.getAttribute("result_score");
Integer correct=(Integer)session.getAttribute("result_correct");
Integer wrong=(Integer)session.getAttribute("result_wrong");
Double percentage=(Double)session.getAttribute("result_percentage");
Integer total=(Integer)session.getAttribute("result_total");
Integer time=(Integer)session.getAttribute("result_time");

if(score==null || correct==null || wrong==null || percentage==null || total==null || time==null){
    response.sendRedirect("aptitude.jsp");
    return;
}

int minutes=time/60;
int seconds=time%60;

String performance="Needs Improvement";
String color="#dc2626";
String icon="✗";

if(percentage>=80){
    performance="Excellent";
    color="#16a34a";
    icon="🏆";
}
else if(percentage>=60){
    performance="Very Good";
    color="#2563eb";
    icon="★";
}
else if(percentage>=40){
    performance="Good";
    color="#f59e0b";
    icon="✓";
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Quiz Result</title>

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
max-width:1100px;
margin:40px auto;
display:grid;
grid-template-columns:2fr 1fr;
gap:30px;
}

.card{
background:white;
border-radius:20px;
padding:40px;
box-shadow:0 15px 40px rgba(0,0,0,.08);
}

.result-circle{
width:140px;
height:140px;
border-radius:50%;
background:<%=color%>;
color:white;
font-size:60px;
display:flex;
justify-content:center;
align-items:center;
margin:auto;
margin-bottom:30px;
}

.title{
text-align:center;
font-size:34px;
font-weight:bold;
margin-bottom:10px;
}

.subtitle{
text-align:center;
font-size:18px;
color:#6b7280;
margin-bottom:40px;
}

.grid{
display:grid;
grid-template-columns:repeat(2,1fr);
gap:20px;
}

.box{
background:#f8fafc;
padding:25px;
border-radius:15px;
text-align:center;
}

.box h3{
font-size:18px;
color:#6b7280;
margin-bottom:10px;
}

.box h1{
font-size:36px;
color:#111827;
}

.sidebar h2{
margin-bottom:25px;
}

.progress{
height:16px;
background:#e5e7eb;
border-radius:20px;
overflow:hidden;
margin:20px 0;
}

.progress-bar{
height:100%;
width:<%=percentage%>%;
background:<%=color%>;
}

.btn{
display:block;
width:100%;
padding:16px;
text-align:center;
text-decoration:none;
background:#2563eb;
color:white;
border-radius:12px;
margin-top:20px;
font-weight:600;
transition:.3s;
}

.btn:hover{
background:#1d4ed8;
}

table td{
padding:12px 0;
}

</style>

</head>

<body>

<div class="header">
Placement Preparation Portal
</div>

<div class="container">

<div class="card">

<div class="result-circle">
<%=icon%>
</div>

<div class="title">
<%=performance%>
</div>

<div class="subtitle">
You have completed the assessment successfully.
</div>

<div class="grid">

<div class="box">
<h3>Total Questions</h3>
<h1><%=total%></h1>
</div>

<div class="box">
<h3>Correct Answers</h3>
<h1 style="color:#16a34a;"><%=correct%></h1>
</div>

<div class="box">
<h3>Wrong Answers</h3>
<h1 style="color:#dc2626;"><%=wrong%></h1>
</div>

<div class="box">
<h3>Score</h3>
<h1 style="color:#2563eb;"><%=score%>/100</h1>
</div>

</div>

</div>

<div class="card sidebar">

<h2>Performance Summary</h2>

<p><strong>Percentage</strong></p>

<div class="progress">
<div class="progress-bar"></div>
</div>

<h1 style="color:<%=color%>;font-size:42px;margin-bottom:25px;">
<%=String.format("%.2f",percentage)%>%
</h1>

<table style="width:100%;border-collapse:collapse;">

<tr>
<td style="color:#6b7280;">Performance</td>
<td style="text-align:right;font-weight:bold;color:<%=color%>;">
<%=performance%>
</td>
</tr>

<tr>
<td style="color:#6b7280;">Time Taken</td>
<td style="text-align:right;font-weight:bold;">
<%=minutes%> Min <%=seconds%> Sec
</td>
</tr>

<tr>
<td style="color:#6b7280;">Accuracy</td>
<td style="text-align:right;font-weight:bold;">
<%=correct%>/<%=total%>
</td>
</tr>

<tr>
<td style="color:#6b7280;">Final Score</td>
<td style="text-align:right;font-weight:bold;color:#2563eb;">
<%=score%>/100
</td>
</tr>

</table>

<a href="aptitude.jsp" class="btn">
Take Another Quiz
</a>

<a href="dashboard.jsp" class="btn" style="background:#16a34a;">
Go To Dashboard
</a>

</div>

</div>

<script>
window.history.pushState(null,null,window.location.href);

window.onpopstate=function(){
    window.history.go(1);
};
</script>

</body>

</html>

<%
session.removeAttribute("result_score");
session.removeAttribute("result_correct");
session.removeAttribute("result_wrong");
session.removeAttribute("result_percentage");
session.removeAttribute("result_total");
session.removeAttribute("result_time");
%>