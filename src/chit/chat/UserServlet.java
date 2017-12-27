package chit.chat;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class UserServlet extends HttpServlet {
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
  {
    RequestDispatcher rd = request.getRequestDispatcher("loggedin.jsp");
    rd.forward(request,response);
  }
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
  {
    doGet(request,response);
  }
}
