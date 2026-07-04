<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("admin")==null){

response.sendRedirect("adminLogin.jsp");

return;

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Upload Study Material</title>

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
select,
textarea{

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

input[type=file]{

width:100%;

padding:12px;

border:1px solid #d1d5db;

border-radius:10px;

margin-bottom:20px;

}

.row{

display:grid;

grid-template-columns:1fr 1fr;

gap:20px;

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

<i class="fa-solid fa-upload"></i>

Upload Study Material

</h1>

</div>

<div class="container">

<div class="form-box">

<form

action="UploadMaterialServlet"

method="post"

enctype="multipart/form-data">
<div class="row">

<div>

<label>Title</label>

<input
type="text"
name="title"
required>

</div>

<div>

<label>Subject</label>

<input
type="text"
name="subject"
required>

</div>

</div>

<div class="row">

<div>

<label>Resource Type</label>

<select name="resourceType" required>

<option value="">Select Type</option>

<option value="Notes">Notes</option>

<option value="PYQ">PYQ</option>

<option value="Interview Experience">

Interview Experience

</option>

<option value="Video">Video</option>

</select>

</div>

<div>

<label>Company Name</label>

<input
type="text"
name="company"
placeholder="Example: TCS, Infosys, Amazon">

</div>

</div>

<label>Description</label>

<textarea
name="description"
placeholder="Enter description..."
required></textarea>

<label>Video Link (Only if Resource Type is Video)</label>

<input
type="text"
name="videoLink"
placeholder="https://youtube.com/...">

<label>Select File</label>

<input
type="file"
name="studyFile">

<button
type="submit"
class="btn">

<i class="fa-solid fa-upload"></i>

Upload Material

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