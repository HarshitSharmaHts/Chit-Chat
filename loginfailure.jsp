<%@ page language="java" import="java.util.*, java.text.*" errorPage="" %>
<%
  String type="";
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
      <div class="banner-text" align="center">
        <h1 class="heading">Login Failure</h1>
      </div>
      <div  align="center">
        <%
          DateFormat df = new SimpleDateFormat("EEEE, dd MMMM, YYYY");
          String date=df.format(new Date());
          out.println(date+"<br><br>");
          String login = (String)session.getAttribute("login");
        %>
        <div class="form-div">
          <p>Either your Login Id or Password is wrong.</p>
          <p>Please, check the type of your login.</p>
        </div>
      </div>
  </body>
</html>
