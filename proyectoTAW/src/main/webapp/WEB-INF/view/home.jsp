<%@ page import="es.uma.taw.proyectotaw.entity.Pelicula" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Pelicula> peliculasRecomendadas = (List<Pelicula>) request.getAttribute("peliculasRecomendadas");
    List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculas");

    int paginaActual = request.getParameter("pagina") != null ? Integer.parseInt(request.getParameter("pagina")) : 1;
    int peliculasPorPagina = 20;
    int totalPeliculas = peliculas.size();
    int totalPaginas = (int) Math.ceil((double) totalPeliculas / peliculasPorPagina);
    int inicio = (paginaActual - 1) * peliculasPorPagina;
    int fin = Math.min(inicio + peliculasPorPagina, totalPeliculas);
%>
<html>
<head>
    <title>Home</title>
    <style>
        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            filter: invert(1);
        }
    </style>
</head>
<body>
<jsp:include page="cabecera.jsp" />
<main>
    <!-- Recomendaciones destacadas, esta basado en las reviews de recomendadores, no en la calificacion que tienen las pelis de base -->
    <section class="container my-3">
        <h2 class="text-center mb-3">Recomendaciones destacadas</h2>
        <div id="carouselRecomendadas" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <%
                    int index = 0;
                    for (Pelicula peli : peliculasRecomendadas) {
                %>
                <div class="carousel-item <%= index == 0 ? "active" : "" %>">
                    <div class="d-flex justify-content-center">
                        <div class="card" style="width: 22rem;">
                            <img src="/images/vacio.png" class="card-img-top" alt="...">
                            <div class="card-body text-center">
                                <h5 class="card-title"><%= peli.getTitulo() %></h5>
                                <p class="card-text">Duración: <%= peli.getDuracion() %> min</p>
                                <a href="/peliculas/ver?id=<%= peli.getId() %>" class="btn btn-primary">Ver película</a>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                        index++;
                    }
                %>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselRecomendadas" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselRecomendadas" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
            </button>
        </div>
    </section>

    <!-- Listado de todas las películas -->
    <div class="album py-3 bg-light">
        <h2 class="text-left mb-4" style="padding-left: 15%">Películas</h2>
        <div class="container">
            <div class="row">
                <%
                    for (int i = inicio; i < fin; i++) {
                        Pelicula peli = peliculas.get(i);
                %>
                <div class="col-md-3">
                    <div class="card mb-4"
                         onmouseover="this.style.transform='scale(1.05)'; this.style.boxShadow='10px 10px 3px rgba(0,0,0,0.1)';"
                         onmouseout="this.style.transform='scale(1)'; this.style.boxShadow='0 4px 8px rgba(0,0,0,0.2)';"
                         style="transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;">
                        <img class="card-img-top" src="/images/vacio.png" style="height: 100%; width: 100%; display: block;">
                        <div class="card-body">
                            <p class="card-text"><%= peli.getTitulo() %></p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <a href="/peliculas/ver?id=<%= peli.getId() %>" class="btn btn-sm btn-outline-secondary">Ver</a>
                                </div>
                                <small class="text-muted"><%= peli.getDuracion() %> min</small>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>

            <!-- Esto es para que no aparezcan todas las pelis a la vez, va por paginas -->
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
</body>
</html>