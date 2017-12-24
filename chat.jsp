<%
  String type = "";
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
<%
  String p = (String)request.getParameter("p");
  if(p == null)
  {
    p="";
  }
%>
    <div class="top-content">
      <div class="inner-bg">
        <div>
          <h1><a class="lgnsgp" href="Chat"><strong>Login</a> | <a class="lgnsgp" href="Chat?p=SignUp">SignUp</strong></a></h1>
        </div>
          <div class="container">
            <div class="row">
              <div class="col-md-4"></div>
<%
if(p.equals("SignUp"))
{
%>
              <div class="col-md-4 tabs">
                <div class="form-box">
                  <div class="form-top">
                    <div class="form-top-left">
                      <h3>Sign up now</h3>
                      <p>Fill in the form below to get instant access:</p>
                    </div>
                    <div class="form-top-right">
                      <i class="fa fa-pencil"></i>
                    </div>
                  </div>
                <div class="form-bottom">
                  <form role="form" action="adduser.jsp" method="POST" class="registration-form">
                    <div class="form-group">
                      <label class="sr-only" for="form-first-name">Full Name</label>
                      <input type="text" name="name" placeholder="Full Name" class="form-first-name form-control" id="form-first-name">
                    </div>
                    <div class="form-group">
                      <label class="sr-only" for="form-last-name">Username</label>
                      <input type="text" name="loginid" placeholder="UserName" class="form-last-name form-control" id="form-last-name">
                    </div>
                    <div class="form-group">
                      <label class="sr-only" for="form-email">Email</label>
                      <input type="text" name="email" placeholder="Email" class="form-email form-control" id="form-email">
                    </div>
                    <div class="form-group">
                      <label class="sr-only" for="form-password">Password</label>
                      <input type="password" name="password" placeholder="Password" class="form-about-yourself form-control" id="form-about-yourself">
                    </div>
                    <input type="hidden" name="type" value="User">
                    <button type="submit" class="btn">Sign me up!</button>
                  </form>
                </div>
                </div>
              </div>
<%
}
else
{
%>
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
                    <form role="form"  action="User" method="POST" class="login-form">
                      <div class="form-group">
                        <label class="sr-only" for="form-username">Username</label>
                        <input type="text" name="loginid" placeholder="Username/e-mail" class="form-username form-control">
                      </div>
                      <div class="form-group">
                        <label class="sr-only" for="form-password">Password</label>
                        <input type="password" name="password" placeholder="password" class="form-password form-control">
                        <input type="hidden" name="type" value="User">
                      </div>
                      <button type="submit" class="btn">Sign in!</button>
                    </form>
                  </div>
                </div>
              </div>
            <%}%>
            <div class="col-md-4"></div>
            </div>
          </div>
      </div>
    </div>

    <footer>
    	<div class="container">
    		<div class="row">

    		</div>
    	</div>
    </footer>
  </body>
</html>
