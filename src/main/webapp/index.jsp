<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Placement Preparation Portal</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{
height:100vh;
background:linear-gradient(135deg,#0f172a,#1e3a8a);
display:flex;
justify-content:center;
align-items:center;
}

.container{
width:1000px;
height:550px;
background:white;
border-radius:25px;
overflow:hidden;
display:flex;
box-shadow:0 20px 40px rgba(0,0,0,.3);
}

.left{
width:55%;
background:linear-gradient(135deg,#2563eb,#7c3aed);
color:white;
padding:60px;
display:flex;
flex-direction:column;
justify-content:center;
}

.left h1{
font-size:48px;
margin-bottom:20px;
}

.left p{
font-size:18px;
line-height:1.8;
}

.right{
width:45%;
padding:60px;
display:flex;
flex-direction:column;
justify-content:center;
}

.btn{
padding:16px;
margin:15px 0;
border:none;
border-radius:12px;
font-size:18px;
cursor:pointer;
text-decoration:none;
text-align:center;
color:white;
}

.login{background:#2563eb;}
.signup{background:#16a34a;}
.admin{background:#dc2626;}

</style>
</head>

<body>

<div class="container">

<div class="left">
<h1>Placement Preparation Portal</h1>

<p>
Practice aptitude questions, track performance,
analyze progress and prepare effectively for
campus placements.
</p>
</div>

<div class="right">

<h2>Get Started</h2>

<a href="studentLogin.jsp" class="btn login">
Student Login
</a>

<a href="register.jsp" class="btn signup">
Create Account
</a>

<a href="adminLogin.jsp" class="btn admin">
    Admin Login

</a>

</div>

</div>

</body>
</html>