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
String category=request.getParameter("category");
String difficulty=request.getParameter("difficulty");

if(search==null)
search="";

if(category==null)
category="";

if(difficulty==null)
difficulty="";

int totalQuestions=0;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

//Total Questions

ps=con.prepareStatement(

"SELECT COUNT(*) FROM questions"

);

rs=ps.executeQuery();

if(rs.next()){

totalQuestions=rs.getInt(1);

}

rs.close();
ps.close();

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Manage Aptitude Questions</title>

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

grid-template-columns:2fr 1fr 1fr auto;

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

<i class="fa-solid fa-book"></i>

Manage Aptitude Questions

</h1>

<p>

View, Search and Manage Questions

</p>

</div>

<div class="container">

<div class="top">

<div class="card">

<h2><%=totalQuestions%></h2>

<p>Total Questions</p>

</div>

<a href="addQuestion.jsp" class="addBtn">

<i class="fa-solid fa-plus"></i>

Add Question

</a>

</div>

<form method="get" class="filters">

<input
type="text"
name="search"
placeholder="Search Question..."
value="<%=search%>">

<select name="category">

<option value="">All Categories</option>

<%

PreparedStatement cps=con.prepareStatement(

"SELECT * FROM categories ORDER BY category_name"

);

ResultSet crs=cps.executeQuery();

while(crs.next()){

String cname=crs.getString("category_name");

%>

<option value="<%=cname%>"

<%=category.equals(cname)?"selected":""%>>

<%=cname%>

</option>

<%

}

crs.close();

cps.close();

%>

</select>

<select name="difficulty">

<option value="">All Difficulty</option>

<option value="Easy"
<%=difficulty.equals("Easy")?"selected":""%>>

Easy

</option>

<option value="Medium"
<%=difficulty.equals("Medium")?"selected":""%>>

Medium

</option>

<option value="Hard"
<%=difficulty.equals("Hard")?"selected":""%>>

Hard

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

<th>Question</th>

<th>Category</th>

<th>Company</th>

<th>Difficulty</th>

<th>Answer</th>

<th>Actions</th>

</tr>

<%

String sql=

"SELECT q.question_id,q.question_text,q.correct_answer,q.difficulty,"+

"c.category_name,co.company_name "+

"FROM questions q "+

"LEFT JOIN categories c ON q.category_id=c.category_id "+

"LEFT JOIN companies co ON q.company_id=co.company_id "+

"WHERE 1=1 ";

if(!search.trim().equals("")){

sql+=" AND q.question_text LIKE ?";

}

if(!category.equals("")){

sql+=" AND c.category_name=?";

}

if(!difficulty.equals("")){

sql+=" AND q.difficulty=?";

}

sql+=" ORDER BY q.question_id DESC";

ps=con.prepareStatement(sql);

int i=1;

if(!search.trim().equals("")){

ps.setString(i++,"%"+search+"%");

}

if(!category.equals("")){

ps.setString(i++,category);

}

if(!difficulty.equals("")){

ps.setString(i++,difficulty);

}

rs=ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%=rs.getInt("question_id")%></td>

<td style="text-align:left;width:40%;">

<%=rs.getString("question_text")%>

</td>

<td>

<%=rs.getString("category_name")%>

</td>

<td>

<%=rs.getString("company_name")==null?"-":rs.getString("company_name")%>

</td>

<td>

<%=rs.getString("difficulty")%>

</td>

<td>

<%=rs.getString("correct_answer")%>

</td>

<td>

<a

href="editQuestion.jsp?id=<%=rs.getInt("question_id")%>"

class="action edit">

Edit

</a>

<a

href="deleteQuestion.jsp?id=<%=rs.getInt("question_id")%>"

class="action delete"

onclick="return confirm('Delete this question?');">

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