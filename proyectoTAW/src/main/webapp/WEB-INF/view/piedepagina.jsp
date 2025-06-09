<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %><%--
  Created by IntelliJ IDEA.
  User: Julian Lemus 100%
  Date: 26/04/2025
  Time: 17:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        UsuarioEntity user = (UsuarioEntity)session.getAttribute("user");
    %>
</head>
<body>
<footer>
    <%
        if(user!=null){
    %>
    <strong>Session ID:</strong> <%= session.getId() %> <br/>
    <strong>Fecha de entrada al sistema:</strong> <%= new java.util.Date(session.getCreationTime()) %></p>
    <%
        }
    %>
</footer>
</body>
</html>
