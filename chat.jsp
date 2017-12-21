<%@ page language="java" import="java.util.*, java.text.*" errorPage="" %>
<%
if(session.getAttribute("login")==null)
{
  session.setAttribute("login","no");
}
%>
<html>
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
        <h1>Welcome!</h1>
      </div>
      <div  align="center">
        <%
          DateFormat df = new SimpleDateFormat("EEEE, dd MMMM, YYYY");
          String date=df.format(new Date());
          out.println(date+"&nbsp;&nbsp;<br>");
          String login = (String)session.getAttribute("login");
          if("no".equals(login))
            out.println("Click for <a href='/chat/login.jsp?type=User'>Login</a>");
          else
            out.println("Hello <font color=yellow>"+(String)session.getAttribute("user")+".<br><a href=logout.jsp>Logout</a></font>");

          if("Admin".equals(session.getAttribute("type")))
          {
            out.println("<br><br><a href='adduser.jsp'>Click for Admin Console</a>");
          }
          else
          {
            out.println("<br><br><a href='RoomListServlet'>Click for User Console</a>");
          }
        %>
      </div>
  </body>
</html>
