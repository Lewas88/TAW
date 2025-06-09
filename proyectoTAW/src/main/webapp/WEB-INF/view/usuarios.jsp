<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: David
  Date: 09/06/2025
  Time: 18:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%
    UsuarioEntity user = (UsuarioEntity) request.getAttribute("user");
    List<UsuarioEntity> listaUsuarios = (List<UsuarioEntity>) request.getAttribute("usuarios");
  %>
    <title>Listado de Usuarios</title>
</head>
<body>
<jsp:include page="cabecera.jsp" />
<h1>Listado de Usuarios</h1>
<table border="1">
  <tr>
    <th>ID</th>
    <th>NOMBRE</th>
    <th>CORREO</th>
    <th>ROL_USUARIO</th>
    <th></th>
    <th></th>
    <th></th>


  </tr>
    <%
        for (UsuarioEntity usuario: listaUsuarios) {
    %>
  <tr>
    <td><%= usuario.getId() %></td>
    <td><%= usuario.getNombre() %></td>
    <td><%= usuario.getCorreo() %></td>
    <td><%= usuario.getTipoUsuario().getTipo() %> </td>
    <td><form method="get" action="/usuario/ver">
      <input type="hidden" name="id" value="<%= usuario.getId() %>">
      <input type="submit" value="Ver"/>
    </form></td>

    <td><form method="get" action="/usuario/editar">
      <input type="hidden" name="id" value="<%= usuario.getId() %>">
      <input type="submit" value="Editar"/>
    </form></td>
      <%
      }
  %>
    <jsp:include page="piedepagina.jsp" />
</body>
</html>
