<%--
  Created by IntelliJ IDEA.
  User: thanhnguyenduc
  Date: 12/11/24
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.thanhnd.adis_m1.model.Client" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Client Home Page</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 90vh;
            box-sizing: border-box;
            gap: 10px;
        }

        h1 {
            font-size: 36px;
        }

        button {
            width: 400px;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            border: 2px solid #e3a4a7;
        }

        button:hover {
            background-color: #e3a4a7;
        }
    </style>
</head>
<body>
<h1>Client Home Page</h1>
<h3>
    Welcome <%= ((Client) session.getAttribute("client")).getFullName() %>
</h3>
<button onclick="window.location.href='searchSlot.jsp'">Book Appointment</button>
<button onclick="window.location.href='appointmentList.jsp'">Choose Doctor and Services</button>
</body>
</html>