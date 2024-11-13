<%--
  Created by IntelliJ IDEA.
  User: thanhnguyenduc
  Date: 12/11/24
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Login</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            box-sizing: border-box;
        }

        .login-container {
            background: white;
            border-radius: 8px;
            padding: 40px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 500px;
            text-align: center;
        }

        .login-container h1 {
            margin-bottom: 20px;
            color: #333;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group label {
            display: block;
            font-size: 14px;
            color: #555;
            margin-bottom: 5px;
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        .input-group input:focus {
            border-color: #ad171d;
            outline: none;
        }

        .btn {
            background-color: #ad171d;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            width: 100%;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #97151a;
        }

        .error-message {
            color: #97151a;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h1>Login</h1>

    <!-- JSP form -->
    <form action="doLogin.jsp" method="post" onsubmit="setLoadingState()">
        <div class="input-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username"
                   value="<%= session.getAttribute("loginUsername") != null ? session.getAttribute("loginUsername") : "" %>"
                   required>
        </div>

        <div class="input-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password"
                   value="<%= session.getAttribute("loginPassword") != null ? session.getAttribute("loginPassword") : "" %>"
                   required>
        </div>

        <button type="submit" id="loginButton" class="btn">Login</button>
        <% if (request.getParameter("error") != null) { %>
        <div class="error-message">Invalid username or password. Please try again.</div>
        <% } %>
    </form>

    <script>
			function setLoadingState() {
				const loginButton = document.getElementById('loginButton');
				loginButton.disabled = true;
				loginButton.textContent = 'Loading...';
			}
    </script>
</div>

</body>
</html>