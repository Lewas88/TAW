<!--
User: Daniel Linares y Enrique Silveira
-->

<%@ page import="es.uma.taw.proyectotaw.entity.Pelicula" %>
<%@ page import="java.util.List" %>
<%@ page import="es.uma.taw.proyectotaw.controller.PeliculasControlador" %>
<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Review" %>
<%@ page import="es.uma.taw.proyectotaw.dao.ReviewRepository" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        Pelicula pelicula = (Pelicula) request.getAttribute("pelicula");
        UsuarioEntity user = (UsuarioEntity) request.getAttribute("user");
        List<Review> reviewList = (List<Review>) request.getAttribute("reviews");
    %>
    <meta charset="UTF-8">
    <title><%= pelicula.getTitulo() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<jsp:include page="cabecera.jsp" />

<main class="container mt-4">
    <div class="mb-3">
        <a href="/peliculas/" class="btn btn-sm btn-outline-secondary">&larr; Volver</a>
    </div>

    <div class="row align-items-start">
        <div class="col-md-4">
            <img src="/images/vacio.png" class="img-fluid rounded shadow" alt="Imagen película">
        </div>

        <div class="col-md-8">
            <div class="card shadow p-4">
                <h1 class="display-4 text-center mb-2"><%= pelicula.getTitulo() %></h1>
                <p class="text-center text-muted mb-4" style="font-size: 1rem;">Estreno: <%= pelicula.getFechaEstreno() %></p>
                <table class="table border-0" style="border: none;">
                    <tr>
                        <td class="fw-bold" style="border: none; width: 100px;">Nota:</td>
                        <td style="border: none;"><%= pelicula.getRating() %></td>
                    </tr>
                    <tr>
                        <td class="fw-bold" style="border: none;">Sinopsis:</td>
                        <td style="border: none;"><%= pelicula.getSinopsis() %></td>
                    </tr>
                    <tr>
                        <td class="fw-bold" style="border: none;">Duración:</td>
                        <td style="border: none;"><%= pelicula.getDuracion()%></td>
                    </tr>
                    <tr>
                        <td class="fw-bold" style="border: none;">Presupuesto:</td>
                        <td style="border: none;"><%= pelicula.getPresupuesto() %></td>
                    </tr>
                    <tr>
                        <td class="fw-bold" style="border: none;">Ingresos:</td>
                        <td style="border: none;"><%= pelicula.getIngresos() %></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div class="row justify-content-center mt-4">
        <div class="col-md-8">
            <div class="card shadow p-4">
                <h3 class="mb-3">Añadir Review</h3>
                <form method="post" action="/peliculas/anyadirReview">
                    <input type="hidden" name="idPelicula" value="<%= pelicula.getId() %>">
                    <div class="mb-3">
                        <label class="form-label">Puntuación:</label><br>
                        <input type="radio" name="puntuacion" value="2.0" id="star1">
                        <label for="star1">★</label>
                        <input type="radio" name="puntuacion" value="4.0" id="star2">
                        <label for="star2">★★</label>
                        <input type="radio" name="puntuacion" value="6.0" id="star3">
                        <label for="star3">★★★</label>
                        <input type="radio" name="puntuacion" value="8.0" id="star4">
                        <label for="star4">★★★★</label>
                        <input type="radio" name="puntuacion" value="10.0" id="star5" checked>
                        <label for="star5">★★★★★</label>
                    </div>
                    <%
                        if (user.getTipoUsuario().getId() == 1 || user.getTipoUsuario().getId() == 3 || user.getTipoUsuario().getId() == 4) { //David
                    %>
                    <div class="mb-3">
                        <label class="form-label">Opinión:</label>
                        <textarea maxlength="500" rows="5" class="form-control" name="opinion" placeholder="Escribe aquí tu opinión (max 500 caracteres)"></textarea>
                    </div>
                    <%
                        } else {
                    %>
                             <div class="mb-3">
                                    <label class="form-label">Opinión:</label>
                                    <textarea readonly maxlength="500" rows="5" class="form-control" name="opinion" placeholder="Escribe aquí tu opinión (max 500 caracteres)"></textarea>
                             </div>

                    <%
                        }
                    %>

                    <button type="submit" class="btn btn-primary">Guardar</button>
                </form>
            </div>
        </div>
    </div>

    <div class="row justify-content-center mt-4">
        <div class="col-md-8">
            <div class="card shadow p-4">
                <h3 class="mb-3">Reviews de nuestros recomendadores:</h3>
                <% for(Review review : reviewList) { %>
                    <div class="mb-3 border-bottom pb-2">
                        <strong>User:</strong> <%= review.getUsuario().getNombre() %>
                        <% if(user != null && user.getId() == review.getUsuario().getId() || user.getTipoUsuario().getId() == 1) {// David %>
                            <form method="post" action="/peliculas/borrarReview" class="d-inline">
                                <input type="hidden" name="idReview" value="<%= review.getId() %>">
                                <button type="submit" class="btn btn-sm btn-danger ml-2">Borrar</button>
                            </form>
                        <% } %>
                        <br>
                        <strong>Review:</strong> <%= review.getComentario() %> <br>
                        <strong>Calificación:</strong> <%= review.getCalifica() %>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</main>

<jsp:include page="piedepagina.jsp" />
</body>
</html>
