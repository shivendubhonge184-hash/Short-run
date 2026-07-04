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

String company=request.getParameter("company");

Integer companyId=null;

if(company!=null && !company.equals("")){

companyId=Integer.parseInt(company);

}

String question=request.getParameter("question");

String optionA=request.getParameter("optionA");

String optionB=request.getParameter("optionB");

String optionC=request.getParameter("optionC");

String optionD=request.getParameter("optionD");

String answer=request.getParameter("answer");

String difficulty=request.getParameter("difficulty");

String sql=

"INSERT INTO questions(category_id,company_id,question_text,option_a,option_b,option_c,option_d,correct_answer,difficulty) VALUES(?,?,?,?,?,?,?,?,?)";

ps=con.prepareStatement(sql);

ps.setInt(1,categoryId);

if(companyId==null)

ps.setNull(2,java.sql.Types.INTEGER);

else

ps.setInt(2,companyId);

ps.setString(3,question);

ps.setString(4,optionA);

ps.setString(5,optionB);

ps.setString(6,optionC);

ps.setString(7,optionD);

ps.setString(8,answer);

ps.setString(9,difficulty);

ps.executeUpdate();

success="Question Added Successfully.";

ps.close();

}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Add Aptitude Question</title>

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

<i class="fa-solid fa-circle-plus"></i>

Add Aptitude Question

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

<label>Category</label>

<select name="category" required>

<option value="">Select Category</option>

<%

ps=con.prepareStatement(

"SELECT * FROM categories ORDER BY category_name"

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

<div>

<label>Company (Optional)</label>

<select name="company">

<option value="">General</option>

<%

ps=con.prepareStatement(

"SELECT * FROM companies ORDER BY company_name"

);

rs=ps.executeQuery();

while(rs.next()){

%>

<option value="<%=rs.getInt("company_id")%>">

<%=rs.getString("company_name")%>

</option>

<%

}

rs.close();

ps.close();

%>

</select>

</div>

</div>

<label>Question</label>

<textarea

name="question"

required></textarea>

<div class="row">

<div>

<label>Option A</label>

<input

type="text"

name="optionA"

required>

</div>

<div>

<label>Option B</label>

<input

type="text"

name="optionB"

required>

</div>

</div>

<div class="row">

<div>

<label>Option C</label>

<input

type="text"

name="optionC"

required>

</div>

<div>

<label>Option D</label>

<input

type="text"

name="optionD"

required>

</div>

</div>

<div class="row">

<div>

<label>Correct Answer</label>

<select name="answer" required>

<option value="">Select</option>

<option value="A">Option A</option>

<option value="B">Option B</option>

<option value="C">Option C</option>

<option value="D">Option D</option>

</select>

</div>

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

Save Question

</button>

<a

href="manageQuestions.jsp"

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