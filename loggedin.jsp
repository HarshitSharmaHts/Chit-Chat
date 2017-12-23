<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.text.*,chit.chat.*,java.net.*" errorPage=""%>

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
          <textArea name=roomdesc cols="25" row=5 placeholder="Description."></textArea>
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

      String chrm = (String)session.getAttribute("chRoomPath");
      String rolp = (String)session.getAttribute("roomListPath");
      String adcp = (String)session.getAttribute("adminChatPath");
    %>
    <section class="main-container">
      <h1 class="">Welcome!<%=session.getAttribute("user")%></h1>
    	<div class="main-wrapper" align="center">
        <h2>Select Your Room.</h2>
        <%
          String login = (String)session.getAttribute("login");
          String s = request.getParameter("expand");
          String s1 = request.getParameter("profileName");
          if(s1 == null)
          {
            s1 ="";
          }
        %>
        <form class="signup-form" action="<%=chrm%>" method="POST">
        <%
          HashMap hashmap =(HashMap)getServletContext().getAttribute("roomList");
          if(hashmap == null)
          {
            out.println("<h1>No Room configured.</h1>");
          }
          else {
        %>
          <h1>Your Username "<%=session.getAttribute("loginid")%>" will be used while chatting.</h1>
          <input name=profileName type="hidden" value="<%=session.getAttribute("loginid")%>">
        <%
            Iterator iterator = hashmap.keySet().iterator();
            while(iterator.hasNext())
            {
              String s2 = (String)iterator.next();
              ChatRooms chatroom = (ChatRooms)hashmap.get(s2);
              String s3 = rolp + "?expand="+URLEncoder.encode(s2);
              s3 = response.encodeURL(s3);
        %>
          <input type=radio name=roomName value="<%=s2%>" <%=((s!=null && s.equals(s2)) ? " CHECKED":"")%>>
          <a href="<%=s3%>"><%=s2%></a>
        <%
          if(s!=null && s.equals(s2)){
            if(chatroom.getDescription().equals("")){
              out.println("<h1>There is no subject available.</h1>");
            }
            else
            {
              out.println("<h1>"+chatroom.getDescription()+"</h1>");
            }
          }
          }
        %>
        <button type="submit">Enter the room</button>
        </form>
        <%
          }
        %>
      </div>
    </section>
    <%
    }
    %>
  </body>

</html>
