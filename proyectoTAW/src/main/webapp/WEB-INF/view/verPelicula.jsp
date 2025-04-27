<%@ page import="es.uma.taw.proyectotaw.entity.PeliculaEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="es.uma.taw.proyectotaw.controller.PeliculasControlador" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <%
            PeliculaEntity pelicula = (PeliculaEntity) request.getAttribute("pelicula");
        %>
        <meta charset="UTF-8">
        <title>Ver Película</title>
    </head>
    <body>
        <jsp:include page="cabecera.jsp" />

        <%=pelicula.getTitulo()%>
    </body>
</html>
