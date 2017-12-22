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

  	<link rel="stylesheet" href="css/main.css">
  	<link rel="stylesheet" href="css/fonts.css">
  	<link rel="shortcut icon" href="favicon.ico" >
  </head>
  <body>

<header>
	<nav>
		<div class="main-wrapper">
			<ul>
  				<li><a href="MainChatServlet">Home</a></li>
  			</ul>
  			<div class="nav-login">
  				<%
  					if (!session.getAttribute("login").equals("no")) {
          %>
          <%
            if("Admin".equals(type))
            {
          %>
          <a href="loggedin.jsp?reqPage=addAdmin">Add Admin</a>
          <a href="loggedin.jsp?reqPage=viewUser">View Users</a>
          <a href="AdminChatServlet">Configure Rooms</a>
          <%
            }
            else if("User".equals(type))
            {
          %>
          <a href="RoomListServlet">SelectChatRoom</a>
          <%
            }
          %>
          <form action="logout.jsp" method="POST">
  					<button type="submit" name="submit">Logout</button>
  				</form>
  				<%
          } else {
  				%>
          <form action="loggedin.jsp" method="POST">
  					<input type="text" name="loginid" placeholder="Username/e-mail">
  					<input type="password" name="password" placeholder="password">
            <input type="hidden" name="type" value="User">
  					<button type="submit" name="submit">Login</button>
  				</form>
  				<%
            }
  				%>
  			</div>
  		</div>
  	</nav>
  </header>
