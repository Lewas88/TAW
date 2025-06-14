<%@ page import="es.uma.taw.proyectotaw.entity.Trabajador" %>
<%@ page import="java.util.List" %>
<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Daniel Linares 100%
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>Trabajadores</title>
    <%
        UsuarioEntity user = (UsuarioEntity) request.getAttribute("user");
        boolean puedeEditar13 = false;
        boolean puedeBorrar = false;
        if (user != null && user.getTipoUsuario() != null) { //David
            int tipoId = user.getTipoUsuario().getId();
            puedeEditar13 = (tipoId == 1 || tipoId == 3);
            puedeBorrar = (tipoId == 1);
        }
        List<Trabajador> lista = (List<Trabajador>) request.getAttribute("trabajador");
    %>
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
                if(puedeEditar13){//David
            %>
            <div class="mb-3">
                <h1 class="mb-0">Listado de Trabajadores:</h1>
                <a href="/trabajadores/editar?id=-1" class="btn btn-sm btn-outline-secondary">Añadir trabajador <i class="bi bi-plus-circle"></i></a>
            </div>
            <%
                }
            %>
            <div class="row">
                <%
                    for(Trabajador trabajador : lista) {
                %>
                <div class="col-md-3">
                    <div class="card mb-4"
                         onmouseover="this.style.transform='scale(1.05)'; this.style.boxShadow='10px 10px 3px rgba(0,0,0,0.1)';"
                         onmouseout="this.style.transform='scale(1)'; this.style.boxShadow='0 4px 8px rgba(0,0,0,0.2)';"
                         style="transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
                        <img class="card-img-top" style="height: 100%; width: 100%; display: block;" src="/images/vacio.png" data-holder-rendered="true">
                        <div class="card-body">
                            <p class="card-text"> <%= trabajador.getNombre() %> </p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <a type="button" href="/trabajadores/ver?id=<%=trabajador.getId()%>" class="btn btn-sm btn-outline-secondary">
                                        Ver <i class="bi bi-eye"></i></a>
                                    <%
                                        if(puedeEditar13){//David
                                    %>
                                    <a type="button" href="/trabajadores/editar?id=<%=trabajador.getId()%>" class="btn btn-sm btn-outline-secondary">
                                        Editar <i class="bi bi-pencil"></i></a>
                                    <%
                                        }
                                        if(puedeBorrar){//David
                                    %>
                                    <a type="button" href="/trabajadores/borrar?id=<%=trabajador.getId()%>" class="btn btn-sm btn-outline-danger">
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