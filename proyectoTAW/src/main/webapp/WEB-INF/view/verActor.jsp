<%--
  Created by IntelliJ IDEA.
  User: julia
  Date: 09/06/2025
  Time: 12:40
  To change this template use File | Settings | File Templates.
--%>
<%-- Julian Lemus y Enrique Silveira --%>

<%@ page import="es.uma.taw.proyectotaw.entity.Trabajador" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Actor" %>
<%@ page import="es.uma.taw.proyectotaw.entity.Pelicula" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Actor actor = (Actor) request.getAttribute("actor");
  List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculasParticipadas");
%>
<html>
<head>
  <title><%=actor.getNombre() %> </title>
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
        <h2 class="mb-4 text-center">Ver actor</h2>

          <div class="mb-3">
            <label class="form-label">Nombre: <%=actor.getNombre()%></label>
          </div>

          <div class="mb-3">
            <label class="form-label">Edad: <%= actor.getEdad()%></label>
          </div>

        <div class="mb-4">
          <h5>Películas en las que ha participado</h5>
          <table class="table table-sm table-hover">
            <thead>
              <tr>
                <th>Título</th>
                <th>Fecha de estreno</th>
              </tr>
            </thead>
            <tbody>
              <% for (Pelicula peli : peliculas) { %>
                <tr>
                  <td><%= peli.getTitulo() %></td>
                  <td><%= peli.getFechaEstreno() %></td>
                </tr>
              <% } %>
            </tbody>
          </table>
        </div>

        <div >
          <a href="/actores/editar?id=<%=actor.getId()%>" class="btn btn-primary">
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
