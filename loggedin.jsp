<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.text.*,chit.chat.*" errorPage=""%>

<html>
  <%
  if(session.getAttribute("login")==null)
  {
    session.setAttribute("login","no");
  }
  String type="";
  if(session.getAttribute("login").equals("no"))
  {
    String loginid = request.getParameter("loginid");
    String pwd = request.getParameter("password");
    type = (String)request.getParameter("type");

    boolean flag=false;

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/chat","root","root");
    Statement stmt = conn.createStatement();
    String query = "SELECT * FROM LOGIN WHERE LOGINID='"+loginid+"' AND type='"+type+"'";

    ResultSet rs = stmt.executeQuery(query);

    while(rs.next())
    {
      String pass = rs.getString(3);

      if(pass.equals(pwd))
      {
        flag=true;
        break;
      }
    }
    if(flag)
    {
      session.setAttribute("login",rs.getString(1));
      session.setAttribute("type",rs.getString(5));
      session.setAttribute("user",rs.getString(2));
      session.setAttribute("loginid",rs.getString(1));
    }
    else
    {
      RequestDispatcher rd = request.getRequestDispatcher("loginfailure.jsp");
      rd.forward(request,response);
    }
  }
  else
    type=(String)session.getAttribute("type");

  if((!"Admin".equals(type))&&(!"User".equals(type)))
  {
      RequestDispatcher rd = request.getRequestDispatcher("loginfailure.jsp");
      rd.forward(request,response);
  }
    String reqPage = (String)request.getParameter("reqPage");

  %>
  <head>
    <title></title>

    <link rel="stylesheet" href="css/default.css">
  	<link rel="stylesheet" href="css/main.css">
  	<link rel="stylesheet" href="css/fonts.css">
  	<link rel="shortcut icon" href="favicon.ico" >
  </head>
  <body>
    <%@ include file="menu.jsp"%>
    <%
    if("Admin".equals(type))
    {
      if(reqPage==null)
      {
    %>
    <section class="main-container">
      <h1 class="">Welcome!<%=session.getAttribute("user")%></h1>
    	<div class="main-wrapper" align="center">

      </div>
    </section>
    <%
  }else if(reqPage.equals("addAdmin"))
      {
    %>
    <section class="main-container">
      <div class="main-wrapper signup-wrapper">
        <h2>Add One More Admin</h2>
        <form class="signup-form" action="adduser.jsp" method="POST">
          <input type="text" name="name" placeholder="Full Name">
          <input type="text" name="loginid" placeholder="UserName">
          <input type="text" name="email" placeholder="Email">
          <input type="hidden" name="type" value="Admin">
          <input type="password" name="password" placeholder="Password">
          <button type="submit" name="submit">Create</button>
        </form>
      </div>
    </section>
    <%
  }else if(reqPage.equals("viewUser"))
    {
    %>
    <%-- <%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage=""%> --%>
    <%
      Class.forName("com.mysql.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/chat","root","root");
      Statement stmt = con.createStatement();
      String query = "SELECT * FROM LOGIN";
      ResultSet rs = stmt.executeQuery(query);
    %>
    <section class="main-container">
        <form class="viewuser-form" action="deleteuser.jsp" method="POST">
            <h2>User Information</h2><hr>
          <table align="center">
              <thead>
                <tr>
                  <td>Name</td>
                  <td>LoginID</td>
                  <td>Password</td>
                  <td>E-Mail</td>
                  <td>Type</td>
                </tr>
              </thead>
              <tbody>
            <%
              while(rs.next())
              {
                out.println("<tr>");
                out.println("<td><input type=checkbox value="+rs.getString(1)+" name=loginid>"+rs.getString(2)+"</td>");
                out.println("<td>"+rs.getString(1)+"</td>");
                out.println("<td>"+rs.getString(3)+"</td>");
                out.println("<td>"+rs.getString(4)+"</td>");
                out.println("<td>"+rs.getString(5)+"</td>");
                out.println("</tr>");
              }
              rs.close();
              con.close();
            %>

              </tbody>
          </table>
          <button type="submit" name="submit">Delete User(s)</button>
        </form>
    </section>
    <%
      }
      else if(reqPage.equals("configRoom"))
      {
        String chrm = (String)session.getAttribute("chRoomPath");
        String rolp = (String)session.getAttribute("roomListPath");
        String adcp = (String)session.getAttribute("adminChatPath");
    %>
    <%=chrm%>
    <%=rolp%>
    <%=adcp%>
    <section class="main-container">
        <form class="viewuser-form" action="<%=response.encodeURL(adcp)%>" method="POST">
      <table align="center">
        <tbody>
          <%
            HashMap hashmap = (HashMap)getServletContext().getAttribute("roomList");
            if(hashmap != null)
            {
              Iterator iterator = hashmap.keySet().iterator();
              if(!iterator.hasNext()){
                out.println("No Room Configured.");
              }
              else
              {
                out.println("To Remove a room check it and press Update RoomList.");
                ChatRooms chatroom;
                for(;
                    iterator.hasNext();
                    out.println("<tr><td><input type=checkbox name=remove value='"+chatroom.getName()+"'>"+chatroom.getName()+"</td></tr>")
                    )
                {
                  String s = (String)iterator.next();
                  chatroom = (ChatRooms)hashmap.get(s);
                }
              }
            }
          %>
        </tbody>
        </table>
          <input name=roomname size=25 placeholder="Subject"/>
          <textArea name=roomdescr cols="25" row=5 placeholder="Description."></textArea>
          <button type="submit">Update RoomList</button>
        </form>
    </section>
    <%
      }
    }
    else if("User".equals(type))
    {
      if(reqPage!=null)
      {
        response.sendRedirect("/chat/loggedin.jsp");
      }
    %>
    <section class="main-container">
      <h1 class="">Welcome!<%=session.getAttribute("user")%></h1>
    	<div class="main-wrapper" align="center">

      </div>
    </section>
    <%
    }
    %>
  </body>

</html>
