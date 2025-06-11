package es.uma.taw.proyectotaw.entity;

import jakarta.persistence.criteria.CriteriaBuilder;

public class FiltrosPelicula {
    private String keyword;
    private Long minIngresos;
    private Long maxIngresos;
    private Long minPresupuesto;
    private Long maxPresupuesto;
    private String fechaInicio;
    private String fechaFin;
    private Double minRating;
    private Integer minDuracion;
    private Integer maxDuracion;
    private Integer minEdad;
    private Integer maxEdad;

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }
    public String getKeyword() {
        return keyword;
    }
    public void setMinIngresos(Long minIngresos) {
        this.minIngresos = minIngresos;
    }
    public Long getMinIngresos() {
        return minIngresos;
    }
    public void setMaxIngresos(Long maxIngresos) {
        this.maxIngresos = maxIngresos;
    }
    public Long getMaxIngresos() {
        return maxIngresos;
    }
    public void setMinPresupuesto(Long minPresupuesto) {
        this.minPresupuesto = minPresupuesto;
    }
    public Long getMinPresupuesto() {
        return minPresupuesto;
    }
    public void setMaxPresupuesto(Long maxPresupuesto) {
        this.maxPresupuesto = maxPresupuesto;
    }
    public Long getMaxPresupuesto() {
        return maxPresupuesto;
    }
    public void setFechaInicio(String fechaInicio) {
        this.fechaInicio = fechaInicio;
    }
    public String getFechaInicio() {
        return fechaInicio;
    }
    public void setFechaFin(String fechaFin) {
        this.fechaFin = fechaFin;
    }
    public String getFechaFin() {
        return fechaFin;
    }
    public void setMinRating(Double minRating) {
        this.minRating = minRating;
    }
    public Double getMinRating() {
        return minRating;
    }
    public void setMinDuracion(Integer minDuracion) {
        this.minDuracion = minDuracion;
    }
    public Integer getMinDuracion() {
        return minDuracion;
    }
    public void setMaxDuracion(Integer maxDuracion) {
        this.maxDuracion = maxDuracion;
    }
    public Integer getMaxDuracion() {
        return maxDuracion;
    }
    public void setMinEdad(Integer minEdad) {
        this.minEdad = minEdad;
    }
    public Integer getMinEdad() {
        return minEdad;
    }
    public void setMaxEdad(Integer maxEdad) {
        this.maxEdad = maxEdad;
    }
    public Integer getMaxEdad() {
        return maxEdad;
    }
}
