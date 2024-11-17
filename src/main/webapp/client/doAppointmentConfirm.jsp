<%@ page import="org.thanhnd.adis_m1.model.Appointment" %>
<%@ page import="org.thanhnd.adis_m1.dao.AppointmentDAO" %><%--
  Created by IntelliJ IDEA.
  User: thanhnguyenduc
  Date: 17/11/24
  Time: 22:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("client") == null) {
        response.sendRedirect("login.jsp");
    }

    Appointment appointment = (Appointment) session.getAttribute("selectedAppointment");
    if (appointment == null) {
        response.sendRedirect("appointmentList.jsp");
    }

    AppointmentDAO appointmentDAO = new AppointmentDAO();
    try {
        boolean result = appointmentDAO.save(appointment);
        if (result) {
            session.removeAttribute("selectedAppointment");
%>
<script>
	alert('Appointment saved successfully!');
	window.location.href = 'clientHome.jsp';
</script>
<%
    }
} catch (Exception e) {
    System.out.println(e.getMessage());
%>
<script>
	alert("<%=e.getMessage()%>");
	window.location.href = 'appointmentConfirm.jsp';
</script>
<%
    }
%>