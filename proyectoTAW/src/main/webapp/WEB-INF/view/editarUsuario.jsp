<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %><%--
  Created by IntelliJ IDEA.
  User: David
  Date: 09/06/2025
  Time: 19:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%
    UsuarioEntity user = (UsuarioEntity) request.getAttribute("user");
  %>
    <title>Title</title>
</head>
<body>
<jsp:include page="cabecera.jsp" />
<h1>Usuario: <%=user.getNombre()%></h1>
<jsp:include page="piedepagina.jsp" />
</body>
</html>
