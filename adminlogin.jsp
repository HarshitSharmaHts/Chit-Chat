<%@ page language="java" import="java.util.*, java.text.*" errorPage="" %>

<html>
  <head>
    <title></title>
    <%
      String type = (String)request.getParameter("type");
      if(type!=null && type.equals("User"))
      {
        response.sendRedirect("/chat/adminlogin.jsp?type=Admin");
      }
    %>

    <link rel="stylesheet" href="css/default.css">
  	<link rel="stylesheet" href="css/main.css">
  	<link rel="stylesheet" href="css/fonts.css">
  	<link rel="shortcut icon" href="favicon.ico" >

  </head>
  <body>
      <%@ include file="menu.jsp"%>
      <section class="main-container">
      	<div class="main-wrapper signup-wrapper">
      		<h2>Admin Login</h2>
        <div class="form-div">
          <form class="signup-form" action="loggedin.jsp" method="POST">
  					<input type="text" name="loginid" placeholder="Username/e-mail">
  					<input type="password" name="password" placeholder="password">
            <input type="hidden" name="type" value="<%=type%>">
  					<button type="submit" name="submit">Login</button>
  				</form>
        </div>
      </div>
    </section>
    <div style="margin:0 auto;" align="center">
      <%
        DateFormat df = new SimpleDateFormat("EEEE, dd MMMM, YYYY");
        String date=df.format(new Date());
        out.println(date+"<br><br>");
      %>
    </div>
  </body>
</html>
