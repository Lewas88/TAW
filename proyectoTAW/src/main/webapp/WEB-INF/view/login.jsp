<%-- Daniel Linares 50% Julian David Lemus 50% --%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String) request.getAttribute("error");
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Iniciar sesión</title>
</head>
<body>
<jsp:include page="cabecera.jsp" />

<main class="container my-5" style="max-width: 400px;">
    <h1 class="mb-4 text-center">Iniciar sesión</h1>

    <% if (error != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= error %>
    </div>
    <% } %>

    <form:form action="autentica" method="post" modelAttribute="usuario">
        <div class="form-group">
            <label for="correo">Correo:</label>
            <form:input path="correo" cssClass="form-control" id="correo"/>
        </div>
        <div class="form-group">
            <label for="password">Contraseña:</label>
            <form:password path="password" cssClass="form-control" id="password"/>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Enviar</button>
    </form:form>
</main>

<jsp:include page="piedepagina.jsp" />
</body>
</html>
