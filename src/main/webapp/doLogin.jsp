<%--
  Created by IntelliJ IDEA.
  User: thanhnguyenduc
  Date: 12/11/24
  Time: 15:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="org.thanhnd.adis_m1.model.User, org.thanhnd.adis_m1.dao.UserDAO, org.thanhnd.adis_m1.model.Client" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    User user = new User(null, username, password, null, null);
    UserDAO userDAO = new UserDAO();
    Object result = userDAO.checkLogin(user);

    if (result instanceof Client) {
        session.setAttribute("client", result);
        RequestDispatcher dispatcher = request.getRequestDispatcher("clientHome.jsp");
        dispatcher.forward(request, response);
    } else if (result instanceof User) {
        session.setAttribute("user", result);
        RequestDispatcher dispatcher = request.getRequestDispatcher("receptionistHome.jsp");
        dispatcher.forward(request, response);
    } else {
        System.out.println("Login failed. Please try again.");
    }
%>