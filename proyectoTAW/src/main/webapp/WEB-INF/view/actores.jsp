<%@ page import="es.uma.taw.proyectotaw.entity.Actor" %>
<%@ page import="java.util.List" %>
<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Users: DANIEL LINARES Y ENRIQUE SILVEIRA --%>
<%
    List<Actor> lista = (List<Actor>) request.getAttribute("actors");
    UsuarioEntity user = (UsuarioEntity) request.getAttribute("user");
    boolean puedeEditar13 = false;
    boolean puedeBorrar = false;
    if (user != null && user.getTipoUsuario() != null) { //David
        int tipoId = user.getTipoUsuario().getId();
        puedeEditar13 = (tipoId == 1 || tipoId == 3);
        puedeBorrar = (tipoId == 1);
    }

    int paginaActual = request.getParameter("pagina") != null ? Integer.parseInt(request.getParameter("pagina")) : 1;
    int actoresPorPagina = 12;
    int totalActores = lista.size();
    int totalPaginas = (int) Math.ceil((double) totalActores / actoresPorPagina);
    int inicio = (paginaActual - 1) * actoresPorPagina;
    int fin = Math.min(inicio + actoresPorPagina, totalActores);
%>
<html>
<head>
    <title>Catálogo de Actores</title>
</head>
<body>
<jsp:include page="cabecera.jsp" />
<main>
    <div class="album py-5 bg-light">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-3">
            <h1 class="mb-0">Listado de Actores:</h1>
            <%
                if (puedeEditar13) { //David
            %>
                <a href="/actores/editar?id=-1" class="btn btn-sm btn-outline-secondary">Añadir actor <i class="bi bi-plus-circle"></i></a>
            <% } %>
            </div>

            <div class="d-flex justify-content-between align-items-center mb-3">
                <form class="d-flex" action="/actores/buscarActores" method="get" >
                    <input class="form-control mr-2" type="search" placeholder="Search" aria-label="Search" name="busquedaNombreActor">
                </form>
            </div>

            <div class="row">
                <% for (int i = inicio; i < fin; i++) {
                    Actor actor = lista.get(i);
                %>
                <div class="col-md-3">
                    <div class="card mb-4"
                         onmouseover="this.style.transform='scale(1.05)'; this.style.boxShadow='10px 10px 3px rgba(0,0,0,0.1)';"
                         onmouseout="this.style.transform='scale(1)'; this.style.boxShadow='0 4px 8px rgba(0,0,0,0.2)';"
                         style="transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
                        <img class="card-img-top" style="height: 100%; width: 100%; display: block;" src="/images/vacio.png" alt="Imagen actor">
                        <div class="card-body">
                            <p class="card-text"><%= actor.getNombre() %></p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <a href="/actores/ver?id=<%= actor.getId() %>" class="btn btn-sm btn-outline-secondary">
                                        Ver <i class="bi bi-eye"></i></a>
                                    <%
                                        if (puedeEditar13) { //David
                                    %>
                                    <a type="button" href="/actores/editar?id=<%=actor.getId()%>" class="btn btn-sm btn-outline-secondary">
                                        Editar <i class="bi bi-pencil"></i></a>
                                    <%
                                        }
                                        if (puedeBorrar) { //David
                                    %>
                                    <a type="button" href="/actores/borrar?id=<%=actor.getId()%>" class="btn btn-sm btn-outline-danger"
                                        onclick="return confirm('¿Está seguro de que quiere borrar al actor <%= actor.getNombre() %>?')">
                                        Borrar <i class="bi bi-trash"></i>
                                    </a>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Paginación -->
            <div class="d-flex justify-content-center mt-4">
                <nav>
                    <ul class="pagination">
                        <% if (paginaActual > 1) { %>
                        <li class="page-item">
                            <a class="page-link" href="?pagina=<%= paginaActual - 1 %>">&laquo;</a>
                        </li>
                        <% } %>

                        <%
                            int maxVisibles = 3;
                            int inicioPaginado = Math.max(1, paginaActual - maxVisibles);
                            int finPaginado = Math.min(totalPaginas, paginaActual + maxVisibles);

                            if (inicioPaginado > 1) {
                        %>
                        <li class="page-item"><a class="page-link" href="?pagina=1">1</a></li>
                        <% if (inicioPaginado > 2) { %>
                        <li class="page-item disabled"><span class="page-link">...</span></li>
                        <% } %>
                        <% } %>

                        <% for (int i = inicioPaginado; i <= finPaginado; i++) { %>
                        <li class="page-item <%= (i == paginaActual) ? "active" : "" %>">
                            <a class="page-link" href="?pagina=<%= i %>"><%= i %></a>
                        </li>
                        <% } %>

                        <% if (finPaginado < totalPaginas) { %>
                        <% if (finPaginado < totalPaginas - 1) { %>
                        <li class="page-item disabled"><span class="page-link">...</span></li>
                        <% } %>
                        <li class="page-item"><a class="page-link" href="?pagina=<%= totalPaginas %>"><%= totalPaginas %></a></li>
                        <% } %>

                        <% if (paginaActual < totalPaginas) { %>
                        <li class="page-item">
                            <a class="page-link" href="?pagina=<%= paginaActual + 1 %>">&raquo;</a>
                        </li>
                        <% } %>
                    </ul>
                </nav>
            </div>

        </div>
    </div>
</main>
<jsp:include page="piedepagina.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</body>
</html>
