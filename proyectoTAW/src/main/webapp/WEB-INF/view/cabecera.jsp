<%@ page import="java.util.Date" %>
<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %><%--
  Created by IntelliJ IDEA.
  User: guzman
  Date: 9/4/25
  Time: 12:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        UsuarioEntity user = (UsuarioEntity)session.getAttribute("user");
    %>

    <!--<link href="/styles/cabecera.css" rel="stylesheet">-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
                        <a class="nav-link" href="#">Series</a>
                    </li>
                    <%
                        if(user==null) {
                    %>
                        <li class="nav-item">
                            <a class="nav-link" href="/login/">Iniciar sesión</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="login/signIn">Registrarse</a>
                        </li>
                    <%
                        } else {//poner colorsito
                    %>
                        <li class="nav-item">
                            <a class="nav-link" href="/login/logout">Cerrar sesión</a>
                        </li>
                    <%
                        if (user.getTipoUsuario().getId() == 3) {
                    %>
                        <li class="nav-item">
                            <a class="nav-link" href="/analista/">ANALista</a>
                        </li>
                    <%
                        }
                    %>
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
                <form class="d-flex" action="/buscar" method="post" >
                    <input class="form-control mr-2" type="search" placeholder="Search" aria-label="Search" name="busqueda">
                </form>
            </div>
        </div>
    </nav>
</body>
</html>
