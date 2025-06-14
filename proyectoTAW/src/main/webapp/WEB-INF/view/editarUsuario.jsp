<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="es.uma.taw.proyectotaw.entity.TipoUsuario" %><%--
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  Created by IntelliJ IDEA.
  User: David
  Date: 09/06/2025
  Time: 19:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  boolean isEditar = true;
  UsuarioEntity usuario = (UsuarioEntity) request.getAttribute("usuario");
  UsuarioEntity user = (UsuarioEntity) request.getAttribute("user");
  List<TipoUsuario> lista = (List<TipoUsuario>) request.getAttribute("tipoUsuarios");
  if (usuario.getId() == null) isEditar = false;
%>
<html>
<head>
    <title><%= (isEditar ? "Editar" : "Añadir") %> Usuario</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="cabecera.jsp" />
<main class="container mt-4">
  <!-- Botón volver -->
  <div class="mb-3">
    <a href="/usuario/" class="btn btn-sm btn-outline-secondary">&larr; Volver</a>
  </div>

  <!-- Contenedor imagen + formulario -->
  <div class="row align-items-start">
    <!-- Imagen -->
    <div class="col-md-4">
      <img src="/images/vacio.png" class="img-fluid rounded shadow" alt="Foto usuario">
    </div>

    <!-- Formulario -->
    <div class="col-md-8">
      <div class="card shadow p-4">
        <h2 class="mb-4 text-center"><%= (isEditar ? "Editar" : "Añadir") %> Usuario</h2>
        <form action="/usuario/guardar" method="post">
          <input type="hidden" name="id" value="<%= (usuario.getId() == null) ? -1 : usuario.getId() %>">

          <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" class="form-control" name="nombre"
                   value="<%= (usuario.getNombre() == null) ? "" : usuario.getNombre() %>" required>
          </div>

          <div class="mb-3">
            <label class="form-label">Correo</label>
            <input type="text" class="form-control" name="correo"
                   value="<%= (usuario.getCorreo() == null) ? "" : usuario.getCorreo() %>" required>
          </div>



          <% if (user.getTipoUsuario().getId() == 1) { %>
          <div class="mb-3">
            <label class="form-label">Tipo Usuario</label>
            <select class="form-select" name="tipoUsuario" required>
              <%
                for(TipoUsuario tipo : lista) {
                  if (tipo != null && tipo.getTipo() != null) {
                    boolean isSelected = (usuario.getTipoUsuario().getTipo()).equals(tipo.getTipo());
              %>
              <option value="<%=tipo.getId()%>" <%= isSelected ? "selected" : "" %>>
                <%=tipo.getTipo()%>
              </option>
              <%
                  }
                }
              %>
            </select>
          </div>
          <% } else { %>
          <div class="mb-3">
            <label class="form-label">Tipo Usuario</label>
            <input readonly type="text" class="form-control" name="tipoUsuario"
                   value="<%= usuario.getTipoUsuario().getTipo() %>" required>
          </div>
          <% } %>

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
