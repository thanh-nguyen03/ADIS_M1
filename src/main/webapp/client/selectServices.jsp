<%@ page import="org.thanhnd.adis_m1.model.Appointment" %>
<%@ page import="org.thanhnd.adis_m1.dao.DoctorServiceDAO" %>
<%@ page import="org.thanhnd.adis_m1.model.DoctorService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="org.thanhnd.adis_m1.model.AppointmentService" %><%--
  Created by IntelliJ IDEA.
  User: thanhnguyenduc
  Date: 17/11/24
  Time: 17:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("client") == null) {
        response.sendRedirect("login.jsp");
    }

    if (session.getAttribute("selectedAppointment") == null) {
        response.sendRedirect("appointmentList.jsp");
    }


    Appointment appointment = (Appointment) session.getAttribute("selectedAppointment");

    assert appointment != null;

    if (request.getParameter("selectedServiceIds") != null) {
        String selectedServiceIds = request.getParameter("selectedServiceIds");
        List<DoctorService> selectedDoctorServices = (List<DoctorService>) session.getAttribute("doctorServices");
        List<AppointmentService> doctorServices = selectedDoctorServices
                .stream()
                .filter(ds -> selectedServiceIds.contains(ds.getId().toString()))
                .map(ds -> new AppointmentService(null, null, null, ds.getPrice(), appointment, ds))
                .collect(Collectors.toList());
        appointment.setServices(doctorServices);
        session.setAttribute("selectedAppointment", appointment);
        response.sendRedirect("appointmentConfirm.jsp");
    }

    DoctorServiceDAO doctorServiceDAO = new DoctorServiceDAO();
    List<DoctorService> doctorServices = doctorServiceDAO.getDoctorServices(appointment.getDoctorShift().getDoctor());
    session.setAttribute("doctorServices", doctorServices);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Services</title>
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

        .service-table {
            border-collapse: collapse;
            width: 100%;
        }

        .service-table th, .service-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .service-table th {
            background-color: #f2f2f2;
        }

        .service-table tbody tr {
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
    <h1>Select Services</h1>

    <table class="service-table">
        <thead>
        <tr>
            <th>No</th>
            <th>Name</th>
            <th>Price</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (doctorServices != null && !doctorServices.isEmpty()) {
                int index = 1;
                for (DoctorService doctorService : doctorServices) {
        %>
        <tr id="ds_<%=doctorService.getId()%>" onclick="handleSelectService('<%=doctorService.getId()%>')">
            <td><%= index++ %>
            </td>
            <td><%= doctorService.getService().getName() %>
            </td>
            <td><%= doctorService.getPrice() %> vnđ
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>

    <div class="button-group">
        <button type="button" class="back-btn">Back</button>
        <button type="button" class="next-btn" onclick="goToNextScreen()">Next</button>
    </div>
</div>

<script>
	let selectedServices = new Set();

	function handleSelectService(idSelected) {
		const row = document.getElementById("ds_" + idSelected);

		if (selectedServices.has(idSelected)) {
			selectedServices.delete(idSelected);
			row.style.backgroundColor = '';
		} else {
			selectedServices.add(idSelected);
			row.style.backgroundColor = '#f2f2f2';
		}
	}

	function goToNextScreen() {
		if (selectedServices.size > 0) {
			const selectedServiceIds = Array.from(selectedServices).join(',');
			window.location.href = window.location.pathname + '?selectedServiceIds=' + selectedServiceIds;
		} else {
			alert('Please select at least one service.');
		}
	}
</script>
</body>
</html>