<%@ page import="java.sql.*" %>

<%

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

PreparedStatement ps=
con.prepareStatement(

"insert into questions(category_id,question_text,option_a,option_b,option_c,option_d,correct_answer,difficulty) values(?,?,?,?,?,?,?,'Easy')"

);

ps.setString(1,request.getParameter("category_id"));
ps.setString(2,request.getParameter("question"));
ps.setString(3,request.getParameter("a"));
ps.setString(4,request.getParameter("b"));
ps.setString(5,request.getParameter("c"));
ps.setString(6,request.getParameter("d"));
ps.setString(7,request.getParameter("answer"));

ps.executeUpdate();

response.sendRedirect("viewQuestions.jsp");

%>