package chit.chat;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.text.*;

public class ChitChat extends HttpServlet {

  String chRoomPath;
  String roomListPath;

  public ChitChat(){}
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
      out.println("<html><link rel=\"stylesheet\" href=\"css/main.css\">");
      out.println("<body marginheight=0 marginwidth=0>");
      out.println("<form class=\"chat-form\" method=\"POST\" action=\""+response.encodeURL(chRoomPath)+"\" target=\"_top\">");
      out.println("<textarea name=msg cols=50 rows=1 placeholder=\"Your Message..\"></textarea>");
      out.println("<button type=submit>Send</button>");
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
    messageFrame(response,chatroom);
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

  private void messageFrame(HttpServletResponse response, ChatRooms chatroom) throws IOException
  {
    PrintWriter out = response.getWriter();
    out.println(
    "<html>"+
      "<head>"+
        "<link rel=\"stylesheet\" href=\"css/main.css\">"+
        "<title>"+
          chatroom.getName()+
        "</title>"+
      "</head>"+
            "<div><iframe src=\""+response.encodeURL(chRoomPath)+"?list=true\" width=500 height=600></iframe></div>"+
            "<div><iframe src=\""+response.encodeURL(chRoomPath)+"?list=false\" width=500 height='40px'></iframe></div>"+
    "</html>"
    );
    out.close();
  }

  private void writeMessage(PrintWriter out, ChatRooms chatroom, String str)
  {
    StringBuffer strBuff = new StringBuffer();
    out.println("<html><head><link rel=\"stylesheet\" href=\"css/main.css\"><META http-equiv=\"refresh\" content=\"5\"></head><body>");
    out.println("<div class=\"chat-header\"><h1>"+chatroom.getName()+"' Chat Room</h1><p>You are: "+str+"</p></div>");
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
            out.println("<div class=\"my-chat-msg\"><p>");
          else
            out.println("<div class=\"else-chat-msg\"><p>");

          out.println(proStr + " : " + chentry.getMessage());
          out.println("</p><span class=\"msg-time\">"+chentry.getTime()+"</span></div>");
        }
      }
    }
    out.println("</body></html>");
  }
}
