package chit.chat;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.text.*;

public class ChitChatServlet extends HttpServlet {

  String chRoomPath;
  String roomListPath;

  public ChitChatServlet(){}
  public void init()
  {
    ServletContext serCon = getServletContext();
    chRoomPath = serCon.getInitParameter("CHROOM_PATH");
    roomListPath = serCon.getInitParameter("ROOMLIST_PATH");
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
  {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    ChatRooms chatroom = getRoom(request,response);

    if(chatroom == null)
      return;

    String str = request.getParameter("list");

    if(str != null && str.equals("true"))
      writeMessage(out,chatroom,getProfileName(request));
    else
    {
      out.println("<html><link rel=\"stylesheet\" href=\"assets/css/chat.css\"><link href=\"https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css\" rel=\"stylesheet\" integrity=\"sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN\" crossorigin=\"anonymous\">");
      out.println("<body marginheight=0 marginwidth=0>");
      out.println("<form class=\"chat-form\" method=\"POST\" action=\""+response.encodeURL(chRoomPath)+"\" target=\"_top\">");
      out.println("<textarea name=msg placeholder=\"Your Message..\"></textarea>");
      out.println("<button type=submit><i class=\"fa fa-paper-plane\" aria-hidden=\"true\"></i></button>");
      out.println("</form>");
      out.println("</body></html>");
    }
    out.close();
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
  {
    response.setContentType("text/html");
    ChatRooms chatroom = getRoom(request,response);
    if(chatroom == null)
      return;
    String str = getProfileName(request);
    String msgStr = request.getParameter("msg");
    if(msgStr != null && msgStr.length() != 0)
    {
      DateFormat df= new SimpleDateFormat("hh:mm");
      String time = df.format(new Date());
      chatroom.joinChatEntry(new ChatRoomEntry(str,msgStr,time));
    }
    messageFrame(response,request,chatroom);
  }
  private String getProfileName(HttpServletRequest request)
  {
    HttpSession ht_session = request.getSession(true);
    String str = (String)ht_session.getAttribute("profileName");
    if(str == null)
    {
      str = request.getParameter("profileName");
      if(str == null || str.length() == 0)
      {
        str = "Anonymous";
      }
      ht_session.setAttribute("profileName",str);
    }
    else
    {
      String proStr = request.getParameter("profileName");
      if(proStr != null && proStr.length() > 0 && !proStr.equals(str))
      {
        str = proStr;
        ht_session.setAttribute("profileName",str);
      }
    }
    return str;
  }
  private ChatRooms getRoom(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
  {
    HttpSession ht_session = request.getSession(true);
    PrintWriter out = response.getWriter();
    String str = (String)ht_session.getAttribute("roomName");
    if(str == null)
    {
      str = request.getParameter("roomName");
      if(str == null || str.length() == 0)
      {
        error(request, response);
        return null;
      }
      ht_session.setAttribute("roomName",str);
    }
    else
    {
        String roStr = request.getParameter("roomName");
        if(roStr != null && roStr.length() > 0 && ! roStr.equals(str))
        {
          str = roStr;
          ht_session.setAttribute("roomName",str);
        }
    }
    HashMap hashmap = (HashMap)getServletContext().getAttribute("roomList");
    ChatRooms chatroom = (ChatRooms)hashmap.get(str);
    if(chatroom == null)
    {
      error(request,response);
      return null;
    }
    else
    {
      return chatroom;
    }
  }

  private void error(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
  {
    RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
    rd.forward(request,response);
  }

  private void messageFrame(HttpServletResponse response,HttpServletRequest request, ChatRooms chatroom) throws IOException, ServletException
  {
    PrintWriter out = response.getWriter();
    out.println("<html>"+
                  "<head>"+
                    "<title>"+
                    "</title>"+
                    "<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css\" integrity=\"sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb\" crossorigin=\"anonymous\">"+
                    "<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js\" integrity=\"sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ\" crossorigin=\"anonymous\"></script>"+
                    "<link rel=\"stylesheet\" href=\"http://fonts.googleapis.com/css?family=Roboto:400,100,300,500\">"+
                    "<link href=\"https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css\" rel=\"stylesheet\" integrity=\"sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN\" crossorigin=\"anonymous\">"+
                    "<link rel=\"stylesheet\" href=\"assets/css/style.css\"> <link rel=\"stylesheet\" href=\"assets/css/chat.css\">"+
                  "</head>"+
                  "<body>"+
                    "<nav class=\"navbar navbar-expand-sm bg-dark navbar-dark\">"+
                      "<ul class=\"navbar-nav mr-auto\">"+
                        "<li class=\"nav-item\">"+
                          "<a class=\"nav-link\" href=\"Index\">Home</a>"+
                        "</li>"+
                        "<li class=\"nav-item\">"+
                          "<a class=\"nav-link\" href=\"User\">Exit Room</a>"+
                        "</li>"+
                      "</ul>"+
                      "<ul class=\"navbar-nav mr-auto\">"+
                        "<li class=\"nav-item\">"+
                          "<h1>"+request.getParameter("roomName")+"'s Chat Room &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h1>"+
                        "</li>"+
                      "</ul>"+
                      "<form class=\"form-inline right-form\" action=\"logout.jsp\" method=\"POST\">"+
                        "<button class=\"btn btn-success\" type=\"submit\" name=\"submit\">Logout</button>"+
                      "</form>"+
                    "</nav>"+
                    "<div class=\"container\">"+
                      "<div class=\"row\">"+
                        "<div class=\"col-md-3\">"+
                        "</div>"+
                        "<div class=\"col-md-6\">"+
                          "<iframe frameborder=0 src=\"ChitChat?list=true\" height='450px'></iframe>"+
                        "</div>"+
                        "<div class=\"col-md-3\">"+
                        "</div>"+
                      "</div>"+
                    "</div>"+
                    "<div class=\"row bottom-div\">"+
                      "<div class=\"col-md-4\">"+
                      "</div>"+
                      "<div class=\"col-md-4\">"+
                        "<iframe frameborder=0 src=\"ChitChat?list=false\" height='45px'></iframe>"+
                      "</div>"+
                      "<div class=\"col-md-4\">"+
                      "</div>"+
                    "</div>"+
                  "</body>"+
                "</html>");
  }

  private void writeMessage(PrintWriter out, ChatRooms chatroom, String str)
  {
    StringBuffer strBuff = new StringBuffer();
    out.println("<html><head>"+
    "<link href=\"https://fonts.googleapis.com/css?family=Exo+2\" rel=\"stylesheet\">"+
    "<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css\" integrity=\"sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb\" crossorigin=\"anonymous\">"+
    "<link rel=\"stylesheet\" href=\"assets/css/chat.css\"><META http-equiv=\"refresh\" content=\"5\"></head><body><div class=\"col-lg-12\">");
    if(chatroom.size() == 0)
    {
      out.println("<h1>No message available in this room.</h1>");
    }
    else
    {
      for(Iterator iterator = chatroom.iterator();iterator.hasNext();)
      {
        ChatRoomEntry chentry = (ChatRoomEntry)iterator.next();
        if(chentry != null)
        {
          String proStr = chentry.getProfileName();
          if(proStr.equals(str))
          {
            out.println("<div class=\"chat-container my-msg\"><p>"+proStr + " : " + chentry.getMessage()+"</p><span class=\"time-right\">"+chentry.getTime()+"</span></div>");
          }
          else
          {
            out.println("<div class=\"chat-container else-msg\"><p>"+proStr + " : " + chentry.getMessage()+"</p><span class=\"time-left\">"+chentry.getTime()+"</span></div>");
          }
        }
      }
    }
    out.println("</div></body></html>");
  }
}
