package com.example.thispringboot.Repository;

import com.example.thispringboot.Entity.Position;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PositionRepository extends JpaRepository<Position,Long> {}

