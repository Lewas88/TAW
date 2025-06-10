<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="es.uma.taw.proyectotaw.entity.TipoUsuario" %>
<%--
  Created by IntelliJ IDEA.
  User: David
  Date: 09/06/2025
  Time: 18:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%
    boolean isEditar = true;
    UsuarioEntity user = (UsuarioEntity) request.getAttribute("user");
    UsuarioEntity usuario = (UsuarioEntity) request.getAttribute("usuario");
    List<TipoUsuario> lista = (List<TipoUsuario>) request.getAttribute("tipoUsuarios");
    if (usuario.getId() == null) isEditar = false;
  %>
    <title>Usuario: <%=usuario.getNombre()%></title>
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

                <div class="mb-3">
                  <label class="form-label">Tipo Usuario</label>
                  <input type="text" class="form-control" name="tipoUsuario"
                         value="<%= (usuario.getTipoUsuario().getTipo() == null) ? "" : usuario.getTipoUsuario().getTipo() %>" required>
                </div>
                <%
                  if (user.getTipoUsuario().getId() == 1) {
                %>
                <div >
                  <a href="/usuario/editar?id=<%=usuario.getId()%>" class="btn btn-primary">
                    Editar <i class="bi bi-pencil"></i>
                  </a>
                </div>
                <%
                  }
                %>
              </form>
            </div>
          </div>
        </div>
      </main>


<jsp:include page="piedepagina.jsp" />
</body>
</html>
