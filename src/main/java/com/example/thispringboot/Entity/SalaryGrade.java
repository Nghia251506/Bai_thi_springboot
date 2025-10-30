package com.example.thispringboot.Entity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Table(name = "salary_grades")
@Getter
@Setter
@NoArgsConstructor
public class SalaryGrade {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="grade_code", nullable = false, unique = true, length = 20)
    private String gradeCode;

    @Column(name="grade_name", nullable = false, length = 100)
    private String gradeName;

    @Column(name="base_salary", nullable = false)
    private BigDecimal baseSalary;

    private String description;

    // getter/setter
}
