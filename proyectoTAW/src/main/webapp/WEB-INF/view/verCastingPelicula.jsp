<!--
User: Enrique Silveira García 100%
-->

<%@ page import="es.uma.taw.proyectotaw.entity.Pelicula" %>
<%@ page import="java.util.List" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Actor" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Trabajador" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        Pelicula pelicula = (Pelicula) request.getAttribute("pelicula");
        List<Actor> casting = (List<Actor>) request.getAttribute("casting");
        List<Trabajador> trabajadores = (List<Trabajador>) request.getAttribute("trabajadores");
    %>
    <meta charset="UTF-8">
    <title><%= pelicula.getTitulo() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<jsp:include page="cabecera.jsp" />

<main class="container mt-4">
    <div class="mb-3">
        <a href="/peliculas/" class="btn btn-sm btn-outline-secondary">&larr; Volver</a>
    </div>

    <!-- Tabla de película -->
    <table class="table table my-4">
        <thead>
            <tr>
                <th>Título</th>
                <th>Fecha de estreno</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><%= pelicula.getTitulo() %></td>
                <td><%= pelicula.getFechaEstreno() %></td>
            </tr>
        </tbody>
    </table>

    <!-- Tabla de actores y trabajadores -->
    <table class="table table-sm table-hover">
        <thead>
            <tr>
                <th>Ocupación</th>
                <th>Puesto - Departamento</th>
                <th>Nombre</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <%-- Actores --%>
            <% for (Actor actor : casting) { %>
                <tr>
                    <td>Actor</td>
                    <td></td>
                    <td><%= actor.getNombre() %></td>
                    <td><a href="/actores/ver?id=<%= actor.getId() %>">Ver</a></td>
                </tr>
            <% } %>
            <%-- Trabajadores --%>
            <% for (Trabajador trabajador : trabajadores) { %>
                <tr>
                    <td>Trabajador</td>
                    <td><%= trabajador.getPuesto() %> - <%= trabajador.getDepartamento() %></td>
                    <td><%= trabajador.getNombre() %></td>
                    <td><a href="/trabajadores/ver?id=<%= trabajador.getId() %>">Ver</a></td>
                </tr>
            <% } %>
        </tbody>
    </table>
</main>

<jsp:include page="piedepagina.jsp" />
</body>
</html>
