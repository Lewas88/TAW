<%@ page import="java.util.Date" %>
<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Users: Julian Lemus 50% y Daniel Linares 50% --%>
<html>
<head>
    <%
        UsuarioEntity user = (UsuarioEntity)session.getAttribute("user");
    %>

    <!--<link href="/styles/cabecera.css" rel="stylesheet">-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">Home</a>

            <div class="collapse navbar-collapse">
                <ul class="navbar-nav mr-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="/peliculas/">Peliculas</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/actores/">Actores</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/trabajadores/">Trabajadores</a>
                    </li>
                    <%
                        if(user==null) {
                    %>
                        <li class="nav-item">
                            <a class="nav-link" href="/login/">Iniciar sesión</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/login/signIn">Registrarse</a>
                        </li>
                    <%
                        } else {//poner colorsito
                    %>
                    <%
                        if (user.getTipoUsuario().getId() == 5) {
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="/analista/">Analista</a>
                    </li>
                    <%
                        }
                        if(user.getTipoUsuario().getId() == 1){//David
                    %>

                        <li class="nav-item">
                            <a class="nav-link" href="/usuario/">Usuarios</a>
                        </li>
                    <%
                        }
                    %>
                        <li class="nav-item">
                            <a class="nav-link" href="/usuario/ver?id=<%= user.getId() %>">Perfil</a> <!--David-->
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/login/logout">Cerrar sesión</a>
                        </li>
                    <%
                        } if(false) {
                    %>
                    <li class="nav-item">
                        <span class="nav-link">/</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Add New Film (Editor or Admin)</a>
                    </li>
                    <%
                        }
                    %>
                </ul>
                <%
                    if(user!=null) {
                %>
                <div style="padding: 20px;">
                    <p><strong>Bienvenido:</strong> <b><%= user.getNombre() %></b></p>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </nav>
</body>
</html>
