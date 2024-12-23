<%@ page import="org.thanhnd.adis_m1.model.Appointment" %>
<%@ page import="org.thanhnd.adis_m1.dao.AppointmentDAO" %><%--
  Created by IntelliJ IDEA.
  User: thanhnguyenduc
  Date: 14/11/24
  Time: 09:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Appointment appointment = (Appointment) session.getAttribute("appointment");
    if (appointment == null) {
        response.sendRedirect("searchSlot.jsp");
    }

    AppointmentDAO appointmentDAO = new AppointmentDAO();
    try {
        boolean result = appointmentDAO.save(appointment);
        if (result) {
            session.removeAttribute("appointment");
            session.removeAttribute("doctorShifts");
            session.removeAttribute("selectedDoctorId");
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
	window.location.href = 'bookingConfirm.jsp';
</script>
<%
    }
%>