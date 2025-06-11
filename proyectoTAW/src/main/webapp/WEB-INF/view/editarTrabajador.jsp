<%-- Daniel Linares 100% --%>

<%@ page import="es.uma.taw.proyectotaw.entity.Trabajador" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    boolean isEditar = true;
    Trabajador trabajador = (Trabajador) request.getAttribute("trabajador");
    if (trabajador.getId() == null) isEditar = false;
%>
<html>
<head>
    <title><%= (isEditar ? "Editar" : "Añadir") %> Trabajador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="cabecera.jsp" />

<main class="container mt-4">
    <!-- Botón volver -->
    <div class="mb-3">
        <a href="/trabajadores/" class="btn btn-sm btn-outline-secondary">&larr; Volver</a>
    </div>

    <!-- Contenedor imagen + formulario -->
    <div class="row align-items-start">
        <!-- Imagen -->
        <div class="col-md-4">
            <img src="/images/vacio.png" class="img-fluid rounded shadow" alt="Foto trabajador">
        </div>

        <!-- Formulario -->
        <div class="col-md-8">
            <div class="card shadow p-4">
                <h2 class="mb-4 text-center"><%= (isEditar ? "Editar" : "Añadir") %> Trabajador</h2>
                <form action="/trabajadores/guardar" method="post">
                    <input type="hidden" name="id" value="<%= (trabajador.getId() == null) ? -1 : trabajador.getId() %>">

                    <div class="mb-3">
                        <label class="form-label">Nombre</label>
                        <input type="text" class="form-control" name="nombre"
                               value="<%= (trabajador.getNombre() == null) ? "" : trabajador.getNombre() %>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Puesto</label>
                        <input type="text" class="form-control" name="puesto"
                               value="<%= (trabajador.getPuesto() == null) ? "" : trabajador.getPuesto() %>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Departamento</label>
                        <input type="text" class="form-control" name="departamento"
                               value="<%= (trabajador.getDepartamento() == null) ? "" : trabajador.getDepartamento() %>" required>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">Guardar</button>
                        <a href="/trabajadores/editarTrabajo?id=<%=trabajador.getId()%>" class="btn btn-sm btn-outline-secondary">
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
