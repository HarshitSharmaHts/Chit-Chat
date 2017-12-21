<%
String type = "";
%>
<%@ include file="menu.jsp" %>
    <%
      if(!session.getAttribute("login").equals("no"))
      {
        response.sendRedirect("/chat/loggedin.jsp");
      }
    %>
    <section class="main-container">
    	<div class="main-wrapper signup-wrapper">
    		<h2>Create an Account</h2>
    		<form class="signup-form" action="adduser.jsp" method="POST">
          <input type="text" name="name" placeholder="Full Name">
          <input type="text" name="loginid" placeholder="UserName">
          <input type="text" name="email" placeholder="Email">
          <input type="hidden" name="type" value="User">
          <input type="password" name="password" placeholder="Password">
          <button type="submit" name="submit">Create</button>
    		</form>
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
