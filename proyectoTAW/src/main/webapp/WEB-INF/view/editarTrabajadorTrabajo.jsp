<%-- Enrique Silveira Garcia 100% --%>

<%@ page import="es.uma.taw.proyectotaw.entity.Trabajador" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Pelicula" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Trabajador trabajador = (Trabajador) request.getAttribute("trabajador");
    List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculas");
    List<es.uma.taw.proyectotaw.entity.TrabajadorPelicula> trabajos = (List<es.uma.taw.proyectotaw.entity.TrabajadorPelicula>) request.getAttribute("trabajos");
%>
<html>
<head>
    <title>Editar participaciones trabajador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="cabecera.jsp" />

<main class="container mt-4">
    <!-- Botón volver -->
    <div class="mb-3">
        <a href="/trabajadores/" class="btn btn-sm btn-outline-secondary">&larr; Volver</a>
    </div>

    <div class="row align-items-start">
        <div class="col-md-8 offset-md-2">
            <div class="card shadow p-4">
                <h2 class="mb-4 text-center">Editar participaciones de <%= trabajador.getNombre() %></h2>
                <form action="/trabajadores/guardarParticipaciones" method="post">
                    <input type="hidden" name="id" value="<%= trabajador.getId() %>">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>Película</th>
                            <th>Participa</th>
                            <th>Trabajo</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            for (Pelicula pelicula : peliculas) {
                                boolean participa = false;
                                String trabajo = "";
                                if (trabajos != null) {
                                    for (es.uma.taw.proyectotaw.entity.TrabajadorPelicula tp : trabajos) {
                                        if (tp.getPelicula().getId().equals(pelicula.getId())) {
                                            participa = true;
                                            trabajo = tp.getTipoTrabajo() != null ? tp.getTipoTrabajo() : "";
                                            break;
                                        }
                                    }
                                }
                        %>
                        <tr>
                            <td><%= pelicula.getTitulo() %></td>
                            <td class="text-center">
                                <input type="checkbox" name="peliculasParticipadas" value="<%= pelicula.getId() %>" <%= participa ? "checked" : "" %>
                                       onchange="document.getElementById('trabajo_' + <%= pelicula.getId() %>).disabled = !this.checked;">
                            </td>
                            <td>
                                <input type="text" class="form-control" size="40" id="trabajo_<%= pelicula.getId() %>" name="trabajo" value="<%= trabajo %>" <%= participa ? "" : "disabled" %> >
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
                var textbox = document.getElementById('trabajo_' + id);
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
