<%@ page import="java.util.List" %>
<%@ page import="org.thanhnd.adis_m1.model.DoctorShift" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="org.thanhnd.adis_m1.model.Appointment" %><%--
  Created by IntelliJ IDEA.
  User: thanhnguyenduc
  Date: 14/11/24
  Time: 02:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("client") == null) {
        response.sendRedirect("login.jsp");
    }

    if (session.getAttribute("appointment") == null) {
        response.sendRedirect("searchSlot.jsp");
    }

    Appointment appointment = (Appointment) session.getAttribute("appointment");
    DoctorShift doctorShift = appointment.getDoctorShift();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>
<html>
<head>
    <title>Booking Confirm</title>
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
            font-size: 18px;
            text-align: center;
            margin-top: 10px;
        }

        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
        }

        .cancel-btn, .confirm-btn {
            padding: 10px 20px;
            border: 2px solid #4b1a1a;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Confirm</h1>

    <p>Are you sure to book an appointment on <%=doctorShift.getShift().getStartTime().format(formatter)%>?</p>

    <div class="button-group">
        <button type="button" class="cancel-btn" onclick="history.back()">Cancel</button>
        <button type="button" class="confirm-btn" onclick="window.location.href='doBookingConfirm.jsp'">Confirm</button>
    </div>
</div>
</body>
</html>
