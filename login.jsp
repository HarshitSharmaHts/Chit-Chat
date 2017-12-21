<%@ page language="java" import="java.util.*, java.text.*" errorPage="" %>

<html>
  <head>
    <title></title>
    <%
      String type = (String)request.getParameter("type");
    %>

    <link rel="stylesheet" href="css/default.css">
  	<link rel="stylesheet" href="css/main.css">
  	<link rel="stylesheet" href="css/fonts.css">
  	<link rel="shortcut icon" href="favicon.ico" >

  </head>
  <body>
      <%@ include file="menu.jsp"%>
      <hr>
      <div class="banner-text" align="center">
        <h1 class="heading"><%=type%> Login</h1>
      </div>
      <div  align="center">
        <%
          DateFormat df = new SimpleDateFormat("EEEE, dd MMMM, YYYY");
          String date=df.format(new Date());
          out.println(date+"<br><br>");
        %>
        <div class="form-div">
          <p class="sub-heading">Enter Login details<hr></p>
          <form class="login-form" action="loggedin.jsp" method="POST">
            <input type="text" name="loginid" placeholder="Username">
            <input type="password" name="password" placeholder="Password">
            <input type="hidden" name="type" value="<%=type%>">
            <button type="submit" name="submit">Login</button>
          </form>
        </div>
      </div>
  </body>
</html>
