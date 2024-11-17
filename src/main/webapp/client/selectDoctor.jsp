<%@ page import="org.thanhnd.adis_m1.model.DoctorShift" %>
<%@ page import="java.util.List" %>
<%@ page import="org.thanhnd.adis_m1.model.Appointment" %>
<%@ page import="org.thanhnd.adis_m1.model.Shift" %>
<%@ page import="org.thanhnd.adis_m1.dao.DoctorShiftDAO" %><%--
  Created by IntelliJ IDEA.
  User: thanhnguyenduc
  Date: 15/11/24
  Time: 23:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("client") == null) {
        response.sendRedirect("login.jsp");
    }

    List<DoctorShift> doctorShifts = List.of();
    Appointment appointment = (Appointment) session.getAttribute("selectedAppointment");

    if (appointment == null) {
        response.sendRedirect("appointmentList.jsp");
    }

    assert appointment != null;
    if (request.getParameter("doctor") != null) {
        String doctor = request.getParameter("doctor");
        String degree = request.getParameter("degree");
        Shift shift = appointment.getDoctorShift().getShift();
        DoctorShiftDAO doctorShiftDAO = new DoctorShiftDAO();
        doctorShifts = doctorShiftDAO.searchShift(shift, doctor, degree);
        session.setAttribute("doctorShifts", doctorShifts);
    }

    if (request.getParameter("selectedDoctorId") != null) {
        Integer selectedDoctorId = Integer.parseInt(request.getParameter("selectedDoctorId"));
        DoctorShift selectedDoctorShift = doctorShifts
                .stream()
                .filter(ds -> ds.getId().equals(selectedDoctorId))
                .findFirst().orElse(null);
        appointment.setDoctorShift(selectedDoctorShift);
        session.setAttribute("selectedAppointment", appointment);
        response.sendRedirect("selectServices.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Doctor</title>
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

        .form-group {
            margin-bottom: 20px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
        }

        .form-group input {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            flex: 1;
        }

        .doctor-table {
            border-collapse: collapse;
            width: 100%;
        }

        .doctor-table th, .doctor-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .doctor-table th {
            background-color: #f2f2f2;
        }

        .doctor-table tbody tr {
            cursor: pointer;
        }

        .button-group {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 10px;
        }

        .search-btn, .back-btn, .next-btn {
            padding: 10px 20px;
            border: 2px solid #4b1a1a;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Search Doctor</h1>

    <div class="form-group">
        <label for="doctor">Doctor:</label>
        <input type="text" id="doctor" name="doctor">
        <select id="degree" name="degree">
            <option value="">Select Degree</option>
            <option value="MD">MD</option>
            <option value="PhD">PhD</option>
            <option value="All">All</option>
        </select>
        <button type="button" class="search-btn" onclick="searchDoctor()">
            Search
        </button>
    </div>

    <table class="doctor-table">
        <thead>
        <tr>
            <th>No</th>
            <th>Name</th>
            <th>Degree</th>
            <th>Year of Experiences</th>
            <th>Major</th>
            <th>Price</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (doctorShifts != null && !doctorShifts.isEmpty()) {
                int index = 1;
                for (DoctorShift doctorShift : doctorShifts) {
        %>
        <tr id="ds_<%=doctorShift.getId()%>" onclick="handleSelectDoctor('<%=doctorShift.getId()%>')">
            <td><%= index++ %>
            </td>
            <td><%= doctorShift.getDoctor().getName() %>
            </td>
            <td><%= doctorShift.getDoctor().getDegree() %>
            </td>
            <td><%= doctorShift.getDoctor().getYearOfExperience() %>
            </td>
            <td><%= doctorShift.getDoctor().getMajor() %>
            </td>
            <td><%= doctorShift.getShiftPrice() %> vnd
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>

    <div class="button-group">
        <button type="button" class="back-btn" onclick="history.back()">Back</button>
        <button type="button" class="next-btn" onclick="goToNextScreen()">Next</button>
    </div>
</div>

<script>
	let selectedDoctor = null;
	let selectedDoctorId = null;

	function handleSelectDoctor(idSelected) {
		if (selectedDoctor) {
			selectedDoctor.style.backgroundColor = '';
		}

		selectedDoctor = document.getElementById("ds_" + idSelected);

		if (selectedDoctorId === idSelected) {
			selectedDoctor.style.backgroundColor = '';
			selectedDoctorId = null;
			return false;
		}

		selectedDoctor.style.backgroundColor = '#f2f2f2';
		selectedDoctorId = idSelected;
		return true;
	}

	function goToNextScreen() {
		if (selectedDoctorId) {
			window.location.href = 'selectDoctor.jsp' + window.location.search + '&selectedDoctorId=' + selectedDoctorId;
		} else {
			alert('Please select a doctor first.');
		}
	}

	function searchDoctor() {
		const doctor = document.getElementById('doctor').value;
		const degree = document.getElementById('degree').value;

		window.location.href = 'selectDoctor.jsp?doctor=' + doctor + '&degree=' + degree;
	}
</script>
</body>
</html>