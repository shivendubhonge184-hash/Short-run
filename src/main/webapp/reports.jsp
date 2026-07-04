<%@ page import="java.sql.*" %>

<table border="1">

<tr>
<th>Student</th>
<th>Score</th>
<th>Date</th>
</tr>

<%

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

Statement st=con.createStatement();

ResultSet rs=st.executeQuery(

"select u.full_name,q.score,q.attempt_date from quiz_attempts q join users u on q.user_id=u.user_id"

);

while(rs.next()){
%>

<tr>

<td><%=rs.getString(1)%></td>
<td><%=rs.getInt(2)%></td>
<td><%=rs.getString(3)%></td>

</tr>

<% } %>

</table>
