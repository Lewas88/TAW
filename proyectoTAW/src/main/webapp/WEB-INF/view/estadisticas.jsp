<%--
  Created by IntelliJ IDEA.
  User: diegoalba
  Date: 11/6/25
  Time: 21:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Estadísticas del sistema</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<!-- Toggle Estadísticas Button -->
<div class="container mt-3">
  <button id="toggleEstadisticasBtn" type="button" class="btn btn-outline-info btn-sm mb-3">
    Ocultar Estadísticas
  </button>
</div>
<div id="estadisticas-container">
<div class="container my-3">
  <table border="0" style="width:100%;">
    <tr>
      <td style="vertical-align:top;">
        <div class="table-responsive">
        <table class="table table-sm table-striped table-bordered">
          <thead class="table-dark">
          <tr>
            <th>Entidad</th>
            <th>Cantidad</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>Películas</td>
            <td>${totalPeliculas}</td>
          </tr>
          <tr>
            <td>Reviews</td>
            <td>${totalReviews}</td>
          </tr>
          <tr>
            <td>Actores</td>
            <td>${totalActores}</td>
          </tr>
          <tr>
            <td>Usuarios</td>
            <td>${totalUsuarios}</td>
          </tr>
          <tr>
            <td>Trabajadores</td>
            <td>${totalTrabajadores}</td>
          </tr>
          </tbody>
        </table>
        </div>
      </td>
      <td style="vertical-align:top;">
        <div class="table-responsive">
          <table class="table table-sm table-striped table-bordered">
            <thead class="table-dark">
              <tr>
                <th colspan="2">Top 5 Películas con Mayor Recaudación</th>
              </tr>
              <tr>
                <th colspan="2">Título y Utilidad</th>
              </tr>
            </thead>
            <tbody>
            <tr>
              <td>${topPeliculasRecaudacion[0][0]}</td>
              <td>${topPeliculasRecaudacion[0][1]}</td>
            </tr>
            <tr>
              <td>${topPeliculasRecaudacion[1][0]}</td>
              <td>${topPeliculasRecaudacion[1][1]}</td>
            </tr>
            <tr>
              <td>${topPeliculasRecaudacion[2][0]}</td>
              <td>${topPeliculasRecaudacion[2][1]}</td>
            </tr>
            <tr>
              <td>${topPeliculasRecaudacion[3][0]}</td>
              <td>${topPeliculasRecaudacion[3][1]}</td>
            </tr>
            <tr>
              <td>${topPeliculasRecaudacion[4][0]}</td>
              <td>${topPeliculasRecaudacion[4][1]}</td>
            </tr>
            </tbody>
          </table>
        </div>
      </td>
      <td style="vertical-align:top;">
        <div class="table-responsive">
          <table class="table table-sm table-striped table-bordered">
            <thead class="table-dark">
              <tr>
                <th colspan="2">Top 5 Actores con Más Películas</th>
              </tr>
              <tr>
                <th colspan="2">Nombre y Cantidad de apariciones</th>
              </tr>
            </thead>
            <tbody>
            <tr>
              <td>${topActoresPeliculas[0][0]}</td>
              <td>${topActoresPeliculas[0][1]}</td>
            </tr>
            <tr>
              <td>${topActoresPeliculas[1][0]}</td>
              <td>${topActoresPeliculas[1][1]}</td>
            </tr>
            <tr>
              <td>${topActoresPeliculas[2][0]}</td>
              <td>${topActoresPeliculas[2][1]}</td>
            </tr>
            <tr>
              <td>${topActoresPeliculas[3][0]}</td>
              <td>${topActoresPeliculas[3][1]}</td>
            </tr>
            <tr>
              <td>${topActoresPeliculas[4][0]}</td>
              <td>${topActoresPeliculas[4][1]}</td>
            </tr>
            </tbody>
          </table>
        </div>
      </td>
    </tr>
    <tr>
      <td>
        <canvas id="graficoRatings" width="600" height="300" class="my-3"></canvas>
      </td>
      <td colspan="2">
        <canvas id="graficoEstadisticas" width="600" height="300" class="my-3"></canvas>
      </td>
    </tr>
  </table>
  </div>
</div>
<script>
    const ctx = document.getElementById('graficoEstadisticas').getContext('2d');
    const grafico = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['Películas', 'Reviews', 'Actores', 'Usuarios', 'Trabajadores'],
        datasets: [{
          label: 'Cantidad',
          data: [
            ${totalPeliculas},
            ${totalReviews},
            ${totalActores},
            ${totalUsuarios},
            ${totalTrabajadores}
          ],
          backgroundColor: [
            '#0d6efd',
            '#6610f2',
            '#6f42c1',
            '#d63384',
            '#fd7e14'
          ]
        }]
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            display: false
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              font: {
                size: 10
              }
            }
          },
          x: {
            ticks: {
              font: {
                size: 10
              }
            }
          }
        }
      }
    });
</script>
<script>
    const ctxRating = document.getElementById('graficoRatings').getContext('2d');
    const ratingChart = new Chart(ctxRating, {
      type: 'bar',
      data: {
        labels: ['0–1', '1–2', '2–3', '3–4', '4–5', '5–6', '6–7', '7–8', '8–9', '9–10'],
        datasets: [{
          label: 'Películas por rating',
          data: [
            ${r0_1},
            ${r1_2},
            ${r2_3},
            ${r3_4},
            ${r4_5},
            ${r5_6},
            ${r6_7},
            ${r7_8},
            ${r8_9},
            ${r9_10}
          ],
          backgroundColor: '#198754'
        }]
      },
      options: {
        responsive: true,
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              font: {
                size: 10
              }
            }
          },
          x: {
            ticks: {
              font: {
                size: 10
              }
            }
          }
        }
      }
    });
</script>
</body>
</html>
<script>
  const toggleBtn = document.getElementById('toggleEstadisticasBtn');
  const estadisticasContainer = document.getElementById('estadisticas-container');
  toggleBtn.addEventListener('click', function() {
    if (estadisticasContainer.style.display === 'none') {
      estadisticasContainer.style.display = '';
      toggleBtn.textContent = 'Ocultar Estadísticas';
    } else {
      estadisticasContainer.style.display = 'none';
      toggleBtn.textContent = 'Mostrar Estadísticas';
    }
  });
</script>
</html>
