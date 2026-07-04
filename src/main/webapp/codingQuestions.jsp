<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){
    response.sendRedirect("studentLogin.jsp");
    return;
}

int userId=(Integer)session.getAttribute("user_id");
int categoryId=Integer.parseInt(request.getParameter("category_id"));

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

String categoryName="";

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

PreparedStatement psCategory=con.prepareStatement(
"SELECT category_name FROM coding_categories WHERE category_id=?");

psCategory.setInt(1,categoryId);

ResultSet rsCategory=psCategory.executeQuery();

if(rsCategory.next()){

categoryName=rsCategory.getString("category_name");

}

rsCategory.close();
psCategory.close();

String sql=

"SELECT q.question_id,q.title,q.difficulty,q.company_name,"+

"(SELECT COUNT(*) FROM coding_submissions s "+

"WHERE s.question_id=q.question_id "+

"AND s.user_id=?) solved "+

"FROM coding_questions q "+

"WHERE q.category_id=? "+

"ORDER BY FIELD(q.difficulty,'Easy','Medium','Hard'),q.question_id";

ps=con.prepareStatement(sql);

ps.setInt(1,userId);

ps.setInt(2,categoryId);

rs=ps.executeQuery();

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Coding Questions</title>

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

background:#2563eb;

padding:30px 50px;

display:flex;

justify-content:space-between;

align-items:center;

color:white;

}

.back{

background:white;

color:#2563eb;

padding:12px 24px;

border-radius:10px;

text-decoration:none;

font-weight:600;

}

.container{

width:1200px;

margin:40px auto;

}

.search{

display:flex;

gap:20px;

margin-bottom:30px;

}

.search input{

flex:1;

padding:15px;

border:none;

border-radius:12px;

font-size:15px;

outline:none;

}

.search select{

width:220px;

padding:15px;

border:none;

border-radius:12px;

font-size:15px;

outline:none;

}

.table{

background:white;

border-radius:18px;

overflow:hidden;

box-shadow:0 15px 35px rgba(0,0,0,.08);

}

table{

width:100%;

border-collapse:collapse;

}

th{

background:#2563eb;

color:white;

padding:18px;

}

td{

padding:18px;

border-bottom:1px solid #eee;

}

tr:hover{

background:#f8fafc;

}

.badge{

padding:7px 14px;

border-radius:20px;

font-size:13px;

font-weight:600;

color:white;

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

.solve{

background:#2563eb;

color:white;

padding:10px 20px;

border-radius:8px;

text-decoration:none;

font-weight:600;

}

.solve:hover{

background:#1d4ed8;

}

.solved{

color:#16a34a;

font-weight:600;

}

.unsolved{

color:#dc2626;

font-weight:600;

}

</style>

</head>

<body>

<div class="header">

<div>

<h1><%=categoryName%></h1>

<p>Choose a coding problem</p>

</div>

<a href="codingInstructions.jsp?category_id=<%=categoryId%>" class="back">

<i class="fa-solid fa-arrow-left"></i>

Back

</a>

</div>

<div class="container">

<div class="search">

<input
type="text"
id="searchBox"
placeholder="Search Coding Problem...">

<select id="difficultyFilter">

<option value="">All Difficulty</option>

<option value="Easy">Easy</option>

<option value="Medium">Medium</option>

<option value="Hard">Hard</option>

</select>

</div>

<div class="table">

<table>

<tr>

<th>#</th>

<th>Problem</th>

<th>Difficulty</th>

<th>Company</th>

<th>Status</th>

<th>Action</th>

</tr>
<%
int i=1;

while(rs.next()){

String difficulty=rs.getString("difficulty");

String badgeClass="easy";

if("Medium".equalsIgnoreCase(difficulty)){

badgeClass="medium";

}else if("Hard".equalsIgnoreCase(difficulty)){

badgeClass="hard";

}

boolean solved=rs.getInt("solved")>0;

%>

<tr class="questionRow"
    data-title="<%=rs.getString("title").toLowerCase()%>"
    data-difficulty="<%=difficulty%>">

<td>

<%=i++%>

</td>

<td>

<b><%=rs.getString("title")%></b>

</td>

<td>

<span class="badge <%=badgeClass%>">

<%=difficulty%>

</span>

</td>

<td>

<%=rs.getString("company_name")%>

</td>

<td>

<%

if(solved){

%>

<span class="solved">

<i class="fa-solid fa-circle-check"></i>

Solved

</span>

<%

}else{

%>

<span class="unsolved">

<i class="fa-solid fa-circle-xmark"></i>

Unsolved

</span>

<%

}

%>

</td>

<td>

<a class="solve"

href="codingProblem.jsp?question_id=<%=rs.getInt("question_id")%>">

<i class="fa-solid fa-code"></i>

Solve

</a>

</td>

</tr>

<%

}

%>

</table>

</div>

<script>

const search=document.getElementById("searchBox");

const filter=document.getElementById("difficultyFilter");

function applyFilter(){

let keyword=search.value.toLowerCase();

let difficulty=filter.value;

let rows=document.querySelectorAll(".questionRow");

rows.forEach(function(row){

let title=row.dataset.title;

let diff=row.dataset.difficulty;

let show=true;

if(keyword!="" && !title.includes(keyword))

show=false;

if(difficulty!="" && diff!=difficulty)

show=false;

row.style.display=show?"":"none";

});

}

search.addEventListener("keyup",applyFilter);

filter.addEventListener("change",applyFilter);

</script>
</div>

<div style="text-align:center;margin:50px 0;color:#6b7280;">

<h2 style="color:#111827;margin-bottom:10px;">

Placement Preparation Portal

</h2>

<p>

Practice coding consistently to improve your problem-solving skills and prepare for technical interviews.

</p>

</div>

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