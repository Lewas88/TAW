<%@ page import="es.uma.taw.proyectotaw.entity.Actor" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Dalibex
  Date: 07/04/2025
  Time: 12:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Catálogo de libros disponibles</title>
</head>

<%
    List<Actor> lista = (List<Actor>) request.getAttribute("libros");
%>
<body>
<h1>Catálogo de libros disponibles</h1>

<table border="1">
    <tr>
        <th>ID</th>
        <th>NOMBRE</th>
        <th></th>
    </tr>
    <%
        for (Actor libro: lista) {
    %>
    <tr>
        <td><%= libro.getId() %></td>
        <td><%= libro.getNombre() %></td>
        <td><form method="post" action="/editar">
            <input type="hidden" name="id" value="<%= libro.getId() %>">
            <input type="submit" value="Editar"/>
        </form></td>
       </tr>
    <%
        }
    %>
</table>
</body>
</html>
