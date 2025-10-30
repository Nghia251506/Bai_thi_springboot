package com.example.thispringboot.Repository;

import com.example.thispringboot.Entity.SalaryGrade;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SalaryGradeRepository extends JpaRepository<SalaryGrade,Long> { }
