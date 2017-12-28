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
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
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
        <div class="container">
            <div class="row">
                <div class="col-md-4"></div>
                <%
                    if(p.equals("SignUp"))
                    {
                    %>
                <div class="col-md-4 tabs">
                    <h1><a class="lgnsgp" href="Index"><strong>Login</a><a class="lgnsgp" href="Index?p=SignUp">SignUp</strong></a></h1>
                    <hr>
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
                                    <label class="sr-only" for="full-name">Full Name</label>
                                    <input type="text" name="name" placeholder="Full Name" class="form-first-name form-control">
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="loginid">Username</label>
                                    <input type="text" name="loginid" placeholder="UserName" class="loginid form-control">
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="form-email">Email</label>
                                    <input type="text" name="email" placeholder="Email" class="form-email form-control">
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="password">Password</label>
                                    <input type="password" name="password" placeholder="Password" class="password form-control">
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
                    <h1><a class="lgnsgp" href="Index"><strong>Login</a><a class="lgnsgp" href="Index?p=SignUp">SignUp</strong></a></h1>
                    <hr>
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
                                    <label class="sr-only" for="username">Username</label>
                                    <input type="text" name="loginid" placeholder="Username/e-mail" class="username form-control">
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="password">Password</label>
                                    <input type="password" name="password" placeholder="password" class="password form-control">
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
        <footer>
            <div class="container">
                <div class="row">
                </div>
            </div>
        </footer>
    </body>
</html>
