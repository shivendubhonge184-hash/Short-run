<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){

response.sendRedirect("studentLogin.jsp");

return;

}

String type=request.getParameter("type");

if(type==null){

type="Notes";

}

String subject=request.getParameter("subject");

if(subject==null){

subject="All";

}

String search=request.getParameter("search");

if(search==null){

search="";

}

Connection con=null;

PreparedStatement ps=null;

ResultSet rs=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006");

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title><%=type%></title>

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

.header{

background:linear-gradient(135deg,#2563eb,#4f46e5);

padding:40px;

color:white;

text-align:center;

}

.header h1{

font-size:38px;

}

.container{

width:1200px;

margin:35px auto;

}

.filter-box{

background:white;

padding:25px;

border-radius:15px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

margin-bottom:30px;

}

form{

display:grid;

grid-template-columns:2fr 1fr 180px;

gap:15px;

}

input,select{

padding:12px;

border:1px solid #ddd;

border-radius:10px;

font-size:15px;

outline:none;

}

button{

background:#2563eb;

color:white;

border:none;

border-radius:10px;

cursor:pointer;

font-size:15px;

font-weight:600;

}

button:hover{

background:#1d4ed8;

}

.cards{

display:grid;

grid-template-columns:repeat(auto-fit,minmax(340px,1fr));

gap:25px;

}

.card{

background:white;

padding:25px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

transition:.3s;

}

.card:hover{

transform:translateY(-6px);

}

.card h2{

color:#2563eb;

margin-bottom:12px;

}

.card p{

color:#555;

margin-bottom:10px;

line-height:25px;

}

.btn{

display:inline-block;

padding:10px 20px;

background:#2563eb;

color:white;

text-decoration:none;

border-radius:8px;

margin-top:12px;

}

.btn:hover{

background:#1d4ed8;

}

</style>

</head>

<body>

<div class="header">

<h1>

<i class="fa-solid fa-book-open"></i>

<%=type%>

</h1>

</div>

<div class="container">

<div class="filter-box">

<form method="get" action="viewMaterial.jsp">

<input
type="hidden"
name="type"
value="<%=type%>">

<input

type="text"

name="search"

placeholder="Search Resources..."

value="<%=search%>">

<select name="subject">

<option value="All">All Subjects</option>

<option value="Operating System">Operating System</option>

<option value="DBMS">DBMS</option>

<option value="Computer Networks">Computer Networks</option>

<option value="OOP">OOP</option>

<option value="Aptitude">Aptitude</option>

<option value="Programming">Programming</option>

</select>

<button>

Search

</button>

</form>

</div>

<div class="cards">
<%

String sql=

"SELECT * FROM study_materials WHERE resource_type=?";

if(!subject.equals("All")){

sql+=" AND subject=?";

}

if(search!=null && !search.trim().isEmpty()){

sql+=" AND (title LIKE ? OR description LIKE ?)";

}

sql+=" ORDER BY upload_date DESC";

ps=con.prepareStatement(sql);

int index=1;

ps.setString(index++,type);

if(!subject.equals("All")){

ps.setString(index++,subject);

}

if(search!=null && !search.trim().isEmpty()){

ps.setString(index++,"%"+search+"%");

ps.setString(index++,"%"+search+"%");

}

rs=ps.executeQuery();

boolean found=false;

while(rs.next()){

found=true;

%>

<div class="card">

<h2>

<%=rs.getString("title")%>

</h2>

<p>

<b>Subject :</b>

<%=rs.getString("subject")%>

</p>

<p>

<b>Type :</b>

<%=rs.getString("resource_type")%>

</p>

<%

if(rs.getString("company_name")!=null){

%>

<p>

<b>Company :</b>

<%=rs.getString("company_name")%>

</p>

<%

}

%>

<p>

<%=rs.getString("description")%>

</p>

<p>

<b>Uploaded :</b>

<%=rs.getString("upload_date")%>

</p>

<a

class="btn"

href="materialDetails.jsp?material_id=<%=rs.getInt("material_id")%>">

View Details

</a>

</div>

<%

}

%>
<%

if(!found){

%>

<div style="grid-column:1/-1;
background:white;
padding:50px;
border-radius:18px;
text-align:center;
box-shadow:0 10px 30px rgba(0,0,0,.08);">

<i class="fa-solid fa-folder-open"
style="font-size:70px;color:#2563eb;margin-bottom:20px;"></i>

<h2>No Resources Found</h2>

<p style="margin-top:10px;color:#666;">

No <%=type%> available for the selected filters.

</p>

<a

href="studyMaterial.jsp"

class="btn"

style="margin-top:25px;">

Back to Study Material

</a>

</div>

<%

}

%>

</div>

</div>

</body>

</html>

<%

}catch(Exception e){

out.println(

"<h2 style='color:red;text-align:center;'>"

+e.getMessage()+

"</h2>"

);

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