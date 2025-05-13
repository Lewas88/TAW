package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReviewRepository extends JpaRepository<Review, Integer> {
}
