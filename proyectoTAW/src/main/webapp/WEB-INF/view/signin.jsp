<%-- Daniel Linares 50% Julian David Lemus 50% --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String) request.getAttribute("error");
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registrarse</title>
</head>
<body>
<jsp:include page="cabecera.jsp" />

<main class="container my-5" style="max-width: 500px;">
    <h1 class="mb-4 text-center">Registrarse</h1>

    <% if (error != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= error %>
    </div>
    <% } %>

    <form action="/login/registra" method="post">
        <div class="form-group">
            <label for="nombre">Nombre:</label>
            <input type="text" class="form-control" id="nombre" name="nombre" required>
        </div>
        <div class="form-group">
            <label for="correo">Correo:</label>
            <input type="email" class="form-control" id="correo" name="correo" required>
        </div>
        <div class="form-group">
            <label for="contrasena">Contraseña:</label>
            <input type="password" class="form-control" id="contrasena" name="contrasena" required>
        </div>
        <div class="form-group">
            <label for="confirm">Repite la contraseña:</label>
            <input type="password" class="form-control" id="confirm" name="confirm" required>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Registrarse</button>
    </form>
</main>

<jsp:include page="piedepagina.jsp" />
</body>
</html>
