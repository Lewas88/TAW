<%-- Julian y Enrique --%>

<%@ page import="es.uma.taw.proyectotaw.entity.Trabajador" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Actor" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Pelicula" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    boolean isEditar = true;
    Actor actor = (Actor) request.getAttribute("actor");
    List<Pelicula> peliculas= (List<Pelicula>) request.getAttribute("peliculas");
    if (actor.getId() == null) isEditar = false;
%>
<html>
<head>
    <title><%= (isEditar ? "Editar" : "Añadir") %> actor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="cabecera.jsp" />

<main class="container mt-4">
    <!-- Botón volver -->
    <div class="mb-3">
        <a href="/actores/" class="btn btn-sm btn-outline-secondary">&larr; Volver</a>
    </div>

    <!-- Contenedor imagen + formulario -->
    <div class="row align-items-start">
        <!-- Imagen -->
        <div class="col-md-4">
            <img src="/images/vacio.png" class="img-fluid rounded shadow" alt="Foto actor">
        </div>

        <!-- Formulario -->
        <div class="col-md-8">
            <div class="card shadow p-4">
                <h2 class="mb-4 text-center"><%= (isEditar ? "Editar" : "Añadir") %> actor</h2>
                <form action="/actores/guardar" method="post">
                    <input type="hidden" name="id" value="<%= (actor.getId() == null) ? -1 : actor.getId() %>">

                    <div class="mb-3">
                        <label class="form-label">Nombre</label>
                        <input type="text" class="form-control" name="nombre"
                               value="<%= (actor.getNombre() == null) ? "" : actor.getNombre() %>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Edad</label>
                        <input type="text" class="form-control" name="edad"
                               value="<%= (actor.getNombre() == null) ? "" : actor.getEdad() %>" required>
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
                        <a href="/actores/editarCasting?id=<%=actor.getId()%>" class="btn btn-sm btn-outline-secondary">
                         Editar participaciones <i class="bi bi-plus-circle"></i></a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<jsp:include page="piedepagina.jsp" />
</body>
</html>
