<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.billsystem.models.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getUsertype() != 1) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<h2>Welcome Cashier: <%= user.getUsername() %></h2>
<a href="login.jsp">Logout</a>
