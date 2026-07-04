package com.itheima.pojo;

import java.time.LocalDate;

public class EmpExpr {
    private Integer id;
    private Integer empId;
    private LocalDate begin;
    private LocalDate end;
    private String company;
    private String job;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getEmpId() { return empId; }
    public void setEmpId(Integer empId) { this.empId = empId; }
    public LocalDate getBegin() { return begin; }
    public void setBegin(LocalDate begin) { this.begin = begin; }
    public LocalDate getEnd() { return end; }
    public void setEnd(LocalDate end) { this.end = end; }
    public String getCompany() { return company; }
    public void setCompany(String company) { this.company = company; }
    public String getJob() { return job; }
    public void setJob(String job) { this.job = job; }
}
