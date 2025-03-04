package com.example.SpringbootApp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

@SpringBootApplication
public class SpringbootAppApplication {

	public static void main(String[] args) {

		ConfigurableApplicationContext ctx =  SpringApplication.run(SpringbootAppApplication.class, args);
	}
}
