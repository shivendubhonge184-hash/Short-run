<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){
    response.sendRedirect("studentLogin.jsp");
    return;
}

int questionId=Integer.parseInt(request.getParameter("question_id"));

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

String title="";
String statement="";
String inputFormat="";
String outputFormat="";
String constraints="";
String sampleInput="";
String sampleOutput="";
String difficulty="";
String company="";
String sampleSolution="";

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

ps=con.prepareStatement(

"SELECT * FROM coding_questions WHERE question_id=?"

);

ps.setInt(1,questionId);

rs=ps.executeQuery();

if(rs.next()){

title=rs.getString("title");

statement=rs.getString("problem_statement");

inputFormat=rs.getString("input_format");

outputFormat=rs.getString("output_format");

constraints=rs.getString("constraints");

sampleInput=rs.getString("sample_input");

sampleOutput=rs.getString("sample_output");

difficulty=rs.getString("difficulty");

company=rs.getString("company_name");

sampleSolution=rs.getString("sample_solution");

}else{

out.println("Question not found.");

return;

}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title><%=title%></title>

<link rel="preconnect" href="https://fonts.googleapis.com">

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

height:80px;

background:#2563eb;

display:flex;

justify-content:space-between;

align-items:center;

padding:0 40px;

color:white;

}

.back{

background:white;

color:#2563eb;

padding:10px 22px;

border-radius:10px;

text-decoration:none;

font-weight:600;

}

.container{

width:95%;

margin:30px auto;

display:grid;

grid-template-columns:1.1fr 1fr;

gap:25px;

}

.left{

background:white;

border-radius:18px;

padding:35px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}

.right{

background:white;

border-radius:18px;

padding:30px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}

.badge{

display:inline-block;

padding:7px 16px;

border-radius:20px;

color:white;

font-size:13px;

margin-bottom:20px;

}

.easy{

background:#16a34a;

}

.medium{

background:#f59e0b;

}

.hard{

background:#dc2626;

}

.section{

margin-top:25px;

}

.section h3{

margin-bottom:12px;

color:#2563eb;

}

pre{

background:#f8fafc;

padding:18px;

border-radius:10px;

white-space:pre-wrap;

font-size:14px;

}

textarea{

width:100%;

height:500px;

padding:18px;

font-family:Consolas;

font-size:15px;

border:1px solid #ddd;

border-radius:10px;

resize:none;

outline:none;

}

select{

width:100%;

padding:14px;

margin-bottom:18px;

border-radius:10px;

border:1px solid #ddd;

}

.btn{

width:100%;

padding:16px;

border:none;

border-radius:10px;

color:white;

font-size:16px;

font-weight:600;

cursor:pointer;

margin-top:15px;

}

.submit{

background:#2563eb;

}

.solution{

background:#16a34a;

}

</style>

</head>

<body>

<div class="header">

<div>

<h2><%=title%></h2>

<p><%=company%></p>

</div>

<a href="javascript:history.back()" class="back">

<i class="fa-solid fa-arrow-left"></i>

Back

</a>

</div>

<div class="container">

<div class="left">

<%

String badge="easy";

if(difficulty.equals("Medium"))

badge="medium";

else if(difficulty.equals("Hard"))

badge="hard";

%>

<span class="badge <%=badge%>">

<%=difficulty%>

</span>

<h2>

<%=title%>

</h2>

<p style="margin-top:20px;line-height:30px;">

<%=statement%>

</p>
<div class="section">

<h3>

<i class="fa-solid fa-arrow-right-to-bracket"></i>

Input Format

</h3>

<pre><%=inputFormat%></pre>

</div>

<div class="section">

<h3>

<i class="fa-solid fa-arrow-right-from-bracket"></i>

Output Format

</h3>

<pre><%=outputFormat%></pre>

</div>

<div class="section">

<h3>

<i class="fa-solid fa-triangle-exclamation"></i>

Constraints

</h3>

<pre><%=constraints%></pre>

</div>

<div class="section">

<h3>

<i class="fa-solid fa-keyboard"></i>

Sample Input

</h3>

<pre><%=sampleInput%></pre>

</div>

<div class="section">

<h3>

<i class="fa-solid fa-display"></i>

Sample Output

</h3>

<pre><%=sampleOutput%></pre>

</div>

</div>

<div class="right">

<form action="submitCode.jsp" method="post">

<input
type="hidden"
name="question_id"
value="<%=questionId%>">

<h2 style="margin-bottom:20px;">

Code Editor

</h2>

<select name="language">

<option value="Java">Java</option>

<option value="C">C</option>

<option value="C++">C++</option>

<option value="Python">Python</option>

</select>

<textarea
name="submitted_code"
placeholder="Write your solution here...">

</textarea>

<button
type="submit"
class="btn submit">

<i class="fa-solid fa-paper-plane"></i>

Submit Code

</button>

<button
type="button"
class="btn solution"
onclick="toggleSolution()">

<i class="fa-solid fa-lightbulb"></i>

View Sample Solution

</button>

<div
id="solutionBox"
style="display:none;margin-top:25px;">

<h3>

Sample Solution

</h3>

<pre>

<%=sampleSolution%>

</pre>

</div>

</form>

</div>

</div>

<script>

function toggleSolution(){

var box=document.getElementById("solutionBox");

if(box.style.display=="none"){

box.style.display="block";

}else{

box.style.display="none";

}

}

</script>
</body>

</html>

<%

}catch(Exception e){

out.println("<div style='width:900px;margin:80px auto;background:white;padding:30px;border-radius:15px;'>");

out.println("<h2 style='color:red;'>Error</h2>");

out.println("<p>"+e.getMessage()+"</p>");

out.println("</div>");

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