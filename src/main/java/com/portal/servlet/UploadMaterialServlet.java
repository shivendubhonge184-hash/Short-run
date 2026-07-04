package com.portal.servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/UploadMaterialServlet")
@MultipartConfig(
fileSizeThreshold=1024*1024,
maxFileSize=1024*1024*20,
maxRequestSize=1024*1024*50
)

public class UploadMaterialServlet extends HttpServlet{

private static final long serialVersionUID=1L;

protected void doPost(HttpServletRequest request,
HttpServletResponse response)
throws ServletException,IOException{

HttpSession session=request.getSession();

if(session.getAttribute("admin")==null){

response.sendRedirect("adminLogin.jsp");

return;

}

int userId=1;

String title=request.getParameter("title");

String subject=request.getParameter("subject");
String resourceType=request.getParameter("resourceType");

String companyName=request.getParameter("company");

String videoLink=request.getParameter("videoLink");

String description=request.getParameter("description");

Part filePart=request.getPart("studyFile");

String fileName=

Paths.get(filePart.getSubmittedFileName())

.getFileName()

.toString();

Connection con=null;

PreparedStatement ps=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/aptitude",

"root",

"28072006");
//Upload folder inside webapp
String uploadPath=getServletContext().getRealPath("")+File.separator+"uploads";

File uploadDir=new File(uploadPath);

if(!uploadDir.exists()){

	uploadDir.mkdirs();

}

//Save uploaded file

String filePath=uploadPath+File.separator+fileName;

filePart.write(filePath);

//Save in database

ps=con.prepareStatement(

"INSERT INTO study_materials(title,subject,resource_type,company_name,description,file_name,file_path,video_link,uploaded_by) VALUES(?,?,?,?,?,?,?,?,?)"

);

ps.setString(1,title);

ps.setString(2,subject);

ps.setString(3,resourceType);

ps.setString(4,companyName);

ps.setString(5,description);

ps.setString(6,fileName);

ps.setString(7,"uploads/"+fileName);

ps.setString(8,videoLink);

ps.setInt(9,userId);

ps.executeUpdate();



//Redirect

response.sendRedirect("studyMaterial.jsp");

}catch(Exception e){

e.printStackTrace();

response.getWriter().println(

"<h2>Upload Failed!</h2><br>"+e.getMessage()

);

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

}

}