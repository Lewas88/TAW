<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="es.uma.taw.proyectotaw.entity.*" %>
<%@ page import="es.uma.taw.proyectotaw.ui.Usuario" %>
<%@ include file="cabecera.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Panel de Analista</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid py-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col">
            <h2 class="mb-4">Panel de Analista</h2>
        </div>
    </div>

    <!-- Navegación y Estadísticas -->
    <div class="row">
        <div class="col-md-8">
            <!-- Navegación -->
            <div class="btn-group mb-4 w-100" role="group" aria-label="Navegación">
                <form action="/analista/elegirBuscadorDePeliculas" method="post" class="d-inline">
                    <button type="submit" class="btn btn-primary <%= request.getAttribute("buscador") != null && (Integer)request.getAttribute("buscador") == 1 ? "active" : "" %>">
                        Buscador de Películas
                    </button>
                </form>
                <form action="/analista/elegirBuscadorDeReviews" method="post" class="d-inline">
                    <button type="submit" class="btn btn-primary <%= request.getAttribute("buscador") != null && (Integer)request.getAttribute("buscador") == 2 ? "active" : "" %>">
                        Buscador de Reviews
                    </button>
                </form>
                <form action="/analista/elegirBuscadorDeActores" method="post" class="d-inline">
                    <button type="submit" class="btn btn-primary <%= request.getAttribute("buscador") != null && (Integer)request.getAttribute("buscador") == 3 ? "active" : "" %>">
                        Buscador de Actores
                    </button>
                </form>
                <form action="/analista/elegirBuscadorDeUsuarios" method="post" class="d-inline">
                    <button type="submit" class="btn btn-primary <%= request.getAttribute("buscador") != null && (Integer)request.getAttribute("buscador") == 4 ? "active" : "" %>">
                        Buscador de Usuarios
                    </button>
                </form>
                <form action="/analista/elegirBuscadorDeTrabajadores" method="post" class="d-inline">
                    <button type="submit" class="btn btn-primary <%= request.getAttribute("buscador") != null && (Integer)request.getAttribute("buscador") == 5 ? "active" : "" %>">
                        Buscador de Trabajadores
                    </button>
                </form>
            </div>
        </div>
        
        <div class="col-md-4">
            <!-- Tabla de estadísticas -->
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>Entidad</th>
                            <th>Cantidad</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Películas</td>
                            <td><%= request.getAttribute("totalPeliculas") %></td>
                        </tr>
                        <tr>
                            <td>Reviews</td>
                            <td><%= request.getAttribute("totalReviews") %></td>
                        </tr>
                        <tr>
                            <td>Actores</td>
                            <td><%= request.getAttribute("totalActores") %></td>
                        </tr>
                        <tr>
                            <td>Usuarios</td>
                            <td><%= request.getAttribute("totalUsuarios") %></td>
                        </tr>
                        <tr>
                            <td>Trabajadores</td>
                            <td><%= request.getAttribute("totalTrabajadores") %></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <%
        if (request.getAttribute("buscador") != null && (Integer)request.getAttribute("buscador") == 1) {
            FiltrosPelicula filtros = (FiltrosPelicula)request.getAttribute("filtros");
    %>
        <div class="card">
            <div class="card-body">
                <h5 class="card-title mb-4">Filtrar Películas</h5>
                <form action="/analista/filtrarPeliculas" method="post" id="filtroForm">
                    <div class="row">
                        <!-- Búsqueda por keyword -->
                        <div class="col-md-6 mb-3">
                            <label for="keyword" class="form-label">Título:</label>
                            <input type="text" class="form-control" id="keyword" name="keyword" 
                                   value="<%= filtros != null ? filtros.getKeyword() : "" %>">
                        </div>

                        <!-- Rating -->
                        <div class="col-md-6 mb-3">
                            <label for="minRating" class="form-label">Rating mínimo:</label>
                            <input type="number" class="form-control" id="minRating" name="minRating" 
                                   step="0.1" min="0" max="10" 
                                   value="<%= filtros != null ? filtros.getMinRating() : "" %>">
                        </div>

                        <!-- Ingresos -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Ingresos:</label>
                            <div class="row">
                                <div class="col">
                                    <input type="number" class="form-control" name="minIngresos" 
                                           placeholder="Mínimo" 
                                           value="<%= filtros != null ? filtros.getMinIngresos() : "" %>">
                                </div>
                                <div class="col">
                                    <input type="number" class="form-control" name="maxIngresos" 
                                           placeholder="Máximo" 
                                           value="<%= filtros != null ? filtros.getMaxIngresos() : "" %>">
                                </div>
                            </div>
                        </div>

                        <!-- Presupuesto -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Presupuesto:</label>
                            <div class="row">
                                <div class="col">
                                    <input type="number" class="form-control" name="minPresupuesto" 
                                           placeholder="Mínimo" 
                                           value="<%= filtros != null ? filtros.getMinPresupuesto() : "" %>">
                                </div>
                                <div class="col">
                                    <input type="number" class="form-control" name="maxPresupuesto" 
                                           placeholder="Máximo" 
                                           value="<%= filtros != null ? filtros.getMaxPresupuesto() : "" %>">
                                </div>
                            </div>
                        </div>

                        <!-- Fechas -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Fecha de estreno:</label>
                            <div class="row">
                                <div class="col">
                                    <input type="date" class="form-control" name="fechaInicio" 
                                           value="<%= filtros != null ? filtros.getFechaInicio() : "" %>">
                                </div>
                                <div class="col">
                                    <input type="date" class="form-control" name="fechaFin" 
                                           value="<%= filtros != null ? filtros.getFechaFin() : "" %>">
                                </div>
                            </div>
                        </div>

                        <!-- Duración -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Duración (minutos):</label>
                            <div class="row">
                                <div class="col">
                                    <input type="number" class="form-control" name="minDuracion" 
                                           placeholder="Mínima" 
                                           value="<%= filtros != null ? filtros.getMinDuracion() : "" %>">
                                </div>
                                <div class="col">
                                    <input type="number" class="form-control" name="maxDuracion" 
                                           placeholder="Máxima" 
                                           value="<%= filtros != null ? filtros.getMaxDuracion() : "" %>">
                                </div>
                            </div>
                        </div>

                        <!-- Ordenamiento -->
                        <div class="col-12 mb-3">
                            <label for="orden" class="form-label">Ordenar por:</label>
                            <select class="form-select" id="orden" name="orden">
                                <option value="">Sin orden específico</option>
                                <!-- Ordenar por Rating -->
                                <option value="ratingDesc" <%= "ratingDesc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                                    Rating (Mayor a menor)
                                </option>
                                <option value="ratingAsc" <%= "ratingAsc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                                    Rating (Menor a mayor)
                                </option>
                                <!-- Ordenar por Ingresos -->
                                <option value="ingresosDesc" <%= "ingresosDesc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                                    Ingresos (Mayor a menor)
                                </option>
                                <option value="ingresosAsc" <%= "ingresosAsc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                                    Ingresos (Menor a mayor)
                                </option>
                                <!-- Ordenar por Presupuesto -->
                                <option value="presupuestoDesc" <%= "presupuestoDesc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                                    Presupuesto (Mayor a menor)
                                </option>
                                <option value="presupuestoAsc" <%= "presupuestoAsc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                                    Presupuesto (Menor a mayor)
                                </option>
                                <!-- Ordenar por Fecha -->
                                <option value="fechaDesc" <%= "fechaDesc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                                    Fecha (Más reciente primero)
                                </option>
                                <option value="fechaAsc" <%= "fechaAsc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                                    Fecha (Más antigua primero)
                                </option>
                                <!-- Ordenar por Duración -->
                                <option value="duracionDesc" <%= "duracionDesc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                                    Duración (Mayor a menor)
                                </option>
                                <option value="duracionAsc" <%= "duracionAsc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                                    Duración (Menor a mayor)
                                </option>
                            </select>

                        </div>
                    </div>

                    <!-- Botones -->
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">Filtrar</button>
                        <button type="reset" class="btn btn-secondary">Último filtro</button>
                        <button type="button" class="btn btn-danger" 
                                onclick="document.getElementById('borrarFiltrosForm').submit();">
                            Borrar filtros
                        </button>
                    </div>
                </form>

                <!-- Formulario oculto para borrar filtros -->
                <form id="borrarFiltrosForm" action="/analista/borrarFiltros" method="post" class="d-none">
                    <input type="hidden" name="tipo" value="1">
                </form>
            </div>
        </div>
        <form action="/analista/exportarCSV" method="post" class="d-inline">
            <input type="hidden" name="tipo" value="<%= request.getAttribute("buscador") %>">
            <%
                List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculas");
                if (peliculas != null) {
                    for (Pelicula p : peliculas) {
            %>
            <input type="hidden" name="ids" value="<%= p.getId() %>">
            <%
                }
            }
            %>
            <button type="submit" class="btn btn-success">Exportar CSV</button>
        </form>
        <!-- Resultados -->
        <div class="card mt-4">
            <div class="card-body">
                <h5 class="card-title">Películas</h5>
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead class="table-dark">
                            <tr>
                                <th>Título</th>
                                <th>Puntuación</th>
                                <th>Ingresos</th>
                                <th>Presupuesto</th>
                                <th>Fecha de estreno</th>
                                <th>Duración</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (peliculas != null) {
                                    for (Pelicula pelicula : peliculas) {
                            %>
                                <tr>
                                    <td><%= pelicula.getTitulo() %></td>
                                    <td><%= pelicula.getRating() %></td>
                                    <td><%= pelicula.getIngresos() %></td>
                                    <td><%= pelicula.getPresupuesto() %></td>
                                    <td><%= pelicula.getFechaEstreno() %></td>
                                    <td><%= pelicula.getDuracion() %> min</td>
                                </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    <%
        } else if ((Integer)request.getAttribute("buscador") == 2) {
            FiltrosPelicula filtros = (FiltrosPelicula)request.getAttribute("filtros");
    %>
    <form action="/analista/filtrarReviews" method="post" id="filtroForm">
        <div class="row">
            <!-- Búsqueda por keyword -->
            <div class="col-md-6 mb-3">
                <label for="keyword" class="form-label">Película:</label>
                <input type="text" class="form-control" id="keyword" name="keyword"
                       value="<%= filtros != null ? filtros.getKeyword() : "" %>">
            </div>
            <!-- Búsqueda por keyword 2 -->
            <div class="col-md-6 mb-3">
                <label for="keyword2" class="form-label">Usuario:</label>
                <input type="text" class="form-control" id="keyword2" name="keyword2"
                       value="<%= filtros != null ? filtros.getKeyword2() : "" %>">
            </div>
            <!-- Rating -->
            <div class="col-md-6 mb-3">
                <label for="minRating" class="form-label">Rating mínimo:</label>
                <input type="number" class="form-control" id="minRating" name="minRating"
                       step="0.1" min="0" max="10"
                       value="<%= filtros != null ? filtros.getMinRating() : "" %>">
            </div>
            <!-- Fechas -->
            <div class="col-md-6 mb-3">
                <label class="form-label">Fecha de estreno:</label>
                <div class="row">
                    <div class="col">
                        <input type="date" class="form-control" name="fechaInicio"
                               value="<%= filtros != null ? filtros.getFechaInicio() : "" %>">
                    </div>
                    <div class="col">
                        <input type="date" class="form-control" name="fechaFin"
                               value="<%= filtros != null ? filtros.getFechaFin() : "" %>">
                    </div>
                </div>
            </div>

            <!-- Ordenamiento -->
            <div class="col-12 mb-3">
                <label for="orden" class="form-label">Ordenar por:</label>
                <select class="form-select" id="orden" name="orden">
                    <option value="">Sin orden específico</option>
                    <!-- Ordenar por Rating -->
                    <option value="ratingDesc" <%= "ratingDesc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                        Rating (Mayor a menor)
                    </option>
                    <option value="ratingAsc" <%= "ratingAsc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                        Rating (Menor a mayor)
                    </option>
                    <!-- Ordenar por Fecha -->
                    <option value="fechaDesc" <%= "fechaDesc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                        Fecha (Más reciente primero)
                    </option>
                    <option value="fechaAsc" <%= "fechaAsc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                        Fecha (Más antigua primero)
                    </option>
                </select>

            </div>
        </div>

        <!-- Botones -->
        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">Filtrar</button>
            <button type="reset" class="btn btn-secondary">Último filtro</button>
            <button type="button" class="btn btn-danger"
                    onclick="document.getElementById('borrarFiltrosForm').submit();">
                Borrar filtros
            </button>
        </div>
    </form>
    <form id="borrarFiltrosForm" action="/analista/borrarFiltros" method="post" class="d-none">
        <input type="hidden" name="tipo" value="2">
    </form>
    <form action="/analista/exportarCSV" method="post" class="d-inline">
        <input type="hidden" name="tipo" value="<%= request.getAttribute("buscador") %>">
        <%
            List<Review> reviews = (List<Review>) request.getAttribute("reviews");
            if (reviews != null) {
                for (Review r : reviews) {
        %>
        <input type="hidden" name="ids" value="<%= r.getId() %>">
        <%
                }
            }
        %>
        <button type="submit" class="btn btn-success">Exportar CSV</button>
    </form>
    <!-- Resultados de Reviews -->
    <div class="card mt-4">
        <div class="card-body">
            <h5 class="card-title">Reviews</h5>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead class="table-dark">
                    <tr>
                        <th>Película</th>
                        <th>Usuario</th>
                        <th>Puntuación</th>
                        <th>Comentario</th>
                        <th>Fecha</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Review review : (List<Review>)request.getAttribute("reviews")) { %>
                    <tr>
                        <td><%= review.getPelicula().getTitulo() %></td>
                        <td><%= review.getUsuario().getNombre() %></td>
                        <td><%= review.getCalifica() %></td>
                        <td><%= review.getComentario() %></td>
                        <td><%= review.getFecha() %></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%
    } else if ((Integer)request.getAttribute("buscador") == 3) {
        FiltrosPelicula filtros = (FiltrosPelicula)request.getAttribute("filtros");
    %>
    <form action="/analista/filtrarActores" method="post" id="filtroForm">
        <div class="row">
            <!-- Búsqueda por keyword -->
            <div class="col-md-6 mb-3">
                <label for="keyword" class="form-label">Nombre:</label>
                <input type="text" class="form-control" id="keyword" name="keyword"
                       value="<%= filtros != null ? filtros.getKeyword() : "" %>">
            </div>

            <!-- Ingresos -->
            <div class="col-md-6 mb-3">
                <label class="form-label">Edad:</label>
                <div class="row">
                    <div class="col">
                        <input type="number" class="form-control" name="minEdad"
                               placeholder="Mínima"
                               value="<%= filtros != null ? filtros.getMinEdad() : "" %>">
                    </div>
                    <div class="col">
                        <input type="number" class="form-control" name="maxEdad"
                               placeholder="Máxima"
                               value="<%= filtros != null ? filtros.getMaxIngresos() : "" %>">
                    </div>
                </div>
            </div>

            <!-- Ordenamiento -->
            <div class="col-12 mb-3">
                <label for="orden" class="form-label">Ordenar por:</label>
                <select class="form-select" id="orden" name="orden">
                    <option value="">Sin orden específico</option>
                    <!-- Ordenar por Edad -->
                    <option value="edadDesc" <%= "edadDesc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                        Edad (Mayor a menor)
                    </option>
                    <option value="edadAsc" <%= "edadAsc".equals(request.getAttribute("ordenSeleccionado")) ? "selected" : "" %>>
                        Edad (Menor a mayor)
                    </option>
                </select>

            </div>
        </div>

        <!-- Botones -->
        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">Filtrar</button>
            <button type="reset" class="btn btn-secondary">Último filtro</button>
            <button type="button" class="btn btn-danger"
                    onclick="document.getElementById('borrarFiltrosForm').submit();">
                Borrar filtros
            </button>
        </div>
    </form>
    <form id="borrarFiltrosForm" action="/analista/borrarFiltros" method="post" class="d-none">
        <input type="hidden" name="tipo" value="3">
    </form>
    <form action="/analista/exportarCSV" method="post" class="d-inline">
        <input type="hidden" name="tipo" value="<%= request.getAttribute("buscador") %>">
        <%
            List<Actor> actores = (List<Actor>) request.getAttribute("actores");
            if (actores != null) {
                for (Actor a : actores) {
        %>
        <input type="hidden" name="ids" value="<%= a.getId() %>">
        <%
                }
            }
        %>
        <button type="submit" class="btn btn-success">Exportar CSV</button>
    </form>
    <!-- Resultados de Actores -->
    <div class="card mt-4">
        <div class="card-body">
            <h5 class="card-title">Actores</h5>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead class="table-dark">
                    <tr>
                        <th>Nombre</th>
                        <th>Edad</th>
<%--                        <th>Películas</th>--%>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Actor actor : (List<Actor>)request.getAttribute("actores")) { %>
                    <tr>
                        <td><%= actor.getNombre() %></td>
                        <td><%= actor.getEdad() %></td>
<%--                        <td>--%>
<%--                            <% for (Pelicula pelicula : actor.getPeliculas()) { %>--%>
<%--                            <%= pelicula.getTitulo() %><br>--%>
<%--                            <% } %>--%>
<%--                        </td>--%>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%
    } else if ((Integer)request.getAttribute("buscador") == 4) {
            FiltrosPelicula filtros = (FiltrosPelicula)request.getAttribute("filtros");
    %>
    <form action="/analista/filtrarUsuarios" method="post" id="filtroForm">
        <div class="row">
            <!-- Búsqueda por keyword -->
            <div class="col-md-6 mb-3">
                <label for="keyword" class="form-label">Nombre:</label>
                <input type="text" class="form-control" id="keyword" name="keyword"
                       value="<%= filtros != null ? filtros.getKeyword() : "" %>">
            </div>
            <!-- Búsqueda por keyword 2 -->
            <div class="col-md-6 mb-3">
                <label for="keyword2" class="form-label">Correo:</label>
                <input type="text" class="form-control" id="keyword2" name="keyword2"
                       value="<%= filtros != null ? filtros.getKeyword2() : "" %>">
            </div>
            <!-- Selección de tipo de usuario -->
            <div class="col-md-6 mb-3">
                <label for="tipoUsuario" class="form-label">Tipo de Usuario:</label>
                <select class="form-select" id="tipoUsuario" name="tipoUsuario">
                    <option value="">Todos</option>
                    <option value="1" <%= "1".equals(String.valueOf(request.getAttribute("tipoUsuarioSeleccionado"))) ? "selected" : "" %>>Admin</option>
                    <option value="2" <%= "2".equals(String.valueOf(request.getAttribute("tipoUsuarioSeleccionado"))) ? "selected" : "" %>>Usuario</option>
                    <option value="3" <%= "3".equals(String.valueOf(request.getAttribute("tipoUsuarioSeleccionado"))) ? "selected" : "" %>>Editor</option>
                    <option value="4" <%= "4".equals(String.valueOf(request.getAttribute("tipoUsuarioSeleccionado"))) ? "selected" : "" %>>Recomendador</option>
                    <option value="5" <%= "5".equals(String.valueOf(request.getAttribute("tipoUsuarioSeleccionado"))) ? "selected" : "" %>>Analista</option>
                </select>
            </div>
        </div>

        <!-- Botones -->
        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">Filtrar</button>
            <button type="reset" class="btn btn-secondary">Último filtro</button>
            <button type="button" class="btn btn-danger"
                    onclick="document.getElementById('borrarFiltrosForm').submit();">
                Borrar filtros
            </button>
        </div>
    </form>
    <form id="borrarFiltrosForm" action="/analista/borrarFiltros" method="post" class="d-none">
        <input type="hidden" name="tipo" value="4">
    </form>
    <form action="/analista/exportarCSV" method="post" class="d-inline">
        <input type="hidden" name="tipo" value="<%= request.getAttribute("buscador") %>">
        <%
            List<UsuarioEntity> usuarios = (List<UsuarioEntity>) request.getAttribute("usuarios");
            if (usuarios != null) {
                for (UsuarioEntity u : usuarios) {
        %>
        <input type="hidden" name="ids" value="<%= u.getId() %>">
        <%
                }
            }
        %>
        <button type="submit" class="btn btn-success">Exportar CSV</button>
    </form>
    <!-- Resultados de Usuarios -->
    <div class="card mt-4">
        <div class="card-body">
            <h5 class="card-title">Usuarios</h5>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead class="table-dark">
                    <tr>
                        <th>Nombre</th>
                        <th>Correo</th>
                        <th>Tipo Usuario</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (UsuarioEntity usuario : (List<UsuarioEntity>)request.getAttribute("usuarios")) { %>
                    <tr>
                        <td><%= usuario.getNombre() %></td>
                        <td><%= usuario.getCorreo() %></td>
                        <td><%= usuario.getTipoUsuario().getTipo() %></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%
    } else if ((Integer)request.getAttribute("buscador") == 5) {
            FiltrosPelicula filtros = (FiltrosPelicula)request.getAttribute("filtros");
    %>
    <form action="/analista/filtrarTrabajadores" method="post" id="filtroForm">
        <div class="row">
            <!-- Búsqueda por keyword -->
            <div class="col-md-6 mb-3">
                <label for="keyword" class="form-label">Nombre:</label>
                <input type="text" class="form-control" id="keyword" name="keyword"
                       value="<%= filtros != null ? filtros.getKeyword() : "" %>">
            </div>
            <!-- Búsqueda por keyword 2 -->
            <div class="col-md-6 mb-3">
                <label for="keyword2" class="form-label">Puesto:</label>
                <input type="text" class="form-control" id="keyword2" name="keyword2"
                       value="<%= filtros != null ? filtros.getKeyword2() : "" %>">
            </div>
            <!-- Búsqueda por keyword 3 -->
            <div class="col-md-6 mb-3">
                <label for="keyword2" class="form-label">Departamento:</label>
                <input type="text" class="form-control" id="keyword3" name="keyword3"
                       value="<%= filtros != null ? filtros.getKeyword3() : "" %>">
            </div>
        </div>

        <!-- Botones -->
        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">Filtrar</button>
            <button type="reset" class="btn btn-secondary">Último filtro</button>
            <button type="button" class="btn btn-danger"
                    onclick="document.getElementById('borrarFiltrosForm').submit();">
                Borrar filtros
            </button>
        </div>
    </form>
    <form id="borrarFiltrosForm" action="/analista/borrarFiltros" method="post" class="d-none">
        <input type="hidden" name="tipo" value="5">
    </form>
    <form action="/analista/exportarCSV" method="post" class="d-inline">
        <input type="hidden" name="tipo" value="<%= request.getAttribute("buscador") %>">
        <%
            List<Trabajador> trabajadores = (List<Trabajador>) request.getAttribute("trabajadores");
            if (trabajadores != null) {
                for (Trabajador t : trabajadores) {
        %>
        <input type="hidden" name="ids" value="<%= t.getId() %>">
        <%
                }
            }
        %>
        <button type="submit" class="btn btn-success">Exportar CSV</button>
    </form>
    <!-- Resultados de Trabajadores -->
    <div class="card mt-4">
        <div class="card-body">
            <h5 class="card-title">Trabajadores</h5>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead class="table-dark">
                    <tr>
                        <th>Nombre</th>
                        <th>Puesto</th>
<%--                        <th>Películas</th>--%>
                        <th>Departamento</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Trabajador trabajador : (List<Trabajador>)request.getAttribute("trabajadores")) { %>
                    <tr>
                        <td><%= trabajador.getNombre() %></td>
                        <td><%= trabajador.getPuesto() %></td>
<%--                        <td>--%>
<%--                            <% for (Pelicula pelicula : trabajador.getPeliculas()) { %>--%>
<%--                            <%= pelicula.getTitulo() %><br>--%>
<%--                            <% } %>--%>
<%--                        </td>--%>
                        <td><%= trabajador.getDepartamento() %></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%
        }
    %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>