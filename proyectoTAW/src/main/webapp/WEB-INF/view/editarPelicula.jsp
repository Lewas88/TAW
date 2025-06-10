<%-- Enrique Silveira 100% --%>

<%@ page import="es.uma.taw.proyectotaw.entity.Trabajador" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Actor" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Pelicula" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Pelicula pelicula = (Pelicula) request.getAttribute("pelicula");
    boolean isEditar = (pelicula.getId() != null);
%>
<html>
<head>
    <title><%= (isEditar ? "Editar" : "Añadir") %> pelicula</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="cabecera.jsp" />

<main class="container mt-4">
    <div class="mb-3">
        <a href="/peliculas/" class="btn btn-sm btn-outline-secondary">&larr; Volver</a>
    </div>

    <div class="row align-items-start">
        <div class="col-md-4">
            <img src="/images/vacio.png" class="img-fluid rounded shadow" alt="Foto pelicula">
        </div>

        <!-- Formulario -->
        <div class="col-md-8">
            <div class="card shadow p-4">
                <h2 class="mb-4 text-center"><%= (isEditar ? "Editar" : "Añadir") %> película</h2>
                <form action="/peliculas/guardar" method="post">
                    <input type="hidden" name="id" value="<%= (pelicula.getId() == null) ? -1 : pelicula.getId() %>">

                    <div class="mb-3">
                        <label class="form-label">Titulo</label>
                        <input type="text" class="form-control" name="titulo"
                               value="<%= (pelicula.getTitulo() == null) ? "" : pelicula.getTitulo() %>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Rating: </label> <%= (pelicula.getRating() == null) ? "" : pelicula.getRating() %>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Sinopsis: </label>
                        <input type="text" class="form-control" name="sinopsis"
                               value="<%= (pelicula.getSinopsis() == null) ? "" : pelicula.getSinopsis() %>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Estreno: </label>
                        <input type="date" class="form-control" name="estreno"
                               value="<%= (pelicula.getFechaEstreno() == null) ? "" : pelicula.getFechaEstreno()%>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Duracion: </label>
                        <input type="number" class="form-control" name="duracion"
                               value="<%= (pelicula.getDuracion() == null) ? "" : pelicula.getDuracion()%>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Presupuesto: </label>
                        <input type="number" class="form-control" name="presupuesto"
                               value="<%= (pelicula.getPresupuesto() == null) ? "" : pelicula.getPresupuesto()%>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Ingresos: </label>
                        <input type="number" class="form-control" name="ingresos"
                               value="<%= (pelicula.getIngresos() == null) ? "" : pelicula.getIngresos()%>" required>
                    </div>

                    <%--<div class="mb-3">
                        <label class="form-label">Peliculas en las que actua</label>
                        <select name="peliculasActor">
                            <%
                                for(Pelicula pelicula: peliculas){
                            %>
                            <option value="<%=pelicula.getId()%>"><%=pelicula.getTitulo()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>--%>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">Guardar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<jsp:include page="piedepagina.jsp" />
</body>
</html>
