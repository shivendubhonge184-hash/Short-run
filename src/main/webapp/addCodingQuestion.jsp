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

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

if("POST".equalsIgnoreCase(request.getMethod())){

int categoryId=Integer.parseInt(request.getParameter("category"));

String title=request.getParameter("title");

String company=request.getParameter("company");

String problem=request.getParameter("problem");

String input=request.getParameter("input");

String output=request.getParameter("output");

String constraints=request.getParameter("constraints");

String sampleInput=request.getParameter("sampleInput");

String sampleOutput=request.getParameter("sampleOutput");

String solution=request.getParameter("solution");

String difficulty=request.getParameter("difficulty");

ps=con.prepareStatement(

"INSERT INTO coding_questions(title,problem_statement,input_format,output_format,constraints,sample_input,sample_output,difficulty,company_name,category_id,sample_solution) VALUES(?,?,?,?,?,?,?,?,?,?,?)"

);

ps.setString(1,title);

ps.setString(2,problem);

ps.setString(3,input);

ps.setString(4,output);

ps.setString(5,constraints);

ps.setString(6,sampleInput);

ps.setString(7,sampleOutput);

ps.setString(8,difficulty);

ps.setString(9,company);

ps.setInt(10,categoryId);

ps.setString(11,solution);

ps.executeUpdate();

ps.close();

success="Coding Question Added Successfully.";

}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Add Coding Question</title>

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

<i class="fa-solid fa-code"></i>

Add Coding Question

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

<label>Question Title</label>

<input

type="text"

name="title"

required>

</div>

<div>

<label>Category</label>

<select name="category" required>

<option value="">Select Category</option>

<%

ps=con.prepareStatement(
"SELECT * FROM categories WHERE module='Coding' ORDER BY category_name"
);

rs=ps.executeQuery();

while(rs.next()){

%>

<option value="<%=rs.getInt("category_id")%>">

<%=rs.getString("category_name")%>

</option>

<%

}

rs.close();

ps.close();

%>

</select>

</div>

</div>

<label>Company Name</label>

<input

type="text"

name="company"

placeholder="Example: TCS, Infosys, Amazon">

<label>Problem Statement</label>

<textarea

name="problem"

required></textarea>

<div class="row">

<div>

<label>Input Format</label>

<textarea

name="input"

required></textarea>

</div>

<div>

<label>Output Format</label>

<textarea

name="output"

required></textarea>

</div>

</div>

<label>Constraints</label>

<textarea

name="constraints"

required></textarea>

<div class="row">

<div>

<label>Sample Input</label>

<textarea

name="sampleInput"

required></textarea>

</div>

<div>

<label>Sample Output</label>

<textarea

name="sampleOutput"

required></textarea>

</div>

</div>

<label>Sample Solution</label>

<textarea

name="solution"

required></textarea>

<div class="row">

<div>

<label>Difficulty</label>

<select name="difficulty" required>

<option value="">Select Difficulty</option>

<option value="Easy">Easy</option>

<option value="Medium">Medium</option>

<option value="Hard">Hard</option>

</select>

</div>

</div>

<button

type="submit"

class="btn">

<i class="fa-solid fa-floppy-disk"></i>

Save Coding Question

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