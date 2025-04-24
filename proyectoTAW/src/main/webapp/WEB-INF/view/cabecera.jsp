<%@ page import="java.util.Date" %>
<%@ page import="es.uma.taw.proyectotaw.entity.UsuarioEntity" %><%--
  Created by IntelliJ IDEA.
  User: guzman
  Date: 9/4/25
  Time: 12:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <%
  UsuarioEntity user = (UsuarioEntity)session.getAttribute("user");
%>

<table width="100%">
    <tr>
        <td><a href="/actores/">Actores</a></td>
        <td>Peliculas</td>
        <td><form>
            <input type="text" placeholder="Buscar..."> <input type="submit" value="Buscar">
        </form></td>
        <%
            if (user==null){
        %>
        <td><button onclick="location.href='/login/'">Iniciar Sesión</button></td>
        <td><button onclick="location.href='/login/signIn'">Registrarse</button></td>
        <%
            }else{
        %>
        <td>Bienvenido, <b><%= user.getNombre()%></b>, al sistema <br/>
            sessionid: <%= session.getId() %> <br/>
            fecha de entrada al sistema: <%= new Date(session.getCreationTime()) %> <br/>
            (<a href="/login/logout">Log Out</a>)</td>
        <%
            }
        %>
    </tr>
</table>
<br/><br/>
