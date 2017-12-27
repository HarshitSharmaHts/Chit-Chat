package chit.chat;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.sql.*;

public class ChatServlet extends HttpServlet {
	String chRoomPath;
	String roomListPath;
	String adminChatPath;

	public void init()
	{
		ServletContext serCon = getServletContext();
		serCon.setAttribute("chRoomPath",
		serCon.getInitParameter("CHROOM_PATH"));
		serCon.setAttribute("roomListPath",
		serCon.getInitParameter("ROOMLIST_PATH"));
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException
	{
		HttpSession session = request.getSession();
		chRoomPath = (String)getServletContext().getAttribute("chRoomPath");
		roomListPath = (String)getServletContext().getAttribute("roomListPath");
		adminChatPath = (String)getServletContext().getAttribute("adminChatPath");

		session.setAttribute("chRoomPath",chRoomPath);
		session.setAttribute("roomListPath",roomListPath);
		session.setAttribute("adminChatPath",adminChatPath);

		HashMap hashmap = null;
		PrintWriter out = response.getWriter();
		out.println("Hello World!");
		try
		{
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/chat","root","root");
			out.println("Connection established.");
			synchronized(getServletContext())
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
						hashmap.put(rs.getString(1),new ChatRooms(rs.getString(1),rs.getString(2),4));
					}
					rs.close();
					getServletContext().setAttribute("roomList",hashmap);
				}
			}
			con.close();
		}
		catch(SQLException e)
		{
		}
		catch(ClassNotFoundException e)
		{
		}
		RequestDispatcher view = request.getRequestDispatcher("chat.jsp");
		view.forward(request,response);
	}

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException
	{
		doPost(request,response);
	}
}
