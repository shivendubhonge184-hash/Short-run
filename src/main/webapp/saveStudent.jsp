<%@ page import="java.sql.*" %>

<%
String full_name=request.getParameter("full_name");
String email=request.getParameter("email");
String password=request.getParameter("password");
String mobile=request.getParameter("mobile");
String gender=request.getParameter("gender");
String dob=request.getParameter("dob");
String college=request.getParameter("college");
String branch=request.getParameter("branch");
String study_year=request.getParameter("study_year");
String semester=request.getParameter("semester");
String cgpa=request.getParameter("cgpa");
String skills=request.getParameter("skills");
String city=request.getParameter("city");
String linkedin=request.getParameter("linkedin");
String github=request.getParameter("github");

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

PreparedStatement check=
con.prepareStatement(
"select * from users where email=?");

check.setString(1,email);

ResultSet rs=check.executeQuery();

if(rs.next()){
%>

<script>
alert("Email already registered");
window.location="register.jsp";
</script>

<%
}else{

PreparedStatement ps=con.prepareStatement(
"insert into users(username,full_name,email,password,mobile,gender,dob,college,branch,study_year,semester,cgpa,skills,city,linkedin,github) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

ps.setString(1,full_name);
ps.setString(2,full_name);
ps.setString(3,email);
ps.setString(4,password);
ps.setString(5,mobile);
ps.setString(6,gender);
ps.setString(7,dob);
ps.setString(8,college);
ps.setString(9,branch);
ps.setString(10,study_year);
ps.setString(11,semester);
ps.setString(12,cgpa);
ps.setString(13,skills);
ps.setString(14,city);
ps.setString(15,linkedin);
ps.setString(16,github);

int i=ps.executeUpdate();

if(i>0){
response.sendRedirect("studentLogin.jsp");
}

}

con.close();

}catch(Exception e){
out.println("Error : "+e);
}
%>