<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <title>Iniciar sesión</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<h1>Iniciar sesión</h1>
<form:form action="autentica" method="post" modelAttribute="usuario">
    <table>
        <tr>
            <td>Correo:</td>
            <td><form:input path="correo" />
            </td>
        </tr>
        <tr>
            <td>Contraseña:</td>
            <td><form:password path="password"/></td>
        </tr>
        <tr>
            <td colspan="2"> <form:button> Enviar </form:button></td>
        </tr>
    </table>
</form:form>
<%= (error!=null)? error: ""%>
</body>
</html>