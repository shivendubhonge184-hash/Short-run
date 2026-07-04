<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
if(session.getAttribute("user_id")==null){
    response.sendRedirect("studentLogin.jsp");
    return;
}

Integer userId=(Integer)session.getAttribute("user_id");
Integer categoryId=(Integer)session.getAttribute("category_id");

ArrayList<Integer> questionIds=
(ArrayList<Integer>)session.getAttribute("questionIds");

HashMap<Integer,String> answers=
(HashMap<Integer,String>)session.getAttribute("answers");

Long startTime=
(Long)session.getAttribute("quizStartTime");

if(userId==null || categoryId==null || questionIds==null || answers==null){
    response.sendRedirect("aptitude.jsp");
    return;
}

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

int totalQuestions=questionIds.size();
int correctAnswers=0;
int wrongAnswers=0;
int score=0;

long endTime=System.currentTimeMillis();

int timeTaken=(int)((endTime-startTime)/1000);

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/aptitude",
"root",
"28072006");

for(Integer qid : questionIds){

ps=con.prepareStatement(
"SELECT correct_answer FROM questions WHERE question_id=?");

ps.setInt(1,qid);

rs=ps.executeQuery();

if(rs.next()){

String correct=
rs.getString("correct_answer");

String student=
answers.get(qid);

if(student!=null && student.equalsIgnoreCase(correct)){

correctAnswers++;
score+=10;

}else{

wrongAnswers++;

}

}

if(rs!=null) rs.close();
if(ps!=null) ps.close();

}

double percentage=

((double)score/(totalQuestions*10))*100.0;

PreparedStatement save=

con.prepareStatement(

"INSERT INTO quiz_attempts(user_id,category_id,total_questions,correct_answers,wrong_answers,score,percentage,time_taken) VALUES(?,?,?,?,?,?,?,?)"

);

save.setInt(1,userId);

save.setInt(2,categoryId);

save.setInt(3,totalQuestions);

save.setInt(4,correctAnswers);

save.setInt(5,wrongAnswers);

save.setInt(6,score);

save.setDouble(7,percentage);

save.setInt(8,timeTaken);

save.executeUpdate();

save.close();

session.setAttribute("result_score",score);

session.setAttribute("result_correct",correctAnswers);

session.setAttribute("result_wrong",wrongAnswers);

session.setAttribute("result_percentage",percentage);

session.setAttribute("result_total",totalQuestions);

session.setAttribute("result_time",timeTaken);

session.removeAttribute("questionIds");
session.removeAttribute("answers");
session.removeAttribute("currentQuestion");
session.removeAttribute("quizStartTime");
session.removeAttribute("category_id");

response.sendRedirect("result.jsp");
return;

}catch(Exception e){

out.println(e);

}finally{

try{
if(rs!=null)rs.close();
}catch(Exception e){}

try{
if(ps!=null)ps.close();
}catch(Exception e){}

try{
if(con!=null)con.close();
}catch(Exception e){}

}
%>