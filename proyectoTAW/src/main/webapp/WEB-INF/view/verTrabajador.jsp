<%--
  Created by IntelliJ IDEA.
  User: Daniel
  Date: 09/06/2025
  Time: 12:40
  To change this template use File | Settings | File Templates.
--%>
<%-- Daniel Linares 100% --%>

<%@ page import="es.uma.taw.proyectotaw.entity.Trabajador" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Trabajador trabajador = (Trabajador) request.getAttribute("trabajador");
%>
<html>
<head>
    <title><%=trabajador.getNombre() %> </title>
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

        <div class="col-md-8">
            <div class="card shadow p-4">
                <h2 class="mb-4 text-center">Ver trabajador</h2>

                <div class="mb-3">
                    <label class="form-label">Nombre: <%=trabajador.getNombre()%></label>
                </div>

                <div class="mb-3">
                    <label class="form-label">Puesto: <%= trabajador.getPuesto()%></label>
                </div>

                <div class="mb-3">
                        <label class="form-label">Departamento: <%= trabajador.getDepartamento()%></label>
                </div>

                <div >
                    <a href="/trabajadores/editar?id=<%=trabajador.getId()%>" class="btn btn-primary">
                        Editar <i class="bi bi-pencil"></i>
                    </a>
                </div>

            </div>
        </div>
    </div>
</main>

<jsp:include page="piedepagina.jsp" />
</body>
</html>
