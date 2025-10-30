package com.example.thispringboot.Repository;

import com.example.thispringboot.Entity.Department;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DepartmentRepository extends JpaRepository<Department, Long> { }
