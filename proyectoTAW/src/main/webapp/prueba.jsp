<%@ page import="es.uma.taw.proyectotaw.entity.Actor" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: julia
  Date: 06/04/2025
  Time: 21:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<%
    List<Actor> lista = (List<Actor>) request.getAttribute("actors");
%>
<body>
<h1>Catálogo de libros disponibles</h1>
<p> <%= lista.getFirst().getNombre()%></p>
</body>
</html>
