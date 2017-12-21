<%@ page language="java" import="java.util.*, java.text.*" errorPage="" %>

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
        <a href="adduser.jsp"><button class="lg-btn">Add Users</button></a>
        <a href="viewuser.jsp"><button class="lg-btn">View Users</button></a>
        <a href="AdminChatServlet"><button class="lg-btn">Configure Rooms</button></a>
        <a href="logout.jsp"><button class="lg-btn">Logoff</button></a>
      </div>
      <div  align="center">
        <form class="login-form" action="loggedin.jsp" method="POST">
          <input type="text" name="name" placeholder="User's Name">
          <input type="text" name="email" placeholder="User's Email">
          <input type="text" name="loginid" placeholder="UserName">
          <input type="password" name="password" placeholder="Password">
          <select name="type">
            <option value="Admin">Admin</option>
            <option value=User>User</option>
          </select>
          <button type="submit" name="submit" style="float=left;">Submit</button>
          <button type="reset" name="reset" value="reset">Reset</button>
        </form>
      </div>
  </body>
</html>
