<%@ page language="java" import="java.sql.*, java.io.*" errorPage=""%>
<%!
  public boolean isValidEmail(String str)
  {
    String [] part = str.split("@");
    if(part.length!=2)
      return false;
    return true;
  }
%>
<%
  String name = (String)request.getParameter("name");
  String email = (String)request.getParameter("email");
  String loginid = (String)request.getParameter("loginid");
  String password = (String)request.getParameter("password");
  String type = (String)request.getParameter("type");

  try
  {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/chat","root","root");
    String insquery = "INSERT INTO LOGIN VALUES (?,?,?,?,?)";
    PreparedStatement ps = con.prepareStatement(insquery);
    ps.setString(1,loginid);
    ps.setString(2,name);
    ps.setString(3,password);
    ps.setString(4,email);
    ps.setString(5,type);

    ps.executeUpdate();
    ps.close();
    con.close();
    if(type.equals("User"))
      response.sendRedirect("/chat/chat.jsp");
    else if(type.equals("Admin"))
      response.sendRedirect("/chat/loggedin.jsp?reqPage=addAdmin");

  }
  catch(Exception e)
  {
    out.println("<h2 class=\"heading\">Sorry Some Unexpected error has occured.</h2><h1>:(</h1>");
  }
%>
