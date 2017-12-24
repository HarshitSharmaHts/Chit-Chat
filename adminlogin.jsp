<%@ page language="java" import="java.util.*, java.text.*" errorPage="" %>

    <%
      String type = (String)request.getParameter("type");
      if(type!=null && type.equals("User"))
      {
        response.sendRedirect("/chat/adminlogin.jsp?type=Admin");
      }
    %>
<html lang="en">
  <head>
    <title>Chit-Chat</title>

    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
  </head>
  <body>
    <div class="top-content">
      <div class="inner-bg">
        <div class="container">
          <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
              <div class="form-box">
                <div class="form-top">
                  <div class="form-top-left">
                    <h3>Login to our site</h3>
                    <p>Enter username and password to log on:</p>
                  </div>
                  <div class="form-top-right">
                    <i class="fa fa-lock"></i>
                  </div>
                </div>
                <div class="form-bottom">
                  <form role="form"  action="loggedin.jsp" method="POST" class="login-form">
                    <div class="form-group">
                      <label class="sr-only" for="form-username">Username</label>
                      <input type="text" name="loginid" placeholder="Username/e-mail" class="form-username form-control">
                    </div>
                    <div class="form-group">
                      <label class="sr-only" for="form-password">Password</label>
                      <input type="password" name="password" placeholder="password" class="form-password form-control">
                      <input type="hidden" name="type" value="<%=type%>">
                    </div>
                    <button type="submit" class="btn">Sign in!</button>
                  </form>
                </div>
              </div>
            </div>
            <div class="col-md-4"></div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
