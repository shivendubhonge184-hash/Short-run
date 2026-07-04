<%@ page import="java.sql.*" %>

<%

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

PreparedStatement ps=
con.prepareStatement(
"update questions set question_text=? where question_id=?");

ps.setString(1,request.getParameter("question"));
ps.setString(2,request.getParameter("id"));

ps.executeUpdate();

response.sendRedirect("viewQuestions.jsp");

%>