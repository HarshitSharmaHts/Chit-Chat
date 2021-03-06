package chit.chat;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
public class DeleteRoomServlet extends HttpServlet {

  public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException
  {
    doPost(request,response);
  }
  public void doPost(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException
  {
    HashMap hashmap = null;
    try {
      Class.forName("com.mysql.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/chat","root","root");
      synchronized (getServletContext())
      {
        hashmap = (HashMap)getServletContext().getAttribute("roomList");
        if(hashmap == null)
        {
          hashmap = new HashMap();
          Statement stmt = con.createStatement();
          String query = "SELECT * FROM CHATROOM";
          ResultSet rs = stmt.executeQuery(query);
          while(rs.next())
          {
            hashmap.put(rs.getString(1), new ChatRooms(rs.getString(1),rs.getString(2),4));
          }
          rs.close();
          getServletContext().setAttribute("roomlist",hashmap);
        }
      }
      String [] rooms = request.getParameterValues("remove");
      synchronized(hashmap)
      {
        if(rooms != null)
        {
          String d_query = "DELETE FROM CHATROOM WHERE roomname=?";
          PreparedStatement ps = con.prepareStatement(d_query);
          for(String var : rooms)
          {
            ps.setString(1,var);
            ps.executeUpdate();
            hashmap.remove(var);
          }
          ps.close();
        }
      }
      con.close();
    }
    catch (SQLException e) {

    }
    catch (ClassNotFoundException e) {

    }
    RequestDispatcher view = request.getRequestDispatcher("loggedin.jsp?reqPage=configRoom&op=del");
    view.forward(request,response);
  }
}
