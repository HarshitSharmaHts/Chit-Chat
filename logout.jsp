<%@ page language="java" import="java.util.*, java.text.*" errorPage=""%>
<%
  session.setAttribute("login","no");
  session.setAttribute("user","");
  session.setAttribute("type","");
  response.sendRedirect("/chat/Chat");
%>
