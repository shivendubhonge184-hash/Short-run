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
String problem="";
String inputFormat="";
String outputFormat="";
String constraints="";
String sampleInput="";
String sampleOutput="";
String solution="";
String difficulty="";
String companyName="";
int categoryId=0;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

if("POST".equalsIgnoreCase(request.getMethod())){

title=request.getParameter("title");

problem=request.getParameter("problem");

inputFormat=request.getParameter("input");

outputFormat=request.getParameter("output");

constraints=request.getParameter("constraints");

sampleInput=request.getParameter("sampleInput");

sampleOutput=request.getParameter("sampleOutput");

solution=request.getParameter("solution");

difficulty=request.getParameter("difficulty");

companyName=request.getParameter("company");

categoryId=Integer.parseInt(request.getParameter("category"));

ps=con.prepareStatement(

"UPDATE coding_questions SET title=?,problem_statement=?,input_format=?,output_format=?,constraints=?,sample_input=?,sample_output=?,difficulty=?,company_name=?,category_id=?,sample_solution=? WHERE question_id=?"

);

ps.setString(1,title);

ps.setString(2,problem);

ps.setString(3,inputFormat);

ps.setString(4,outputFormat);

ps.setString(5,constraints);

ps.setString(6,sampleInput);

ps.setString(7,sampleOutput);

ps.setString(8,difficulty);

ps.setString(9,companyName);

ps.setInt(10,categoryId);

ps.setString(11,solution);

ps.setInt(12,id);

ps.executeUpdate();

ps.close();

success="Coding Question Updated Successfully.";

}

ps=con.prepareStatement(

"SELECT * FROM coding_questions WHERE question_id=?"

);

ps.setInt(1,id);

rs=ps.executeQuery();

if(rs.next()){

title=rs.getString("title");

problem=rs.getString("problem_statement");

inputFormat=rs.getString("input_format");

outputFormat=rs.getString("output_format");

constraints=rs.getString("constraints");

sampleInput=rs.getString("sample_input");

sampleOutput=rs.getString("sample_output");

difficulty=rs.getString("difficulty");

companyName=rs.getString("company_name");

categoryId=rs.getInt("category_id");

solution=rs.getString("sample_solution");

}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Edit Coding Question</title>

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

width:950px;

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

height:120px;

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

Edit Coding Question

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

<div class="error">2

<%=error%>

</div>

<%

}

%>

<form method="post">

<div class="row">

<div>

<label>Question Title</label>

<input
type="text"
name="title"
value="<%=title%>"
required>

</div>

<div>

<label>Category</label>

<select name="category" required>

<%

PreparedStatement cps=con.prepareStatement(
"SELECT * FROM categories WHERE module='Coding' ORDER BY category_name"
);

ResultSet crs=cps.executeQuery();

while(crs.next()){

%>

<option

value="<%=crs.getInt("category_id")%>"

<%=categoryId==crs.getInt("category_id")?"selected":""%>>

<%=crs.getString("category_name")%>

</option>

<%

}

crs.close();

cps.close();

%>

</select>

</div>

</div>

<label>Company Name</label>

<input
type="text"
name="company"
value="<%=companyName==null?"":companyName%>">

<label>Problem Statement</label>

<textarea
name="problem"
required><%=problem%></textarea>

<div class="row">

<div>

<label>Input Format</label>

<textarea
name="input"
required><%=inputFormat%></textarea>

</div>

<div>

<label>Output Format</label>

<textarea
name="output"
required><%=outputFormat%></textarea>

</div>

</div>

<label>Constraints</label>

<textarea
name="constraints"
required><%=constraints%></textarea>

<div class="row">

<div>

<label>Sample Input</label>

<textarea
name="sampleInput"
required><%=sampleInput%></textarea>

</div>

<div>

<label>Sample Output</label>

<textarea
name="sampleOutput"
required><%=sampleOutput%></textarea>

</div>

</div>

<label>Sample Solution</label>

<textarea
name="solution"
required><%=solution%></textarea>

<div class="row">

<div>

<label>Difficulty</label>

<select name="difficulty" required>

<option value="Easy" <%=difficulty.equals("Easy")?"selected":""%>>Easy</option>

<option value="Medium" <%=difficulty.equals("Medium")?"selected":""%>>Medium</option>

<option value="Hard" <%=difficulty.equals("Hard")?"selected":""%>>Hard</option>

</select>

</div>

</div>

<button
type="submit"
class="btn">

<i class="fa-solid fa-floppy-disk"></i>

Update Coding Question

</button>

<a
href="manageCodingQuestions.jsp"
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