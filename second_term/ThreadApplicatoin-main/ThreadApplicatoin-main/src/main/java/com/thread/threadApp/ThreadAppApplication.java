package com.thread.threadApp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ThreadAppApplication {

	public static void main(String[] args) {
		SpringApplication.run(ThreadAppApplication.class, args);
		System.out.println("java application is running");
	}

}
