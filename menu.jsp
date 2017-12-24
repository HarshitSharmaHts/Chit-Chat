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

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/form-elements.css">
    <link rel="stylesheet" href="assets/css/style.css">
  </head>
  <body>
 <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
			<ul class="navbar-nav mr-auto">
  				<li class="nav-item">
            <a class="nav-link" href="Chat">Home</a>
          </li>
  		</ul>
  				<%
  					if (!session.getAttribute("login").equals("no")) {
          %>
          <%
            if("Admin".equals(type))
            {
          %>
          <ul class="navbar-nav mr-auto">
    				<li class="nav-item">
              <a class="nav-link" href="loggedin.jsp?reqPage=addAdmin">Add Admin</a>
            </li>
    				<li class="nav-item">
              <a class="nav-link"  href="loggedin.jsp?reqPage=viewUser">View Users</a>
            </li>
            <li class="nav-item">
              <a class="nav-link"  href="RoomController">Configure Rooms</a>
            </li>
          </ul>
          <%
            }
          %>
          <form class="form-inline right-form" action="logout.jsp" method="POST">
  					<button class="btn btn-success" type="submit" name="submit">Logout</button>
  				</form>
  			<%
        }
        %>
  	</nav>
