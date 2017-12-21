<%@ page language="java" import="java.sql.*, java.io.*" errorPage=""%>
<%
  String [] loginids = request.getParameterValues("loginid");
  if(loginids!=null)
  {
    try
    {
      Class.forName("com.mysql.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/chat","root","root");
      String query = "DELETE FROM LOGIN WHERE loginid=?";
      PreparedStatement ps = con.prepareStatement(query);

      for(String var : loginids)
      {
        ps.setString(1,var);
        ps.executeUpdate();
      }
      ps.close();
      con.close();
      response.sendRedirect("/chat/loggedin.jsp?reqPage=viewUser");
    }
    catch(Exception e)
    {
      out.println("<h2 class=\"heading\">Sorry Some Unexpected error has occured.</h2><h1>:(</h1>");
    }
  }
  else
  {
    response.sendRedirect("/chat/loggedin.jsp?reqPage=viewUser");
  }
%>
