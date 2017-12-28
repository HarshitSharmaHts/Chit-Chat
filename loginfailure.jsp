<%@ page language="java" import="java.util.*, java.text.*" errorPage="" %>
<%
  String type="";
%>
      <%@ include file="menu.jsp"%>
      <div class="container">
        <div class="row">
          <div class="col-md-4"></div>
          <div class="col-md-4 login-failure">
            <h1><i class="fa fa-exclamation-triangle fa-5x" aria-hidden="true"></i><br/>Login Failure</h1>

            <%
            DateFormat df = new SimpleDateFormat("EEEE, dd MMMM, YYYY");
            String date=df.format(new Date());
            out.println("<span class=\"failure-date\">"+date+"</span><br><br>");
            String login = (String)session.getAttribute("login");
            %>
            <p>Either your Login Id or Password is wrong.</p>
          </div>
          <div class="col-md-4"></div>
        </div>
      </div>
  </body>
</html>
