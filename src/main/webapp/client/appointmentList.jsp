<%--
  Created by IntelliJ IDEA.
  User: thanhnguyenduc
  Date: 14/11/24
  Time: 11:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.thanhnd.adis_m1.dao.AppointmentDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="org.thanhnd.adis_m1.model.*" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session.getAttribute("client") == null) {
        response.sendRedirect("login.jsp");
    }

    if (request.getParameter("selectedAppointmentId") != null) {
        Integer selectedAppointmentId = Integer.parseInt(request.getParameter("selectedAppointmentId"));
        List<Appointment> appointments = (List<Appointment>) session.getAttribute("appointments");
        Appointment selectedAppointment = appointments
                .stream()
                .filter(a -> a.getId().equals(selectedAppointmentId))
                .findFirst().orElse(null);
        session.setAttribute("selectedAppointment", selectedAppointment);
        System.out.println(selectedAppointment);
        response.sendRedirect("selectDoctor.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Appointment List</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 70vh;
            box-sizing: border-box;
            gap: 10px;
        }

        h1 {
            font-size: 36px;
            text-align: center;
        }

        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
        }

        .appointment-table {
            border-collapse: collapse;
            width: 100%;
        }

        .appointment-table th, .appointment-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .appointment-table th {
            background-color: #f2f2f2;
        }

        .appointment-table tbody tr {
            cursor: pointer;
        }

        .button-group {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 10px;
        }

        .back-btn, .next-btn {
            padding: 10px 20px;
            border: 2px solid #4b1a1a;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Appointment List</h1>

    <table class="appointment-table">
        <thead>
        <tr>
            <th>No</th>
            <th>Datetime</th>
            <th>Doctor</th>
            <th>Services</th>
        </tr>
        </thead>
        <tbody>
        <%
            Client client = (Client) session.getAttribute("client");
            AppointmentDAO appointmentDAO = new AppointmentDAO();
            List<Appointment> appointments = appointmentDAO.getAppointmentList(client);
            if (appointments != null && !appointments.isEmpty()) {
                session.setAttribute("appointments", appointments);
                int index = 1;
                for (Appointment appointment : appointments) {
        %>
        <tr id="a_<%=appointment.getId()%>" onclick="handleSelectAppointment('<%=appointment.getId()%>')">
            <td><%= index++ %>
            </td>
            <td><%= appointment.getDoctorShift().getShift().getStartTime() %>
            </td>
            <td><%= appointment.getDoctorShift().getDoctor().getName() %>
            </td>
            <td>
                <%=
                appointment.getServices().stream()
                        .map(AppointmentService::getDoctorService)
                        .map(DoctorService::getService)
                        .map(Service::getName)
                        .collect(Collectors.joining(" "))
                %>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" style="text-align: center;">No appointments found</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <div class="button-group">
        <button type="button" class="back-btn" onclick="window.location.href='clientHome.jsp'">Back</button>
        <button type="button" class="next-btn" onclick="goToNextScreen()">Next</button>
    </div>
</div>

<script>
	let appointment = null;
	let appointmentId = null;

	function handleSelectAppointment(idSelected) {
		if (appointment) {
			appointment.style.backgroundColor = '';
		}

		appointment = document.getElementById("a_" + idSelected);

		if (appointmentId === idSelected) {
			appointment.style.backgroundColor = '';
			appointmentId = null;
			return false;
		}

		appointment.style.backgroundColor = '#f2f2f2';
		appointmentId = idSelected;
		return true;
	}

	function goToNextScreen() {
		if (appointmentId) {
			window.location.href = 'appointmentList.jsp?selectedAppointmentId=' + appointmentId;
		} else {
			alert('Please select an appointment first.');
		}
	}
</script>
</body>
</html>