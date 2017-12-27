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
<div class="container">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6 tabs">
            <div class="form-box">
                <div class="form-top">
                    <div class="form-top-center">
                        <h3 align="center">Add Admin</h3>
                    </div>
                </div>
                <div class="form-bottom">
                    <form role="form" action="adduser.jsp" method="POST" class="registration-form">
                        <div class="form-group">
                            <label class="sr-only" for="full-name">Full Name</label>
                            <input type="text" name="name" placeholder="Full Name" class="full-name form-control" id="form-first-name">
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="user-name">Username</label>
                            <input type="text" name="loginid" placeholder="UserName" class="user-name form-control" id="form-last-name">
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="form-email">Email</label>
                            <input type="text" name="email" placeholder="Email" class="form-email form-control" id="form-email">
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="form-password">Password</label>
                            <input type="password" name="password" placeholder="Password" class="form-password form-control" id="form-about-yourself">
                        </div>
                        <input type="hidden" name="type" value="Admin">
                        <button type="submit" class="btn">Add</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-3"></div>
    </div>
</div>
<%
    }else if(reqPage.equals("viewUser"))
      {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/chat","root","root");
    Statement stmt = con.createStatement();
    String query = "SELECT * FROM LOGIN";
    ResultSet rs = stmt.executeQuery(query);
    %>
<div class="container">
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10 tabs">
            <div class="form-box">
                <div class="form-top">
                    <div class="form-top-center">
                        <h3 align="center">Available User's Details</h3>
                    </div>
                </div>
                <div class="form-bottom">
                    <form role="form" action="deleteuser.jsp" method="POST" class="registration-form">
                        <div class="table-responsive">
                            <table class="table">
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
                                          out.println("<td><input style=\"margin-right:5px;\" type=checkbox value="+rs.getString(1)+" name=loginid>"+rs.getString(2)+"</td>");
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
                        </div>
                        <button type="submit" class="btn">Delete</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-1"></div>
    </div>
</div>
<%
    }
    else if(reqPage.equals("configRoom"))
    {
      String chrm = (String)session.getAttribute("chRoomPath");
      String rolp = (String)session.getAttribute("roomListPath");
      String op = (String)request.getParameter("op");
    %>
<div class="container">
    <div class="row">
        <div class="col-md-3"></div>
        <%
          if(op.equals("del"))
          {
        %>
        <div class="col-md-6">
            <div class="form-box">
                <div class="form-top">
                    <div class="form-top-center">
                        <h3 align="center">Delete Room</h3>
                    </div>
                </div>
                <div class="form-bottom">
                    <form role="form" action="/ChitChat/DeleteRoom" method="POST" class="registration-form">
                        <div class="table-responsive">
                            <table class="table">
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
                        </div>
                        <button type="submit" class="btn">Delete</button>
                    </form>
                </div>
            </div>
        </div>
        <%
      }else{
        %>
        <div class="col-md-6">
            <div class="form-box">
                <div class="form-top">
                    <div class="form-top-center">
                        <h3 align="center">Add Room</h3>
                    </div>
                </div>
                <div class="form-bottom">
                    <form role="form" action="/ChitChat/AddRoom" method="POST" class="registration-form">
                        <div class="form-group">
                            <input class="form-control" name=roomname size=25 placeholder="Subject"/>
                        </div>
                        <div class="form-group">
                            <textArea class="form-control" name=roomdesc cols="25" row=5 placeholder="Description."></textArea>
                        </div>
                        <button type="submit" class="btn">Add</button>
                    </form>
                </div>
            </div>
        </div>
        <%
      }%>
        <div class="col-md-3"></div>
    </div>
</div>
<%
    }
    }
    else if("User".equals(type))
    {
    if(reqPage!=null)
    {
      response.sendRedirect("/ChitChat/loggedin.jsp");
    }

    String chrm = (String)session.getAttribute("chRoomPath");
    String rolp = (String)session.getAttribute("roomListPath");
    %>


    <div class="container">
    <div class="row">
      <%
                String login = (String)session.getAttribute("login");
                String expand = request.getParameter("expand");
                String s1 = request.getParameter("profileName");
                if(s1 == null)
                {
                  s1 ="";
                }
                      HashMap hashmap =(HashMap)getServletContext().getAttribute("roomList");
                      if(hashmap == null)
                      {
                        out.println("<h1>No Room configured.</h1>");
                      }
                      else {
                      Iterator iterator = hashmap.keySet().iterator();
                      while(iterator.hasNext())
                      {
                        String s2 = (String)iterator.next();
                        ChatRooms chatroom = (ChatRooms)hashmap.get(s2);
                        String s3 = rolp + "?expand="+URLEncoder.encode(s2);
                        s3 = response.encodeURL(s3);
        %>

                    <div class="col-md-3">
                      <div class="form-box">
                          <div class="form-top">
                             <div class="form-top-center">
                                <h3 align="center"><%=s2%></h3>
                             </div>
                          </div>
                          <div class="form-bottom">
                            <form role="form" action="<%=chrm%>" method="POST">
                              <input name=profileName type="hidden" value="<%=session.getAttribute("loginid")%>">
                              <input class="form-control" type=hidden name=roomName value="<%=s2%>">
<%
if(chatroom.getDescription().equals("")){
out.println("<p>There is no subject available.</p>");
}
else
{
out.println("<p>"+chatroom.getDescription()+"</p>");
}
%>
                            <button class="form-control" type="submit">Enter the room</button>
                          </form>
                        </div>
                      </div>
                    </div>
                        <%
                      }}
                      %>
      </div>
    </div>
<%
    }
    %>
</body>
</html>
