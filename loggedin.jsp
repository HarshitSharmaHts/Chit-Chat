<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.text.*" errorPage=""%>
<html>
  <%
    String loginid = request.getParameter("loginid");
    String pwd = request.getParameter("password");
    String type = (String)request.getParameter("type");

    boolean flag=false;

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/chat","root","root");
    Statement stmt = conn.createStatement();
    String query = "SELECT * FROM LOGIN WHERE LOGINID='"+loginid+"' AND type='Admin'";

    ResultSet rs = stmt.executeQuery(query);

    while(rs.next())
    {
      String pass = rs.getString(3);

      if(pass.equals(pwd))
      {
        flag=true;
        break;
      }
    }
    if(flag)
    {
      session.setAttribute("login",rs.getString(1));
      session.setAttribute("type",rs.getString(5));
      session.setAttribute("user",rs.getString(2));
      session.setAttribute("loginid",rs.getString(1));
  %>
  <head>
    <title></title>

    <link rel="stylesheet" href="css/default.css">
  	<link rel="stylesheet" href="css/main.css">
  	<link rel="stylesheet" href="css/fonts.css">
  	<link rel="shortcut icon" href="favicon.ico" >
  </head>
  <body>
      <%@ include file="menu.jsp"%>
      <hr>
      <div class="banner-text" align="center">
        <h1 class="sub-heading">Welcome!<%=session.getAttribute("user")%></h1>
      </div>
      <div  align="center">
        <%
          if("Admin".equals(type))
          {
        %>

        <a href="adduser.jsp"><button class="lg-btn">Add Users</button></a>
        <a href="viewuser.jsp"><button class="lg-btn">View Users</button></a>
        <a href="AdminChatServlet"><button class="lg-btn">Configure Rooms</button></a>
        <a href="logout.jsp"><button class="lg-btn">Logoff</button></a>
        <%
          }
          else
          {
        %>
        <button class="lg-btn" href="RoomListServlet">Select Chat Room</button><br>
        <button class="lg-btn" href="logout.jsp">Logoff</button><br>
        <%
          }
        %>
      </div>
  </body>
</html>

  <%
    }
    else
    {

      RequestDispatcher rd = request.getRequestDispatcher("loginfailure.jsp");
      rd.forward(request,response);
    }
  %>
</html>
