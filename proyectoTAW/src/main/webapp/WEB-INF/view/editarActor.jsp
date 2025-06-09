<%@ page import="es.uma.taw.proyectotaw.entity.Actor" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Julian Lemus 100%
  Date: 07/04/2025
  Time: 12:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    boolean isEditar = true;
    Actor actor = (Actor) request.getAttribute("actor");
    if (actor.getId()==null) isEditar= false;

%>
<head>
    <title><%=(isEditar)? "Editar" : "Añadir"%> actor</title>
</head>
<body>
    <h1><%=(isEditar)? "Editar" : "Añadir"%> actor</h1>
    <form action="/actores/guardar" method="post">
        <input type="hidden" name="id" value="<%=(actor.getId()==null)? -1 : actor.getId()%>">
        Nombre: <input type="text" name="nombre" value="<%= (actor.getNombre()==null)? "" : actor.getNombre()%>"><br>
        Edad: <input type="number" name="edad" value="<%= (actor.getEdad()==null)? "": actor.getEdad()%>">
        <input type="submit" value="Guardar">
    </form>
</body>
</html>