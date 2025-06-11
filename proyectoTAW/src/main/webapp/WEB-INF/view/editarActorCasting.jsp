<%-- Enrique Silveira Garcia 100% --%>

<%@ page import="es.uma.taw.proyectotaw.entity.Actor" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Pelicula" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Actor actor = (Actor) request.getAttribute("actor");
    List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculas");
    List<Pelicula> peliculasParticipadas = (List<Pelicula>) request.getAttribute("peliculasParticipadas");
%>
<html>
<head>
    <title>Editar participaciones actor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="cabecera.jsp" />

<main class="container mt-4">
    <!-- Botón volver -->
    <div class="mb-3">
        <a href="/actores/" class="btn btn-sm btn-outline-secondary">&larr; Volver</a>
    </div>

    <div class="row align-items-start">
        <div class="col-md-8 offset-md-2">
            <div class="card shadow p-4">
                <h2 class="mb-4 text-center">Editar participaciones de <%= actor.getNombre() %></h2>
                <form action="/actores/guardarParticipaciones" method="post">
                    <input type="hidden" name="id" value="<%= actor.getId() %>">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Película</th>
                                <th>Participa</th>
                                <th>Personaje</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            List<es.uma.taw.proyectotaw.entity.Casting> castings = (List<es.uma.taw.proyectotaw.entity.Casting>) request.getAttribute("casting");
                            for (Pelicula pelicula : peliculas) {
                                boolean participa = peliculasParticipadas != null && peliculasParticipadas.contains(pelicula);
                                String personaje = "";
                                if (participa && castings != null) {
                                    for (es.uma.taw.proyectotaw.entity.Casting c : castings) {
                                        if (c.getPelicula().getId().equals(pelicula.getId())) {
                                            personaje = c.getPersonaje() != null ? c.getPersonaje() : "";
                                            break;
                                        }
                                    }
                                }
                        %>
                            <tr>
                                <td><%= pelicula.getTitulo() %></td>
                                <td class="text-center">
                                    <input type="checkbox" name="peliculasParticipadas" value="<%= pelicula.getId() %>" <%= participa ? "checked" : "" %>
                                        onchange="document.getElementById('personaje_' + <%= pelicula.getId() %>).disabled = !this.checked;">
                                </td>
                                <td>
                                    <input type="text" class="form-control" size="40" id="personaje_<%= pelicula.getId() %>" name="personaje" value="<%= personaje %>" <%= participa ? "" : "disabled" %> >
                                </td>
                            </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">Guardar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<jsp:include page="piedepagina.jsp" />

<script>
    document.addEventListener("DOMContentLoaded", function() {
        document.querySelectorAll('input[type="checkbox"][name="peliculasParticipadas"]').forEach(function(checkbox) {
            checkbox.addEventListener('change', function() {
                var id = this.value;
                var textbox = document.getElementById('personaje_' + id);
                if (textbox) {
                    textbox.disabled = !this.checked;
                    if (!this.checked) {
                        textbox.value = "";
                    }
                }
            });
        });
    });
</script>
</body>
</html>
