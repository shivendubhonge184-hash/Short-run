<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("admin")==null){

response.sendRedirect("adminLogin.jsp");

return;

}

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

String success="";
String error="";

int id=Integer.parseInt(request.getParameter("id"));

String title="";
String subject="";
String resourceType="";
String companyName="";
String description="";
String videoLink="";

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

if("POST".equalsIgnoreCase(request.getMethod())){

title=request.getParameter("title");

subject=request.getParameter("subject");

resourceType=request.getParameter("resourceType");

companyName=request.getParameter("company");

description=request.getParameter("description");

videoLink=request.getParameter("videoLink");

ps=con.prepareStatement(

"UPDATE study_materials SET title=?,subject=?,resource_type=?,company_name=?,description=?,video_link=? WHERE material_id=?"

);

ps.setString(1,title);

ps.setString(2,subject);

ps.setString(3,resourceType);

ps.setString(4,companyName);

ps.setString(5,description);

ps.setString(6,videoLink);

ps.setInt(7,id);

ps.executeUpdate();

ps.close();

success="Study Material Updated Successfully.";

}

ps=con.prepareStatement(

"SELECT * FROM study_materials WHERE material_id=?"

);

ps.setInt(1,id);

rs=ps.executeQuery();

if(rs.next()){

title=rs.getString("title");

subject=rs.getString("subject");

resourceType=rs.getString("resource_type");

companyName=rs.getString("company_name");

description=rs.getString("description");

videoLink=rs.getString("video_link");

}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Edit Study Material</title>

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

width:900px;

margin:35px auto;

}

.form-box{

background:white;

padding:35px;

border-radius:18px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}
label{

display:block;

margin-bottom:8px;

font-weight:600;

color:#374151;

}

input[type=text],
textarea,
select{

width:100%;

padding:13px;

border:1px solid #d1d5db;

border-radius:10px;

margin-bottom:20px;

outline:none;

font-size:15px;

}

textarea{

height:140px;

resize:vertical;

}

.row{

display:grid;

grid-template-columns:1fr 1fr;

gap:20px;

}

.success{

background:#dcfce7;

color:#166534;

padding:15px;

border-radius:10px;

margin-bottom:20px;

}

.error{

background:#fee2e2;

color:#991b1b;

padding:15px;

border-radius:10px;

margin-bottom:20px;

}

.btn{

background:#2563eb;

color:white;

border:none;

padding:14px 28px;

border-radius:10px;

cursor:pointer;

font-size:16px;

font-weight:600;

}

.btn:hover{

background:#1d4ed8;

}

.back{

background:#6b7280;

text-decoration:none;

margin-left:10px;

display:inline-block;

}

.back:hover{

background:#4b5563;

}

</style>

</head>

<body>

<div class="header">

<h1>

<i class="fa-solid fa-pen-to-square"></i>

Edit Study Material

</h1>

</div>

<div class="container">

<div class="form-box">

<%

if(!success.equals("")){

%>

<div class="success">

<%=success%>

</div>

<%

}

if(!error.equals("")){

%>

<div class="error">

<%=error%>

</div>

<%

}

%>

<form method="post">

<div class="row">

<div>

<label>Title</label>

<input
type="text"
name="title"
value="<%=title%>"
required>

</div>

<div>

<label>Subject</label>

<input
type="text"
name="subject"
value="<%=subject%>"
required>

</div>

</div>

<div class="row">

<div>

<label>Resource Type</label>

<select name="resourceType" required>

<option value="Notes" <%=resourceType.equals("Notes")?"selected":""%>>

Notes

</option>

<option value="PYQ" <%=resourceType.equals("PYQ")?"selected":""%>>

PYQ

</option>

<option value="Interview Experience"

<%=resourceType.equals("Interview Experience")?"selected":""%>>

Interview Experience

</option>

<option value="Video"

<%=resourceType.equals("Video")?"selected":""%>>

Video

</option>

</select>

</div>

<div>

<label>Company Name</label>

<input
type="text"
name="company"
value="<%=companyName==null?"":companyName%>">

</div>

</div>

<label>Description</label>

<textarea
name="description"><%=description==null?"":description%></textarea>

<label>Video Link (Only for Video Resources)</label>

<input
type="text"
name="videoLink"
value="<%=videoLink==null?"":videoLink%>">

<button
type="submit"
class="btn">

<i class="fa-solid fa-floppy-disk"></i>

Update Material

</button>

<a
href="manageMaterials.jsp"
class="btn back">

<i class="fa-solid fa-arrow-left"></i>

Back

</a>
</form>

</div>

</div>

</body>

</html>

<%

}catch(Exception e){

error=e.getMessage();

out.println("<h2 style='color:red;text-align:center;'>");
out.println(error);
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