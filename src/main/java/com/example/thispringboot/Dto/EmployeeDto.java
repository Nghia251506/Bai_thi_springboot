package com.example.thispringboot.Dto;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
@Getter
@Setter
@NoArgsConstructor
public class EmployeeDto {
    private Long id;
    private String empCode;
    private String firstName;
    private String lastName;
    private String gender;
    private LocalDate dateOfBirth;
    private String email;
    private String phone;
    private String address;
    private LocalDate hireDate;
    private String status;
    private Long departmentId;
    private Long positionId;
    private Long salaryGradeId;
    private BigDecimal basicSalary;
    private BigDecimal allowance;
    // getter/setter
}
