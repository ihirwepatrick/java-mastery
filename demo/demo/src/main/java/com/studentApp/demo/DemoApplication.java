package com.studentApp.demo;

import com.studentApp.demo.models.Student;
import com.studentApp.demo.repositories.StudentRepository;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

import java.util.Iterator;
import java.util.List;

@SpringBootApplication
public class DemoApplication {

	private static SessionFactory factory;
	private static ServiceRegistry serviceRegistry;

	@Autowired
	private static StudentRepository studentRepository;

	public static void main(String[] args) {
		ApplicationContext context = SpringApplication.run(DemoApplication.class, args);

		// Hibernate configuration setup
		Configuration config = new Configuration();
		config.configure();  // It reads hibernate.cfg.xml
		config.addAnnotatedClass(Student.class);
		config.addResource("Student.hbm.xml");
		serviceRegistry = new StandardServiceRegistryBuilder().applySettings(config.getProperties()).build();
		factory = config.buildSessionFactory(serviceRegistry);
		DemoApplication student = new DemoApplication();
		Integer stud1 = student.addStudent("John", "nipcts3@gmail.com", 25);
		Integer stud2 = student.addStudent("John", "nipcts4@gmail.com", 25);
		Integer stud3 = student.addStudent("John", "nipcts5@gmail.com", 25);
		student.getAllStudents();
	}
	public Integer addStudent(String name, String email, int age) {
		Student student = new Student(name, email, age);
		Session session = factory.openSession();
		Transaction tx = null;
		Integer studentID = null;
		try {
			tx = session.beginTransaction();
			Student employee = new Student(name, email, age);
			studentID = (Integer) session.save(employee);
			tx.commit();
		} catch (HibernateException e) {
			if (tx!=null) tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return studentID;
	};
	public void getAllStudents() {
		Session session = factory.openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			List students = session.createQuery("FROM Student").list();
			for (Iterator iterator = students.iterator(); iterator.hasNext();){
				Student student = (Student) iterator.next();
				System.out.print(" Name: " + student.getName());
				System.out.print(" Email: " + student.getEmail());
				System.out.println(" Age: " + student.getAge());
			}
			tx.commit();
		} catch (HibernateException e) {
			if (tx!=null) tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}

	};
	public static SessionFactory getFactory() {
		return factory;
	}
}
