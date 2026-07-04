<%@ page import="java.sql.*" %>

<%
String email=request.getParameter("email");
String password=request.getParameter("password");

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

PreparedStatement ps=
con.prepareStatement(
"select * from users where email=? and password=?");

ps.setString(1,email);
ps.setString(2,password);

ResultSet rs=ps.executeQuery();

if(rs.next()){

session.setAttribute(
"user_id",
rs.getInt("user_id"));

session.setAttribute(
"username",
rs.getString("full_name"));

response.sendRedirect("dashboard.jsp");

}else{
%>

<script>
alert("Invalid Email or Password");
window.location="studentLogin.jsp";
</script>

<%
}

con.close();

}catch(Exception e){

out.println(e);

}
%>