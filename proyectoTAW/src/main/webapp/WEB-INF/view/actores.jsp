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
    <%
        List<Actor> lista = (List<Actor>) request.getAttribute("actors");
    %>
    <title>Catálogo de Actores</title>
</head>
<body>
<jsp:include page="cabecera.jsp" />

<h1>Catálogo de Actores disponibles</h1>
    <form method="post" action="/actores/editar">
        <input type="submit" value="Añadir"/>
    </form>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>NOMBRE</th>
            <th>EDAD</th>
            <th></th>
            <th></th>
        </tr>
        <%
            for (Actor actor: lista) {
        %>
        <tr>
            <td><%= actor.getId() %></td>
            <td><%= actor.getNombre() %></td>
            <td><%= actor.getEdad() %></td>
            <td><form method="post" action="/actores/editar">
                <input type="hidden" name="id" value="<%= actor.getId() %>">
                <input type="submit" value="Editar"/>
            </form></td>
            <td><a href="/actores/borrar?id=<%= actor.getId() %>"  onclick="return confirm('¿Está seguro de que quiere borrar la película <%=actor.getNombre() %>?')">Borrar</a></td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
