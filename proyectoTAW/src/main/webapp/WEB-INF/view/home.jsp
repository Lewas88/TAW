<%@ page import="es.uma.taw.proyectotaw.entity.Pelicula" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Daniel Linares --%>
<%
    List<Pelicula> peliculasRecomendadas = (List<Pelicula>) request.getAttribute("peliculasRecomendadas");
    Map<String, List<Pelicula>> peliculasPorGenero = (Map<String, List<Pelicula>>) request.getAttribute("peliculasPorGenero");
%>
<html>
<head>
    <title>Home</title>
    <style>
        .scroll-container {
            overflow-x: auto;
            scroll-behavior: smooth;
        }
    </style>
</head>
<body>
<jsp:include page="cabecera.jsp" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<main>
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
                                <h5 class="card-title text-truncate" title="<%= peli.getTitulo() %>"><%= peli.getTitulo() %></h5>
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
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselRecomendadas" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>
    </section>

    <%
        for (Map.Entry<String, List<Pelicula>> entry : peliculasPorGenero.entrySet()) {
            String genero = entry.getKey();
            List<Pelicula> listaPeliculas = entry.getValue();
            String containerId = "scroll" + genero.replaceAll("\\s+", "");
    %>
    <div class="container my-3">
        <h2 class="mb-4"><%= genero %></h2>
        <div class="d-flex align-items-center">
            <button class="btn btn-outline-primary me-4" type="button" onclick="scrollContainerLeft('<%= containerId %>')">&lt;</button>

            <div id="<%= containerId %>" class="d-flex flex-row flex-nowrap scroll-container">
                <%
                    int tarjetasAMostrar = Math.min(20, listaPeliculas.size());
                    for (int i = 0; i < tarjetasAMostrar; i++) {
                        Pelicula peli = listaPeliculas.get(i);
                %>
                <div class="card flex-shrink-0 me-3" style="width: 16rem;">
                    <img src="/images/vacio.png" class="card-img-top" style="height: 300px; width: 100%; object-fit: cover;" alt="Imagen película">
                    <div class="card-body p-3">
                        <h5 class="card-title text-truncate mb-2" title="<%= peli.getTitulo() %>" style="font-size: 1.1rem;"><%= peli.getTitulo() %></h5>
                        <p class="card-text mb-1" style="font-size: 1rem;"><small class="text-muted">Estreno: <%= peli.getFechaEstreno() %></small></p>
                        <p class="card-text mb-1" style="font-size: 1rem;"><strong>Rating:</strong> <%= peli.getRating() %></p>
                        <p class="card-text mb-2" style="font-size: 1rem;"><strong>Duración:</strong> <%= peli.getDuracion() %> min</p>
                        <a href="/peliculas/ver?id=<%=peli.getId()%>" class="btn btn-sm btn-outline-secondary">Ver <i class="bi bi-eye"></i></a>
                    </div>
                </div>
                <% } %>
            </div>

            <button class="btn btn-outline-primary ms-4" type="button" onclick="scrollContainerRight('<%= containerId %>')">&gt;</button>
        </div>
    </div>
    <%
        }
    %>

</main>
<jsp:include page="piedepagina.jsp" />
<script>
    function scrollContainerLeft(id) {
        const cont = document.getElementById(id);
        if (cont) {
            cont.scrollBy({ left: -300, behavior: 'smooth' });
        }
    }
    function scrollContainerRight(id) {
        const cont = document.getElementById(id);
        if (cont) {
            cont.scrollBy({ left: 300, behavior: 'smooth' });
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>