<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
if(session.getAttribute("user_id")==null){

response.sendRedirect("studentLogin.jsp");

return;

}

int materialId=Integer.parseInt(request.getParameter("material_id"));

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006");

ps=con.prepareStatement(

"SELECT file_name,file_path FROM study_materials WHERE material_id=?"

);

ps.setInt(1,materialId);

rs=ps.executeQuery();

if(rs.next()){

String fileName=rs.getString("file_name");

String filePath=rs.getString("file_path");

String absolutePath=

application.getRealPath("/")+filePath;

File file=new File(absolutePath);

if(file.exists()){

response.reset();

response.setContentType("application/pdf");

response.setHeader(

"Content-Disposition",

"attachment; filename=\""+fileName+"\""

);

response.setContentLengthLong(file.length());

FileInputStream fis=

new FileInputStream(file);

OutputStream os=

response.getOutputStream();
byte[] buffer=new byte[4096];

int bytesRead;

while((bytesRead=fis.read(buffer))!=-1){

os.write(buffer,0,bytesRead);

}

fis.close();

os.flush();

os.close();

}else{

%>

<!DOCTYPE html>

<html>

<head>

<title>File Not Found</title>

<style>

body{

font-family:Arial;

background:#eef2ff;

display:flex;

justify-content:center;

align-items:center;

height:100vh;

}

.box{

background:white;

padding:40px;

border-radius:15px;

text-align:center;

box-shadow:0 10px 30px rgba(0,0,0,.08);

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

<h2>File Not Found</h2>

<p>

The requested PDF is not available on the server.

</p>

<a href="studyMaterial.jsp">

Back to Study Material

</a>

</div>

</body>

</html>

<%

}

}else{

out.println("<h2>Invalid Material.</h2>");

}

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