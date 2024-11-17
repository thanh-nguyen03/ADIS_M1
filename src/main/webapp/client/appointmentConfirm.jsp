<%@ page import="org.thanhnd.adis_m1.model.Appointment" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="org.thanhnd.adis_m1.model.Service" %>
<%@ page import="org.thanhnd.adis_m1.model.AppointmentService" %><%--
  Created by IntelliJ IDEA.
  User: thanhnguyenduc
  Date: 17/11/24
  Time: 20:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("client") == null) {
        response.sendRedirect("login.jsp");
    }

    if (session.getAttribute("selectedAppointment") == null) {
        response.sendRedirect("appointmentList.jsp");
    }

    Appointment appointment = (Appointment) session.getAttribute("selectedAppointment");
    assert appointment != null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Appointment</title>
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

        p {
            font-weight: bold;
            margin-bottom: 5px;
        }

        span {
            font-weight: normal;
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

        .cancel-btn, .confirm-btn {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }

        .cancel-btn {
            background-color: #f44336; /* Red for Cancel */
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Confirm</h1>

    <div class="details">
        <p>Datetime:
            <span id="datetime">
                <%=appointment.getDoctorShift().getShift().getStartTime()%>
            </span>
        </p>
        <p>Client:
            <span id="client">
                <%=appointment.getClient().getFullName()%>
            </span>
        </p>
        <p>Client's phone:
            <span id="phone">
                <%=appointment.getClient().getPhone()%>
            </span>
        </p>
        <p>Doctor:
            <span id="doctor">
                <%=appointment.getDoctorShift().getDoctor().getName()%>
            </span>
        </p>
        <p>Price:
            <span id="price">
                <%=appointment.getDoctorShift().getShiftPrice()%> vnđ
            </span>
        </p>

        <p>Room:
            <span id="room">
                <%=appointment.getDoctorShift().getRoom().getName()%>
            </span>
        </p>

        <p style="margin-bottom: 2px">Services:</p>
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
                int index = 1;
                for (AppointmentService service : appointment.getServices()) {
            %>
            <tr>
                <td><%= index++ %>
                </td>
                <td><%= service.getDoctorService().getService().getName() %>
                </td>
                <td><%= service.getPrice() %> vnđ</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <p>Total Price:
            <span id="total-price">
                <%=
                appointment.getDoctorShift().getShiftPrice()
                        + appointment.getServices().stream()
                        .map(AppointmentService::getPrice)
                        .reduce(0, Integer::sum)
                %> vnđ
            </span>
        </p>
    </div>

    <div class="button-group">
        <button type="button" class="cancel-btn" onclick="history.back()">Cancel</button>
        <button type="button" class="confirm-btn" onclick="window.location.href = 'doAppointmentConfirm.jsp'">Confirm
        </button>
    </div>
</div>
</body>
</html>