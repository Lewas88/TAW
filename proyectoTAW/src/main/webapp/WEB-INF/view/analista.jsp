<%@ page import="java.util.List" %>
<%@ page import="es.uma.taw.proyectotaw.entity.PeliculaEntity" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Review" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Actor" %>
<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %><%--
  Created by IntelliJ IDEA.
  User: diegoalba
  Date: 12/5/25
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Analista</title>
</head>
<body>
<jsp:include page="cabecera.jsp" />
<%
    List<PeliculaEntity> peliculas = (List<PeliculaEntity>) request.getAttribute("peliculas");
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
    List<Actor> actores = (List<Actor>) request.getAttribute("actores");
    List<UsuarioEntity> usuarios = (List<UsuarioEntity>) request.getAttribute("usuarios");
    Long totalPeliculas = (Long) request.getAttribute("totalPeliculas");
    Long totalReviews = (Long) request.getAttribute("totalReviews");
    Long totalActores = (Long) request.getAttribute("totalActores");
    Long totalUsuarios = (Long) request.getAttribute("totalUsuarios");
    Integer buscador = (Integer) request.getAttribute("buscador");
%>
<form action="/analista/elegirBuscadorDePeliculas" method="post">
    <input type="submit" value="Buscador de Peliculas">
</form>
<form action="/analista/elegirBuscadorDeReviews" method="post">
    <input type="submit" value="Buscador de Reviews">
</form>
<form action="/analista/elegirBuscadorDeActores" method="post">
    <input type="submit" value="Buscador de Actores">
</form>
<form action="/analista/elegirBuscadorDeUsuarios" method="post">
    <input type="submit" value="Buscador de Usuarios">
</form>
<table border="1">
    <tr>
        <th>Entidad</th>
        <th>Cantidad</th>
    </tr>
    <tr>
        <td>Peliculas</td>
        <td><%= totalPeliculas %></td>
    </tr>
    <tr>
        <td>Reviews</td>
        <td><%= totalReviews %></td>
    </tr>
    <tr>
        <td>Actores</td>
        <td><%= totalActores %></td>
    </tr>
    <tr>
        <td>Usuarios</td>
        <td><%= totalUsuarios %></td>
    </tr>
</table>
<%
    if (buscador == 0) {
    } else if (buscador == 1){
%>
<form action="/analista/filtrarPeliculas" method="post">
    <h3>Filtrar películas</h3>

    <!-- Palabra clave en título o sinopsis -->
    <label for="keyword">Palabra clave:</label>
    <input type="text" name="keyword" id="keyword" />

    <!-- Rango de ingresos -->
    <label for="minIngresos">Ingresos (mín):</label>
    <input type="number" name="minIngresos" id="minIngresos" />

    <label for="maxIngresos">Ingresos (máx):</label>
    <input type="number" name="maxIngresos" id="maxIngresos" />

    <!-- Rango de presupuesto -->
    <label for="minPresupuesto">Presupuesto (mín):</label>
    <input type="number" name="minPresupuesto" id="minPresupuesto" />

    <label for="maxPresupuesto">Presupuesto (máx):</label>
    <input type="number" name="maxPresupuesto" id="maxPresupuesto" />

    <!-- Rango de fechas -->
    <label for="fechaInicio">Fecha desde:</label>
    <input type="date" name="fechaInicio" id="fechaInicio" />

    <label for="fechaFin">Fecha hasta:</label>
    <input type="date" name="fechaFin" id="fechaFin" />

    <!-- Rango de rating -->
    <label for="minRating">Rating (mín):</label>
    <input type="number" step="0.1" name="minRating" id="minRating" min="0" max="10" />

    <!-- Duración -->
    <label for="minDuracion">Duración mínima (minutos):</label>
    <input type="number" name="minDuracion" id="minDuracion" />

    <label for="maxDuracion">Duración máxima (minutos):</label>
    <input type="number" name="maxDuracion" id="maxDuracion" />

    <!-- Orden -->
    <label for="orden">Ordenar por:</label>
    <select name="orden" id="orden">
        <option value="ingresosDesc">Ingresos (mayor a menor)</option>
        <option value="ingresosAsc">Ingresos (menor a mayor)</option>
        <option value="ratingDesc">Rating (mayor a menor)</option>
        <option value="fechaDesc">Fecha de estreno (más reciente primero)</option>
    </select>

    <br><br>
    <input type="submit" value="Filtrar" />
</form>
<table border="1">
    Peliculas
    <tr>
        <th>Titulo</th>
        <th>Fecha Estreno</th>
        <th>Sinopsis</th>
        <th>Presupuesto</th>
        <th>Ingresos</th>
        <th>Rating</th>
        <th>Duracion</th>
    </tr>
    <% for (PeliculaEntity pelicula : peliculas) { %>
    <tr>
        <td><%= pelicula.getTitulo() %></td>
        <td><%= pelicula.getFechaEstreno() %></td>
        <td><%= pelicula.getSinopsis() %></td>
        <td><%= pelicula.getPresupuesto() %></td>
        <td><%= pelicula.getIngresos() %></td>
        <td><%= pelicula.getRating() %></td>
        <td><%= pelicula.getDuracion() %></td>
    </tr>
    <% } %>
</table>
<%
    } else if (buscador == 2) {
%>
<table border="1">
    Reviews
    <tr>
        <th>Calificacion</th>
        <th>Comentario</th>
        <th>Fecha</th>
    </tr>
    <% for (Review review : reviews) { %>
    <tr>
        <td><%= review.getCalifica() %></td>
        <td><%= review.getComentario() %></td>
        <td><%= review.getFecha() %></td>
    </tr>
    <% } %>
</table>
<%
} else if (buscador == 3) {
%>
<table border="1">
    Actores
    <tr>
        <th>Nombre</th>
        <th>Edad</th>
    </tr>
    <% for (Actor actor : actores) { %>
    <tr>
        <td><%= actor.getNombre() %></td>
        <td><%= actor.getEdad() %></td>
    </tr>
    <% } %>
</table>
<%
} else if (buscador == 4) {
%>
<table border="1">
    Usuarios
    <tr>
        <th>Nombre</th>
        <th>Correo</th>
        <th>Tipo de Usuario</th>
    </tr>
    <% for (UsuarioEntity usuario : usuarios) { %>
    <tr>
        <td><%= usuario.getNombre() %></td>
        <td><%= usuario.getCorreo() %></td>
        <td><%= usuario.getTipoUsuario().getTipo() %></td>
    </tr>
    <% } %>
</table>
<%
    }
%>
</body>
</html>
