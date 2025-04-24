<%@ page contentType="text/html;charset=UTF-8" language="java" %><%--
  Created by IntelliJ IDEA.
  User: julia
  Date: 06/04/2025
  Time: 21:56
  To change this template use File | Settings | File Templates.
--%>
<html lang="en">
<head>
    <%
        String error = (String) request.getAttribute("error");
    %>
    <meta charset="UTF-8">
    <title>Registrarse</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<h1>Registrarse</h1>
<form action="/login/registra" method="post">
    <table>
        <tr>
            <td>Nombre:</td>
            <td><input type="text" name="nombre"></td>
        </tr>
        <tr>
            <td>Correo:</td>
            <td><input type="text" name="correo"></td>
        </tr>
        <tr>
            <td>Contraseña:</td>
            <td><input type="password" name="contrasena"></td>
        </tr>
        <tr>
            <td>Repite la contraseña:</td>
            <td><input type="password" name="confirm"></td>
        </tr>
        <tr>
            <td><input type="submit" value="Registrarse"></td>
        </tr>
    </table>
</form>
<%= (error!=null)? error: ""%>
</body>
</html>