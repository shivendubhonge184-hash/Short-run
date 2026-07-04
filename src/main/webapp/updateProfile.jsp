<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){
    response.sendRedirect("studentLogin.jsp");
    return;
}

int id=(Integer)session.getAttribute("user_id");

String name=request.getParameter("full_name");
String mobile=request.getParameter("mobile");
String skills=request.getParameter("skills");

Connection con=null;
PreparedStatement ps=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

ps=con.prepareStatement(
"UPDATE users SET full_name=?, mobile=?, skills=? WHERE user_id=?");

ps.setString(1,name);
ps.setString(2,mobile);
ps.setString(3,skills);
ps.setInt(4,id);

int result=ps.executeUpdate();

if(result>0){
%>

<!DOCTYPE html>
<html>
<head>

<title>Profile Updated</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{

height:100vh;
display:flex;
justify-content:center;
align-items:center;
background:linear-gradient(135deg,#2563eb,#4f46e5);

}

.card{

width:420px;
background:white;
padding:45px;
border-radius:20px;
text-align:center;
box-shadow:0 20px 45px rgba(0,0,0,.18);

}

.circle{

width:90px;
height:90px;
margin:auto;
border-radius:50%;
background:#22c55e;
display:flex;
align-items:center;
justify-content:center;
font-size:42px;
color:white;
margin-bottom:25px;

}

h2{

color:#111827;
margin-bottom:10px;

}

p{

color:#6b7280;
margin-bottom:30px;

}

.loader{

width:100%;
height:8px;
background:#e5e7eb;
border-radius:10px;
overflow:hidden;

}

.bar{

height:100%;
background:#2563eb;
width:0%;
animation:load 2s linear forwards;

}

@keyframes load{

from{
width:0%;
}

to{
width:100%;
}

}

</style>

<script>

setTimeout(function(){

window.location="profile.jsp";

},2000);

</script>

</head>

<body>

<div class="card">

<div class="circle">

✓

</div>

<h2>Profile Updated Successfully</h2>

<p>Your profile has been updated successfully.</p>

<div class="loader">

<div class="bar"></div>

</div>

</div>

</body>
</html>

<%
}
else{
%>

<script>

alert("No changes were made.");

window.location="editProfile.jsp";

</script>

<%
}

}catch(Exception e){
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
border-radius:15px;
box-shadow:0 10px 30px rgba(0,0,0,.12);
text-align:center;
width:500px;

}

h2{

color:#dc2626;
margin-bottom:15px;

}

a{

display:inline-block;
margin-top:20px;
padding:12px 25px;
background:#2563eb;
color:white;
text-decoration:none;
border-radius:8px;

}

</style>

</head>

<body>

<div class="box">

<h2>Database Error</h2>

<p><%= e.getMessage() %></p>

<a href="editProfile.jsp">
Go Back
</a>

</div>

</body>
</html>

<%
}
finally{

try{
if(ps!=null) ps.close();
}catch(Exception e){}

try{
if(con!=null) con.close();
}catch(Exception e){}

}
%>