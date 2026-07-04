<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){
    response.sendRedirect("studentLogin.jsp");
    return;
}

int id=(Integer)session.getAttribute("user_id");

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

PreparedStatement ps=con.prepareStatement(
"SELECT * FROM users WHERE user_id=?");

ps.setInt(1,id);

ResultSet rs=ps.executeQuery();

if(!rs.next()){
    out.println("User not found");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<title>My Profile</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{

background:#eef2f7;

}

/* HEADER */

.header{

height:220px;
background:linear-gradient(135deg,#2563eb,#4f46e5);

}

/* CARD */

.profile{

width:1100px;
margin:-80px auto 40px;
background:white;
border-radius:18px;
box-shadow:0 15px 35px rgba(0,0,0,.12);
overflow:hidden;

}

.top{

display:flex;
align-items:center;
padding:35px;

}

.avatar{

width:140px;
height:140px;
border-radius:50%;
background:#2563eb;
display:flex;
justify-content:center;
align-items:center;
font-size:65px;
color:white;
margin-right:30px;

}

.info h1{

font-size:32px;
color:#111827;

}

.info h3{

margin-top:10px;
color:#6b7280;
font-weight:500;

}

.info p{

margin-top:6px;
color:#6b7280;

}

.btns{

margin-left:auto;
display:flex;
gap:15px;

}

.btn{

padding:13px 24px;
border:none;
border-radius:10px;
font-size:15px;
cursor:pointer;
text-decoration:none;
font-weight:600;

}

.edit{

background:#2563eb;
color:white;

}

.dashboard{

background:#111827;
color:white;

}

/* DETAILS */

.details{

padding:35px;

display:grid;
grid-template-columns:1fr 1fr;
gap:25px;

}

.card{

background:#f9fafb;
padding:22px;
border-radius:12px;

}

.card h3{

margin-bottom:18px;
color:#111827;

}

.row{

display:flex;
justify-content:space-between;
padding:12px 0;
border-bottom:1px solid #e5e7eb;

}

.row:last-child{

border:none;

}

.label{

font-weight:600;
color:#374151;

}

.value{

color:#6b7280;

}

.skills{

margin-top:15px;
background:#eff6ff;
padding:15px;
border-radius:10px;
color:#2563eb;
font-weight:600;

}

.footer{

padding:25px;
text-align:center;
background:#f8fafc;
color:#6b7280;

}

@media(max-width:900px){

.profile{

width:95%;

}

.top{

flex-direction:column;
text-align:center;

}

.avatar{

margin-right:0;
margin-bottom:20px;

}

.btns{

margin:25px 0 0;

}

.details{

grid-template-columns:1fr;

}

}

</style>

</head>

<body>

<div class="header"></div>

<div class="profile">

<div class="top">

<div class="avatar">

<i class="fa-solid fa-user"></i>

</div>

<div class="info">

<h1><%= rs.getString("full_name") %></h1>

<h3><%= rs.getString("branch") %></h3>

<p><%= rs.getString("college") %></p>

<p><%= rs.getString("city") %></p>

</div>

<div class="btns">

<a href="editProfile.jsp" class="btn edit">
<i class="fa-solid fa-pen"></i>
Edit Profile
</a>

<a href="dashboard.jsp" class="btn dashboard">
<i class="fa-solid fa-house"></i>
Dashboard
</a>

</div>

</div>

<div class="details">

<div class="card">

<h3>
<i class="fa-solid fa-user"></i>
Personal Information
</h3>

<div class="row">
<span class="label">Email</span>
<span class="value"><%= rs.getString("email") %></span>
</div>

<div class="row">
<span class="label">Mobile</span>
<span class="value"><%= rs.getString("mobile") %></span>
</div>

<div class="row">
<span class="label">Gender</span>
<span class="value"><%= rs.getString("gender") %></span>
</div>

<div class="row">
<span class="label">DOB</span>
<span class="value"><%= rs.getString("dob") %></span>
</div>

</div>

<div class="card">

<h3>
<i class="fa-solid fa-graduation-cap"></i>
Academic Information
</h3>

<div class="row">
<span class="label">College</span>
<span class="value"><%= rs.getString("college") %></span>
</div>

<div class="row">
<span class="label">Branch</span>
<span class="value"><%= rs.getString("branch") %></span>
</div>

<div class="row">
<span class="label">Study Year</span>
<span class="value"><%= rs.getString("study_year") %></span>
</div>

<div class="row">
<span class="label">Semester</span>
<span class="value"><%= rs.getString("semester") %></span>
</div>

<div class="row">
<span class="label">CGPA</span>
<span class="value"><%= rs.getString("cgpa") %></span>
</div>

</div>

<div class="card">

<h3>
<i class="fa-solid fa-code"></i>
Technical Skills
</h3>

<div class="skills">

<%= rs.getString("skills") %>

</div>

</div>

<div class="card">

<h3>
<i class="fa-solid fa-link"></i>
Professional Links
</h3>

<div class="row">
<span class="label">LinkedIn</span>
<span class="value">
<a href="<%= rs.getString("linkedin") %>" target="_blank">
View
</a>
</span>
</div>

<div class="row">
<span class="label">GitHub</span>
<span class="value">
<a href="<%= rs.getString("github") %>" target="_blank">
View
</a>
</span>
</div>

</div>

</div>

<div class="footer">

Placement Preparation Portal © 2026

</div>

</div>

</body>

</html>