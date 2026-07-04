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

ResultSet rs=null;

try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    con=DriverManager.getConnection(

    "jdbc:mysql://localhost:3306/aptitude",

    "root",

    "28072006"

    );

    // Check if user already liked the post

    ps=con.prepareStatement(

    "SELECT * FROM post_likes WHERE post_id=? AND user_id=?"

    );

    ps.setInt(1,postId);

    ps.setInt(2,userId);

    rs=ps.executeQuery();

    if(!rs.next()){

        rs.close();

        ps.close();

        ps=con.prepareStatement(

        "INSERT INTO post_likes(post_id,user_id) VALUES(?,?)"

        );

        ps.setInt(1,postId);

        ps.setInt(2,userId);

        ps.executeUpdate();

    }

    response.sendRedirect("viewPost.jsp?post_id="+postId);

    return;

}catch(Exception e){

    out.println("<h2>"+e.getMessage()+"</h2>");

    e.printStackTrace();

}finally{

    try{

        if(rs!=null)

        rs.close();

    }catch(Exception e){}

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