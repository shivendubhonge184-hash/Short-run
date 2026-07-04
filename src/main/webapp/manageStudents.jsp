<%@ page import="java.sql.*" %>

<table border="1">

<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Branch</th>
</tr>

<%

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

Statement st=con.createStatement();

ResultSet rs=st.executeQuery(
"select * from users");

while(rs.next()){
%>

<tr>

<td><%=rs.getInt("user_id")%></td>
<td><%=rs.getString("full_name")%></td>
<td><%=rs.getString("email")%></td>
<td><%=rs.getString("branch")%></td>

</tr>

<% } %>

</table>