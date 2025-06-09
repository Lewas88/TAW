<%@ page import="es.uma.taw.proyectotaw.entity.Actor" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %><%--
  Created by IntelliJ IDEA.
  User: julian Lemus
  Date: 06/04/2025
  Time: 21:56
  To change this template use File | Settings | File Templates.
--%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>A Web Page</title>
    <link rel="stylesheet" href="styles.css">
</head>
<%
    Actor actor = (Actor) request.getAttribute("actor");
%>
<body>
<header>
    <nav>
        <ul>
            <li><a href="#">Home</a></li>
            <li><a href="#">Films</a></li>
            <li><a href="#">Series</a></li>
            <li><a href="#">Log In</a></li>
        </ul>
        <input type="text" placeholder="Search">
    </nav>
</header>

<main>
    <section class="profile">
        <div class="left">
            <h2><%=actor.getNombre()%></h2>
            <div class="profile-img"></div>
            <div class="info">
                <h3>Info</h3>
                <p>Edad: <%= actor.getEdad()%></p>
                <!-- Más info -->
            </div>
        </div>
        <div class="right">
            <div class="bio">
                <h3>Bio:</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.</p>
                <p><strong>State:</strong> ...</p>
            </div>
            <div class="films">
                <h3>Films</h3>
                <div class="film-list">
                    <div class="film"></div>
                    <div class="film"></div>
                    <div class="film"></div>
                    <div class="film"></div>
                </div>
            </div>
        </div>
    </section>
</main>
</body>
</html>
