<%@ page import="es.uma.taw.proyectotaw.entity.Actor" %>
<%@ page import="java.util.List" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Pelicula" %>
<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %><%--
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
        List<Pelicula> lista = (List<Pelicula>) request.getAttribute("peliculas");
        UsuarioEntity user = (UsuarioEntity) request.getAttribute("user");
    %>
    <title>Catálogo de Películas</title>
</head>
<body>
<jsp:include page="cabecera.jsp" />

<h1>Catálogo de peliculas disponibles</h1>
<form method="post" action="/peliculas/añadir">
    <input type="submit" value="Añadir"/>
</form>
<table border="1">
    <tr>
        <th>ID</th>
        <th>TÍTULO</th>
        <th>FECHA_ESTRENO</th>
        <th>RATING</th>
        <th>DURACION</th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
    </tr>
    <%
        for (Pelicula pelicula: lista) {
    %>
    <tr>
        <td><%= pelicula.getId() %></td>
        <td><%= pelicula.getTitulo() %></td>
        <td><%= pelicula.getFechaEstreno() %></td>
        <td><%= pelicula.getRating() %> </td>
        <td><%= pelicula.getDuracion() %> </td>

        <td><form method="get" action="/peliculas/ver">
            <input type="hidden" name="id" value="<%= pelicula.getId() %>">
            <input type="submit" value="Ver"/>
        </form></td>

        <td><form method="post" action="/peliculas/editar">
            <input type="hidden" name="id" value="<%= pelicula.getId() %>">
            <input type="submit" value="Editar"/>
        </form></td>

        <%
            if(user.getTipoUsuario().getId() == 4) {
        %>
        <td><form method="post" action="/peliculas/recomendar">
            <input type="hidden" name="id" value="<%= pelicula.getId() %>">
            <input type="submit" value="Recomendar"/>
        </form></td>
        <%
            }
        %>

        <td><a href="/peliculas/borrar?id=<%= pelicula.getId() %>"  onclick="return confirm('¿Está seguro de que quiere borrar la película <%=pelicula.getTitulo() %>?')">Borrar</a></td>
    </tr>
    <%
        }
    %>
</table>
</body>
</html>
