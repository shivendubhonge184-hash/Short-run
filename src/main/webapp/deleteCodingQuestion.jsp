<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("admin")==null){

response.sendRedirect("adminLogin.jsp");

return;

}

Connection con=null;
PreparedStatement ps=null;

try{

String id=request.getParameter("id");

if(id==null || id.trim().equals("")){

response.sendRedirect("manageCodingQuestions.jsp");

return;

}

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006"

);

ps=con.prepareStatement(

"DELETE FROM coding_questions WHERE question_id=?"

);

ps.setInt(1,Integer.parseInt(id));

ps.executeUpdate();

response.sendRedirect("manageCodingQuestions.jsp");

return;

}catch(Exception e){

out.println("<h2 style='color:red;text-align:center;'>");
out.println(e.getMessage());
out.println("</h2>");

e.printStackTrace();

}finally{

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