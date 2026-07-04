<%@ page import="java.sql.*" %>

<%

String email=request.getParameter("email");
String password=request.getParameter("password");

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

PreparedStatement ps=
con.prepareStatement(
"select * from admin where email=? and password=?");

ps.setString(1,email);
ps.setString(2,password);

ResultSet rs=ps.executeQuery();

if(rs.next()){

session.setAttribute("admin",email);

response.sendRedirect("adminDashboard.jsp");

}else{
%>

<script>
alert("Invalid Credentials");
window.location="adminLogin.jsp";
</script>

<%
}
%>