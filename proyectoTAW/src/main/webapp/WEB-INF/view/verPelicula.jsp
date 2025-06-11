<!--
User: Daniel Linares 100%
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
        <title>Ver Película</title>
        <br>
    </head>
    <body>
        <jsp:include page="cabecera.jsp" />

        <%=pelicula.getTitulo()%>

        <%
            // Activar si se quiere que solo los recomendadores hagan las reviews en las películas
            // if(user.getTipoUsuario().getId() == 4) {
        %>
            <br>
            Añadir Review
            <br>
        <form method="post" action="/peliculas/anyadirReview">
            <p>Puntuación:</p>
            <div>
                <input type="hidden" name="idPelicula" value="<%= pelicula.getId() %>">

                <input type="radio" name="puntuacion" value="1.0" id="star1">
                <label for="star1">★</label>

                <input type="radio" name="puntuacion" value="2.0" id="star2">
                <label for="star2">★★</label>

                <input type="radio" name="puntuacion" value="3.0" id="star3">
                <label for="star3">★★★</label>

                <input type="radio" name="puntuacion" value="4.0" id="star4">
                <label for="star4">★★★★</label>

                <input type="radio" name="puntuacion" value="5.0" id="star5" checked>
                <label for="star5">★★★★★</label>
            </div>

            <p>Opinión:</p>
            <textarea maxlength="500" rows="10" cols="50" name="opinion" placeholder="Escribe aquí tu opinión de mierda (max 500 caracteres)"></textarea>

            <br>
            <input type="submit" value="Guardar">
        </form>
        <%
            //}
        %>

        <br>
        Reviews de nuestros recomendadores:
        <%
            for(Review review : reviewList) {
        %>
            <br> User: <%= review.getUsuario().getNombre() %>
            <%
                if(user.getId() == review.getUsuario().getId()) {
            %>
                <form method="post" action="/peliculas/borrarReview">
                    <input type="hidden" name="idReview" value="<%= review.getId() %>">
                    <input type="submit" value="Borrar">
                </form>
            <%
                }
            %>
            <br>
            Review: <%= review.getComentario() %> <br>
            Calificación: <%= review.getCalifica() %> <br>
        <%
            }
        %>
    </body>
</html>
