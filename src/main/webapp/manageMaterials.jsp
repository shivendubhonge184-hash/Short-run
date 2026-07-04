<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("admin")==null){

response.sendRedirect("adminLogin.jsp");

return;

}

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

String search=request.getParameter("search");
String type=request.getParameter("type");

if(search==null)
search="";

if(type==null)
type="";

int totalMaterials=0;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

ps=con.prepareStatement(

"SELECT COUNT(*) FROM study_materials"

);

rs=ps.executeQuery();

if(rs.next()){

totalMaterials=rs.getInt(1);

}

rs.close();

ps.close();

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Manage Study Materials</title>

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

padding:35px;

text-align:center;

color:white;

}

.container{

width:1300px;

margin:35px auto;

}

.top{

display:flex;

justify-content:space-between;

align-items:center;

margin-bottom:30px;

}

.card{

background:white;

padding:25px 40px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}

.card h2{

font-size:38px;

color:#2563eb;

}

.card p{

margin-top:8px;

color:#6b7280;

}

.addBtn{

background:#2563eb;

color:white;

padding:14px 30px;

text-decoration:none;

border-radius:10px;

font-weight:600;

transition:.3s;

}

.addBtn:hover{

background:#1d4ed8;

}

.filters{

background:white;

padding:25px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

display:grid;

grid-template-columns:2fr 1fr auto;

gap:15px;

margin-bottom:30px;

}

.filters input,
.filters select{

padding:13px;

border:1px solid #d1d5db;

border-radius:10px;

outline:none;

font-size:15px;

}

.filters button{

background:#2563eb;

color:white;

border:none;

padding:13px 28px;

border-radius:10px;

cursor:pointer;

font-weight:600;

}

.filters button:hover{

background:#1d4ed8;

}

.table-box{

background:white;

padding:25px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}
table{

width:100%;

border-collapse:collapse;

}

th{

background:#2563eb;

color:white;

padding:15px;

}

td{

padding:15px;

border-bottom:1px solid #e5e7eb;

text-align:center;

}

.action{

padding:8px 18px;

border-radius:8px;

color:white;

text-decoration:none;

font-size:14px;

font-weight:600;

display:inline-block;

margin:2px;

}

.edit{

background:#16a34a;

}

.edit:hover{

background:#15803d;

}

.delete{

background:#dc2626;

}

.delete:hover{

background:#b91c1c;

}

.back{

display:inline-block;

margin-top:25px;

padding:12px 25px;

background:#6b7280;

color:white;

text-decoration:none;

border-radius:10px;

}

.back:hover{

background:#4b5563;

}

@media(max-width:1100px){

.container{

width:95%;

}

.filters{

grid-template-columns:1fr;

}

}

</style>

</head>

<body>

<div class="header">

<h1>

<i class="fa-solid fa-book-open-reader"></i>

Manage Study Materials

</h1>

<p>

View, Search and Manage Study Materials

</p>

</div>

<div class="container">

<div class="top">

<div class="card">

<h2><%=totalMaterials%></h2>

<p>Total Materials</p>

</div>

<a href="uploadMaterial.jsp" class="addBtn">

<i class="fa-solid fa-upload"></i>

Upload Material

</a>

</div>

<form method="get" class="filters">

<input
type="text"
name="search"
placeholder="Search by Title..."
value="<%=search%>">

<select name="type">

<option value="">All Types</option>

<option value="Notes" <%=type.equals("Notes")?"selected":""%>>Notes</option>

<option value="PYQ" <%=type.equals("PYQ")?"selected":""%>>PYQ</option>

<option value="Interview Experience" <%=type.equals("Interview Experience")?"selected":""%>>

Interview Experience

</option>

<option value="Video" <%=type.equals("Video")?"selected":""%>>

Video

</option>

</select>

<button type="submit">

<i class="fa-solid fa-magnifying-glass"></i>

Search

</button>

</form>

<div class="table-box">

<table>

<tr>

<th>ID</th>

<th>Title</th>

<th>Subject</th>

<th>Type</th>

<th>Company</th>

<th>Date</th>

<th>Actions</th>

</tr>

<%

String sql=

"SELECT * FROM study_materials WHERE 1=1";

if(!search.trim().equals("")){

sql+=" AND title LIKE ?";

}

if(!type.equals("")){

sql+=" AND resource_type=?";

}

sql+=" ORDER BY upload_date DESC";

ps=con.prepareStatement(sql);

int i=1;

if(!search.trim().equals("")){

ps.setString(i++,"%"+search+"%");

}

if(!type.equals("")){

ps.setString(i++,type);

}

rs=ps.executeQuery();

while(rs.next()){

%>

<tr>

<td>

<%=rs.getInt("material_id")%>

</td>

<td style="text-align:left;">

<%=rs.getString("title")%>

</td>

<td>

<%=rs.getString("subject")%>

</td>

<td>

<%=rs.getString("resource_type")%>

</td>

<td>

<%=rs.getString("company_name")==null?"-":rs.getString("company_name")%>

</td>

<td>

<%=rs.getString("upload_date")%>

</td>

<td>

<a

href="editMaterial.jsp?id=<%=rs.getInt("material_id")%>"

class="action edit">

Edit

</a>

<a

href="deleteMaterial.jsp?id=<%=rs.getInt("material_id")%>"

class="action delete"

onclick="return confirm('Delete this material?');">

Delete

</a>

</td>

</tr>

<%

}

%>

</table>

<br>

<a href="adminDashboard.jsp" class="back">

<i class="fa-solid fa-arrow-left"></i>

Back to Dashboard

</a>

</div>
</div>

</div>

</body>

</html>

<%

}catch(Exception e){

out.println("<h2 style='color:red;text-align:center;'>");
out.println(e.getMessage());
out.println("</h2>");

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