<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: David
  Date: 09/06/2025
  Time: 18:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%
    UsuarioEntity user = (UsuarioEntity) request.getAttribute("user");
    List<UsuarioEntity> listaUsuarios = (List<UsuarioEntity>) request.getAttribute("usuarios");
  %>
    <title>Usuarios</title>
</head>
<body>
<jsp:include page="cabecera.jsp" />
<main>
  <section class="jumbotron text-center">
    <div class="container">
    </div>
  </section>

  <div class="album py-5 bg-light">
    <div class="container">
      <%
        if(user.getTipoUsuario().getId() ==1 || user.getTipoUsuario().getId() ==3){
      %>
      <div class="mb-3">
        <a href="/usuario/editar?id=-1" class="btn btn-sm btn-outline-secondary">Añadir Usuario <i class="bi bi-plus-circle"></i></a>
      </div>
      <%
        }
      %>
      <div class="row">
        <%
          for(UsuarioEntity usuario : listaUsuarios) {
        %>
        <div class="col-md-3">
          <div class="card mb-4"
               onmouseover="this.style.transform='scale(1.05)'; this.style.boxShadow='10px 10px 3px rgba(0,0,0,0.1)';"
               onmouseout="this.style.transform='scale(1)'; this.style.boxShadow='0 4px 8px rgba(0,0,0,0.2)';"
               style="transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
            <img class="card-img-top" style="height: 100%; width: 100%; display: block;" src="/images/vacio.png" data-holder-rendered="true">
            <div class="card-body">
              <p class="card-text"> <%= usuario.getNombre() %> </p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <a type="button" href="/usuario/ver?id=<%=usuario.getId()%>" class="btn btn-sm btn-outline-secondary">
                    Ver <i class="bi bi-eye"></i></a>
                  <%
                    if(user.getTipoUsuario().getId() ==1 || user.getTipoUsuario().getId() ==3){
                  %>
                  <a type="button" href="/usuario/editar?id=<%=usuario.getId()%>" class="btn btn-sm btn-outline-secondary">
                    Editar <i class="bi bi-pencil"></i></a>
                  <%
                    }
                    if(user.getTipoUsuario().getId() ==1){
                  %>
                  <a type="button" href="/usuario/borrar?id=<%=usuario.getId()%>" class="btn btn-sm btn-outline-danger">
                    Borrar <i class="bi bi-trash"></i>
                  </a>
                  <%
                    }
                  %>
                </div>
                <small class="text-muted"> </small>
              </div>
            </div>
          </div>
        </div>
        <%
          }
        %>
      </div>
    </div>
  </div>
</main>
    <jsp:include page="piedepagina.jsp" />
</body>
</html>
