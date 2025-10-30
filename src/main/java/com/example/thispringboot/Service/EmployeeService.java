package com.example.thispringboot.Service;

import com.example.thispringboot.Dto.EmployeeDto;
import com.example.thispringboot.Entity.Department;
import com.example.thispringboot.Entity.Employee;
import com.example.thispringboot.Entity.Position;
import com.example.thispringboot.Entity.SalaryGrade;
import com.example.thispringboot.Repository.DepartmentRepository;
import com.example.thispringboot.Repository.EmployeeRepository;
import com.example.thispringboot.Repository.PositionRepository;
import com.example.thispringboot.Repository.SalaryGradeRepository;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

@Service
public class EmployeeService {
    private final EmployeeRepository employeeRepo;
    private final DepartmentRepository departmentRepo;
    private final PositionRepository positionRepo;
    private final SalaryGradeRepository salaryGradeRepo;

    public EmployeeService(EmployeeRepository employeeRepo,
                           DepartmentRepository departmentRepo,
                           PositionRepository positionRepo,
                           SalaryGradeRepository salaryGradeRepo) {
        this.employeeRepo = employeeRepo;
        this.departmentRepo = departmentRepo;
        this.positionRepo = positionRepo;
        this.salaryGradeRepo = salaryGradeRepo;
    }

    // CREATE
    public Employee create(EmployeeDto dto) {
        if (employeeRepo.existsByEmpCode(dto.getEmpCode())) {
            throw new RuntimeException("Employee code already exists");
        }
        Employee e = mapToEntity(dto, new Employee());
        return employeeRepo.save(e);
    }

    // UPDATE
    public Employee update(Long id, EmployeeDto dto) {
        Employee e = employeeRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Employee not found"));
        // check mã trùng nếu có đổi
        if (!e.getEmpCode().equals(dto.getEmpCode())
                && employeeRepo.existsByEmpCode(dto.getEmpCode())) {
            throw new RuntimeException("Employee code already exists");
        }
        e = mapToEntity(dto, e);
        return employeeRepo.save(e);
    }

    // DELETE
    public void delete(Long id) {
        if (!employeeRepo.existsById(id)) {
            throw new RuntimeException("Employee not found");
        }
        employeeRepo.deleteById(id);
    }

    // GET ONE
    public Employee getById(Long id) {
        return employeeRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Employee not found"));
    }

    // SEARCH
    public Page<Employee> search(String keyword,
                                 Long departmentId,
                                 String status,
                                 int page,
                                 int size) {

        // khởi tạo spec rỗng kiểu mới
        Specification<Employee> spec = (root, query, cb) -> cb.conjunction();

        if (keyword != null && !keyword.isBlank()) {
            String kw = "%" + keyword.trim().toLowerCase() + "%";
            spec = spec.and((root, query, cb) ->
                    cb.or(
                            cb.like(cb.lower(root.get("empCode")), kw),
                            cb.like(cb.lower(root.get("firstName")), kw),
                            cb.like(cb.lower(root.get("lastName")), kw),
                            cb.like(cb.lower(root.get("email")), kw),
                            cb.like(cb.lower(root.get("phone")), kw)
                    )
            );
        }

        if (departmentId != null) {
            spec = spec.and((root, query, cb) ->
                    cb.equal(root.get("department").get("id"), departmentId)
            );
        }

        if (status != null && !status.isBlank()) {
            spec = spec.and((root, query, cb) ->
                    cb.equal(root.get("status"), Employee.EmployeeStatus.valueOf(status))
            );
        }

        Pageable pageable = PageRequest.of(page, size, Sort.by("id").descending());
        return employeeRepo.findAll(spec, pageable);
    }


    /**
     * Map DTO -> Entity
     */
    private Employee mapToEntity(EmployeeDto dto, Employee e) {
        // field đơn
        e.setEmpCode(dto.getEmpCode());
        e.setFirstName(dto.getFirstName());
        e.setLastName(dto.getLastName());
        if (dto.getGender() != null && !dto.getGender().isBlank()) {
            e.setGender(Employee.Gender.valueOf(dto.getGender()));
        }
        e.setDateOfBirth(dto.getDateOfBirth());
        e.setEmail(dto.getEmail());
        e.setPhone(dto.getPhone());
        e.setAddress(dto.getAddress());
        e.setHireDate(dto.getHireDate());

        if (dto.getStatus() != null && !dto.getStatus().isBlank()) {
            e.setStatus(Employee.EmployeeStatus.valueOf(dto.getStatus()));
        }

        // liên kết
        if (dto.getDepartmentId() != null) {
            Department d = departmentRepo.findById(dto.getDepartmentId())
                    .orElseThrow(() -> new RuntimeException("Department not found"));
            e.setDepartment(d);
        } else {
            e.setDepartment(null);
        }

        if (dto.getPositionId() != null) {
            Position p = positionRepo.findById(dto.getPositionId())
                    .orElseThrow(() -> new RuntimeException("Position not found"));
            e.setPosition(p);
        } else {
            e.setPosition(null);
        }

        if (dto.getSalaryGradeId() != null) {
            SalaryGrade s = salaryGradeRepo.findById(dto.getSalaryGradeId())
                    .orElseThrow(() -> new RuntimeException("Salary grade not found"));
            e.setSalaryGrade((com.example.thispringboot.Entity.SalaryGrade) s);
        } else {
            e.setSalaryGrade(null);
        }

        e.setBasicSalary(dto.getBasicSalary());
        e.setAllowance(dto.getAllowance());
        return e;
    }
}

