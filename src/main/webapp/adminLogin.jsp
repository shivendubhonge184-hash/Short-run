<!DOCTYPE html>
<html>
<head>
<title>Admin Login</title>

<style>

body{
font-family:'Segoe UI';
background:linear-gradient(135deg,#111827,#1e3a8a);
height:100vh;
display:flex;
justify-content:center;
align-items:center;
}

.box{
width:400px;
background:white;
padding:40px;
border-radius:20px;
box-shadow:0 10px 30px rgba(0,0,0,.3);
}

input{
width:100%;
padding:14px;
margin:15px 0;
border:1px solid #ddd;
border-radius:10px;
}

button{
width:100%;
padding:15px;
background:#dc2626;
color:white;
border:none;
border-radius:10px;
font-size:18px;
}

</style>

</head>
<body>

<div class="box">

<h1>Admin Login</h1>

<form action="adminCheck.jsp" method="post">

<input type="email" name="email"
placeholder="Admin Email" required>

<input type="password" name="password"
placeholder="Password" required>

<button>Login</button>

</form>

</div>

</body>
</html>