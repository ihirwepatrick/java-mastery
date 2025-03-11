package com.studentApp.demo.repositories;

import com.studentApp.demo.models.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {

    // Find student by email
    Student findByEmail(String email);

    // Find students by their first name
    List<Student> findByFirstName(String firstName);

    // Find students by last name
    List<Student> findByLastName(String lastName);

    // Find students by their first and last name
    List<Student> findByFirstNameAndLastName(String firstName, String lastName);

    // Find students whose age is greater than a specified value
    List<Student> findByAgeGreaterThan(int age);

    // Find students whose age is less than a specified value
    List<Student> findByAgeLessThan(int age);

    // Delete student by email
    void deleteByEmail(String email);
}
