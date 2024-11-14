<%@ page import="org.thanhnd.adis_m1.dao.DoctorShiftDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="org.thanhnd.adis_m1.model.DoctorShift" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="org.thanhnd.adis_m1.model.Appointment" %>
<%@ page import="org.thanhnd.adis_m1.model.Client" %>
<%--
  Created by IntelliJ IDEA.
  User: thanhnguyenduc
  Date: 13/11/24
  Time: 14:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("client") == null) {
        response.sendRedirect("login.jsp");
    }

    if (request.getParameter("selectedShiftId") != null) {
        Integer selectedShiftId = Integer.parseInt(request.getParameter("selectedShiftId"));
        List<DoctorShift> doctorShifts = (List<DoctorShift>) session.getAttribute("doctorShifts");
        DoctorShift selectedDoctorShift = doctorShifts
                .stream()
                .filter(ds -> ds.getId().equals(selectedShiftId))
                .findFirst().orElse(null);
        Appointment appointment = new Appointment();
        Client client = (Client) session.getAttribute("client");
        appointment.setDoctorShift(selectedDoctorShift);
        appointment.setClient(client);
        session.setAttribute("appointment", appointment);
        response.sendRedirect("bookingConfirm.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Appointment</title>
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
    <h1>Book Appointment</h1>

    <div class="form-group">
        <label for="date">Date:</label>
        <input type="date" id="date" name="date"
               value="<%= request.getParameter("date") != null ? request.getParameter("date") : "" %>">
        <button type="button" class="search-btn" onclick="searchShifts()">
            Search
        </button>
    </div>

    <table class="appointment-table">
        <thead>
        <tr>
            <th>No</th>
            <th>Available Slot</th>
            <th>Doctor</th>
        </tr>
        </thead>
        <tbody id="table-body">
        <%
            String dateParam = request.getParameter("date");
            if (dateParam != null && !dateParam.isEmpty()) {
                session.setAttribute("date", dateParam);

                LocalDate date = LocalDate.parse(dateParam, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                DoctorShiftDAO doctorShiftDAO = new DoctorShiftDAO();
                List<DoctorShift> doctorShifts = doctorShiftDAO.searchShift(date);
                if (doctorShifts.isEmpty()) {
        %>
        <tr>
            <td colspan="3" style="text-align: center;">There are no shifts on this day</td>
        </tr>
        <%
        } else {
            int index = 1;
            session.setAttribute("doctorShifts", doctorShifts);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            for (DoctorShift doctorShift : doctorShifts) {
        %>
        <tr id="ds_<%=index%>" onclick="handleSelectSlot('<%= doctorShift.getId() %>')">
            <td><%= index++ %>
            </td>
            <td><%= doctorShift.getShift().getStartTime().format(formatter) %>
                - <%= doctorShift.getShift().getEndTime().format(formatter) %>
            </td>
            <td><%= doctorShift.getDoctor().getName() %>
            </td>
        </tr>
        <%
                    }
                }
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
	function searchShifts() {
		const date = document.getElementById('date').value;

		if (date) {
			const tableBody = document.getElementById('table-body');
			tableBody.innerHTML = '<tr><td colspan="3" style="text-align: center;">Loading...</td></tr>';
			window.location.href = 'searchSlot.jsp?date=' + date;
		}
	}

		let selectedShift = null;
		let selectedShiftId = null;

		function handleSelectSlot(idSelected) {
			if (selectedShift) {
				selectedShift.style.backgroundColor = '';
			}

			selectedShift = document.getElementById("ds_" + idSelected);

			if (selectedShiftId === idSelected) {
				selectedShift.style.backgroundColor = '';
				selectedShiftId = null;
				return false;
			}

			selectedShift.style.backgroundColor = '#f2f2f2';
			selectedShiftId = idSelected;
			return true;
		}

		function goToNextScreen() {
			if (selectedShiftId) {
				window.location.href = 'searchSlot.jsp?selectedShiftId=' + selectedShiftId;
			} else {
				alert('Please select a shift first.');
			}
		}
</script>
</body>
</html>