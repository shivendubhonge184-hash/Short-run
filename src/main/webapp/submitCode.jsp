<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id")==null){

    response.sendRedirect("studentLogin.jsp");
    return;

}

int userId=(Integer)session.getAttribute("user_id");

int questionId=Integer.parseInt(request.getParameter("question_id"));

String language=request.getParameter("language");

String code=request.getParameter("submitted_code");

if(code==null)
code="";

Connection con=null;
PreparedStatement ps=null;

String status="Submitted";

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");
// ---------- SAVE SUBMISSION ----------

ps=con.prepareStatement(

"INSERT INTO coding_submissions(user_id,question_id,submitted_code,language,status) VALUES(?,?,?,?,?)"

);

ps.setInt(1,userId);

ps.setInt(2,questionId);

ps.setString(3,code);

ps.setString(4,language);

if(code.trim().isEmpty()){

    status="Not Submitted";

}else{

    status="Submitted";

}

ps.setString(5,status);

ps.executeUpdate();

ps.close();


// ---------- GET CATEGORY ----------

PreparedStatement psCategory=

con.prepareStatement(

"SELECT category_id FROM coding_questions WHERE question_id=?"

);

psCategory.setInt(1,questionId);

ResultSet rsCategory=

psCategory.executeQuery();

int categoryId=0;

if(rsCategory.next()){

    categoryId=rsCategory.getInt("category_id");

}

rsCategory.close();

psCategory.close();


// ---------- UPDATE CODING ATTEMPTS ----------

PreparedStatement check=

con.prepareStatement(

"SELECT attempt_id,total_questions,solved_questions,score FROM coding_attempts WHERE user_id=? AND category_id=?"

);

check.setInt(1,userId);

check.setInt(2,categoryId);

ResultSet rsCheck=check.executeQuery();

if(rsCheck.next()){

    int solved=rsCheck.getInt("solved_questions");

    int score=rsCheck.getInt("score");

    int attemptId=rsCheck.getInt("attempt_id");

    PreparedStatement update=

    con.prepareStatement(

    "UPDATE coding_attempts SET solved_questions=?,score=? WHERE attempt_id=?"

    );

    update.setInt(1,solved+1);

    update.setInt(2,score+10);

    update.setInt(3,attemptId);

    update.executeUpdate();

    update.close();

}else{

    PreparedStatement totalPs=

    con.prepareStatement(

    "SELECT COUNT(*) FROM coding_questions WHERE category_id=?"

    );

    totalPs.setInt(1,categoryId);

    ResultSet totalRs=totalPs.executeQuery();

    int totalQuestions=0;

    if(totalRs.next()){

        totalQuestions=totalRs.getInt(1);

    }

    totalRs.close();

    totalPs.close();

    PreparedStatement insert=

    con.prepareStatement(

    "INSERT INTO coding_attempts(user_id,category_id,total_questions,solved_questions,score) VALUES(?,?,?,?,?)"

    );

    insert.setInt(1,userId);

    insert.setInt(2,categoryId);

    insert.setInt(3,totalQuestions);

    insert.setInt(4,1);

    insert.setInt(5,10);

    insert.executeUpdate();

    insert.close();

}

rsCheck.close();

check.close();


// ---------- STORE RESULT ----------

session.setAttribute("coding_status",status);

session.setAttribute("coding_language",language);

session.setAttribute("coding_question",questionId);

session.setAttribute("coding_score",10);
// ---------- REDIRECT ----------

response.sendRedirect("codingResult.jsp");

return;

}catch(Exception e){

out.println("<div style='width:900px;margin:80px auto;background:white;padding:30px;border-radius:15px;'>");

out.println("<h2 style='color:red;'>Error while submitting code</h2>");

out.println("<p>"+e.getMessage()+"</p>");

out.println("</div>");

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