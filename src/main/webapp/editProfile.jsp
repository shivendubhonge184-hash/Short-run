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

PreparedStatement ps=
con.prepareStatement("select * from users where user_id=?");

ps.setInt(1,id);

ResultSet rs=ps.executeQuery();

rs.next();
%>

<!DOCTYPE html>
<html>
<head>

<title>Edit Profile</title>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{
background:#eef2f7;
display:flex;
min-height:100vh;
}

/* SIDEBAR */

.sidebar{

width:250px;
background:#111827;
color:white;
padding:30px 0;
position:fixed;
height:100%;
}

.sidebar h2{
text-align:center;
margin-bottom:40px;
}

.sidebar a{

display:block;
padding:15px 30px;
color:white;
text-decoration:none;
transition:.3s;

}

.sidebar a:hover{

background:#2563eb;

}

/* MAIN */

.main{

margin-left:250px;
width:100%;
padding:40px;

}

/* CARD */

.card{

max-width:900px;
margin:auto;
background:white;
border-radius:20px;
box-shadow:0 15px 40px rgba(0,0,0,.08);
overflow:hidden;

}

/* TOP */

.top{

background:linear-gradient(135deg,#2563eb,#4f46e5);
padding:40px;
text-align:center;
color:white;

}

.avatar{

width:110px;
height:110px;
border-radius:50%;
background:white;
display:flex;
align-items:center;
justify-content:center;
margin:auto;
font-size:55px;
color:#2563eb;
margin-bottom:15px;

}

.top h2{

font-size:28px;

}

.top p{

opacity:.9;

}

/* FORM */

.form{

padding:40px;

}

.grid{

display:grid;
grid-template-columns:1fr 1fr;
gap:25px;

}

.field{

display:flex;
flex-direction:column;

}

label{

font-weight:600;
margin-bottom:8px;
color:#374151;

}

input{

padding:13px;
border:1px solid #d1d5db;
border-radius:10px;
font-size:15px;
transition:.3s;

}

input:focus{

outline:none;
border-color:#2563eb;
box-shadow:0 0 0 4px rgba(37,99,235,.15);

}

/* BUTTONS */

.buttons{

margin-top:35px;
display:flex;
gap:20px;

}

.save{

background:#2563eb;
color:white;
border:none;
padding:15px 35px;
border-radius:10px;
font-size:16px;
cursor:pointer;
transition:.3s;

}

.save:hover{

background:#1d4ed8;
transform:translateY(-2px);

}

.back{

background:#6b7280;
color:white;
padding:15px 35px;
text-decoration:none;
border-radius:10px;
transition:.3s;

}

.back:hover{

background:#4b5563;

}

@media(max-width:850px){

.sidebar{

display:none;

}

.main{

margin-left:0;

}

.grid{

grid-template-columns:1fr;

}

}

</style>

</head>

<body>

<div class="sidebar">

<h2>Placement Portal</h2>

<a href="dashboard.jsp">
<i class="fa fa-home"></i> Dashboard
</a>

<a href="profile.jsp">
<i class="fa fa-user"></i> Profile
</a>

<a href="categories.jsp">
<i class="fa fa-book"></i> Aptitude Tests
</a>

<a href="progress.jsp">
<i class="fa fa-chart-line"></i> Progress
</a>

<a href="Logout.jsp">
<i class="fa fa-sign-out-alt"></i> Logout
</a>

</div>

<div class="main">

<div class="card">

<div class="top">

<div class="avatar">

<i class="fa fa-user"></i>

</div>

<h2><%= rs.getString("full_name") %></h2>

<p>Edit your placement profile</p>

</div>

<div class="form">

<form action="updateProfile.jsp" method="post">

<div class="grid">

<div class="field">

<label>Full Name</label>

<input
type="text"
name="full_name"
value="<%= rs.getString("full_name") %>">

</div>

<div class="field">

<label>Mobile Number</label>

<input
type="text"
name="mobile"
value="<%= rs.getString("mobile") %>">

</div>

<div class="field">

<label>Email</label>

<input
type="email"
value="<%= rs.getString("email") %>"
readonly>

</div>

<div class="field">

<label>Branch</label>

<input
type="text"
value="<%= rs.getString("branch") %>"
readonly>

</div>

<div class="field">

<label>Skills</label>

<input
type="text"
name="skills"
value="<%= rs.getString("skills") %>">

</div>

<div class="field">

<label>College</label>

<input
type="text"
value="<%= rs.getString("college") %>"
readonly>

</div>

</div>

<div class="buttons">

<button class="save">
<i class="fa fa-save"></i>
Update Profile
</button>

<a class="back" href="dashboard.jsp">
<i class="fa fa-arrow-left"></i>
Dashboard
</a>

</div>

</form>

</div>

</div>

</div>

</body>
</html>