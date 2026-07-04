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

int categoryId=0;
int companyId=0;

String question="";
String optionA="";
String optionB="";
String optionC="";
String optionD="";
String answer="";
String difficulty="";

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

if("POST".equalsIgnoreCase(request.getMethod())){

categoryId=Integer.parseInt(request.getParameter("category"));

String company=request.getParameter("company");

question=request.getParameter("question");

optionA=request.getParameter("optionA");

optionB=request.getParameter("optionB");

optionC=request.getParameter("optionC");

optionD=request.getParameter("optionD");

answer=request.getParameter("answer");

difficulty=request.getParameter("difficulty");

String sql=

"UPDATE questions SET category_id=?,company_id=?,question_text=?,option_a=?,option_b=?,option_c=?,option_d=?,correct_answer=?,difficulty=? WHERE question_id=?";

ps=con.prepareStatement(sql);

ps.setInt(1,categoryId);

if(company==null || company.equals("")){

ps.setNull(2,java.sql.Types.INTEGER);

}else{

ps.setInt(2,Integer.parseInt(company));

}

ps.setString(3,question);

ps.setString(4,optionA);

ps.setString(5,optionB);

ps.setString(6,optionC);

ps.setString(7,optionD);

ps.setString(8,answer);

ps.setString(9,difficulty);

ps.setInt(10,id);

ps.executeUpdate();

ps.close();

success="Question Updated Successfully.";

}

ps=con.prepareStatement(

"SELECT * FROM questions WHERE question_id=?"

);

ps.setInt(1,id);

rs=ps.executeQuery();

if(rs.next()){

categoryId=rs.getInt("category_id");

companyId=rs.getInt("company_id");

question=rs.getString("question_text");

optionA=rs.getString("option_a");

optionB=rs.getString("option_b");

optionC=rs.getString("option_c");

optionD=rs.getString("option_d");

answer=rs.getString("correct_answer");

difficulty=rs.getString("difficulty");

}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Edit Question</title>

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

Edit Aptitude Question

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

<%

PreparedStatement cps=con.prepareStatement(

"SELECT * FROM categories ORDER BY category_name"

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

<div>

<label>Company</label>

<select name="company">

<option value="">General</option>

<%

PreparedStatement comPs=con.prepareStatement(

"SELECT * FROM companies ORDER BY company_name"

);

ResultSet comRs=comPs.executeQuery();

while(comRs.next()){

%>

<option

value="<%=comRs.getInt("company_id")%>"

<%=companyId==comRs.getInt("company_id")?"selected":""%>>

<%=comRs.getString("company_name")%>

</option>

<%

}

comRs.close();

comPs.close();

%>

</select>

</div>

</div>

<label>Question</label>

<textarea

name="question"

required><%=question%></textarea>

<div class="row">

<div>

<label>Option A</label>

<input

type="text"

name="optionA"

value="<%=optionA%>"

required>

</div>

<div>

<label>Option B</label>

<input

type="text"

name="optionB"

value="<%=optionB%>"

required>

</div>

</div>

<div class="row">

<div>

<label>Option C</label>

<input

type="text"

name="optionC"

value="<%=optionC%>"

required>

</div>

<div>

<label>Option D</label>

<input

type="text"

name="optionD"

value="<%=optionD%>"

required>

</div>

</div>

<div class="row">

<div>

<label>Correct Answer</label>

<select name="answer" required>

<option value="A" <%=answer.equals("A")?"selected":""%>>Option A</option>

<option value="B" <%=answer.equals("B")?"selected":""%>>Option B</option>

<option value="C" <%=answer.equals("C")?"selected":""%>>Option C</option>

<option value="D" <%=answer.equals("D")?"selected":""%>>Option D</option>

</select>

</div>

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

Update Question

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

out.println(

"<h2 style='color:red;text-align:center;'>"

+error+

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