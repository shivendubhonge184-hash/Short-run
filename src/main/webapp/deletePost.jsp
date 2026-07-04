<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){

    response.sendRedirect("studentLogin.jsp");

    return;

}

int userId=(Integer)session.getAttribute("user_id");

String post=request.getParameter("post_id");

if(post==null){

    response.sendRedirect("community.jsp");

    return;

}

int postId=Integer.parseInt(post);

Connection con=null;

PreparedStatement ps=null;

try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    con=DriverManager.getConnection(

    "jdbc:mysql://localhost:3306/aptitude",

    "root",

    "28072006"

    );

    //Delete only if the post belongs to the logged-in user

    ps=con.prepareStatement(

    "DELETE FROM discussion_posts WHERE post_id=? AND user_id=?"

    );

    ps.setInt(1,postId);

    ps.setInt(2,userId);

    ps.executeUpdate();

    response.sendRedirect("community.jsp");

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