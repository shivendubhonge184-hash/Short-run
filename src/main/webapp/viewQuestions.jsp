<%@ page import="java.sql.*" %>

<table border="1">

<tr>
<th>ID</th>
<th>Question</th>
<th>Action</th>
</tr>

<%

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

Statement st=con.createStatement();

ResultSet rs=st.executeQuery(
"select * from questions");

while(rs.next()){
%>

<tr>

<td><%=rs.getInt("question_id")%></td>

<td><%=rs.getString("question_text")%></td>

<td>

<a href="editQuestion.jsp?id=<%=rs.getInt("question_id")%>">
Edit
</a>

|

<a href="deleteQuestion.jsp?id=<%=rs.getInt("question_id")%>">
Delete
</a>

</td>

</tr>

<% } %>

</table>