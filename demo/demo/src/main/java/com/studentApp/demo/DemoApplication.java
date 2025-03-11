package com.studentApp.demo;

import com.studentApp.demo.models.Student;
import com.studentApp.demo.repositories.StudentRepository;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

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

		// Optionally, you can start saving or querying data here
	}

	public static SessionFactory getFactory() {
		return factory;
	}
}
