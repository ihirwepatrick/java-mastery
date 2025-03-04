package com.example.SpringbootApp;

import org.springframework.stereotype.Component;

@Component
public class Student {
    int id;
    String firstName;
    String lastName;
    Student() {
        System.out.println("Student Object Created");
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getFirstName() {
        return firstName;
    }
}
