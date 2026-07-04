<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Login</title>

<style>

body{
margin:0;
font-family:'Segoe UI';
background:linear-gradient(135deg,#1e3c72,#2a5298);
height:100vh;
display:flex;
justify-content:center;
align-items:center;
}

.login-box{

width:400px;
background:white;
padding:40px;
border-radius:20px;
box-shadow:0 10px 30px rgba(0,0,0,.3);
}

h1{
text-align:center;
margin-bottom:30px;
color:#2a5298;
}

input{
width:100%;
padding:14px;
margin:12px 0;
border:1px solid #ccc;
border-radius:10px;
}

button{

width:100%;
padding:15px;
border:none;
background:#2563eb;
color:white;
font-size:18px;
border-radius:10px;
cursor:pointer;
}

a{
text-decoration:none;
}

.bottom{
margin-top:20px;
text-align:center;
}

</style>
</head>

<body>

<div class="login-box">

<h1>Student Login</h1>

<form action="Login.jsp" method="post">

<input type="email"
name="email"
placeholder="Enter Email"
required>

<input type="password"
name="password"
placeholder="Enter Password"
required>

<button type="submit">
Login
</button>

</form>

<div class="bottom">
Don't have an account?
<a href="register.jsp">Register</a>
</div>

</div>

</body>
</html>