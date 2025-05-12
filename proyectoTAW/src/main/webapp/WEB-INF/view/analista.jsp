<%--
  Created by IntelliJ IDEA.
  User: diegoalba
  Date: 12/5/25
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Analista</title>
</head>
<body>
<jsp:include page="cabecera.jsp" />
<%
    Long totalPeliculas = (Long) request.getAttribute("totalPeliculas");
    Long totalReviews = (Long) request.getAttribute("totalReviews");
    Long totalActores = (Long) request.getAttribute("totalActores");
    Long totalUsuarios = (Long) request.getAttribute("totalUsuarios");
%>
<table border="1">
    <tr>
        <th>Objeto</th>
        <th>Cantidad</th>
    </tr>
    <tr>
        <td>Peliculas</td>
        <td><%= totalPeliculas %></td>
    </tr>
    <tr>
        <td>Reviews</td>
        <td><%= totalReviews %></td>
    </tr>
    <tr>
        <td>Actores</td>
        <td><%= totalActores %></td>
    </tr>
    <tr>
        <td>Usuarios</td>
        <td><%= totalUsuarios %></td>
    </tr>
</table>
</body>
</html>
