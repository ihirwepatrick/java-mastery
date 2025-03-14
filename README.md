# Advanced Java Progress Repository

Welcome to the **Advanced Java Progress Repository**! This repository serves as a daily journal of my journey in mastering advanced Java concepts. It contains modular programs, tests, and projects that showcase my progress and hands-on experience with Java development.

---

## **Repository Overview**

### **Purpose**
- To track and demonstrate my learning progress in advanced Java development.
- To implement and experiment with various Java concepts and features.
- To build a resource hub for future reference and sharing knowledge.

### **Contents**
This repository includes:
- **Modular Programs:** Independent programs showcasing specific features and concepts in Java.
- **Concept Demonstrations:** Code examples of Java features like enums, collections, concurrency, and more.
- **Tests:** Unit tests to validate the functionality of programs.
- **Projects:** Small projects or assignments applying Java knowledge to practical problems.

---

## **Topics Covered**
The repository is organized into the following sections:

### 1. **Enumerations (Enums)**
- Creating and using enums.
- Enum methods (`values()`, `ordinal()`, `name()`, etc.).
- Using enums in `switch` statements.
- Advanced enums with custom fields and methods.
- Integration of `EnumSet` and `EnumMap`.

### 2. **Collections Framework**
- Advanced usage of `ArrayList`, `HashMap`, `LinkedList`, `TreeSet`, and `HashSet`.
- Iterators and streams for collections.
- Custom sorting using `Comparator` and `Comparable`.

### 3. **Concurrency**
- Threads and `Runnable` interface.
- Synchronization and locks.
- Working with `ExecutorService`.
- Parallel streams.

### 4. **File Handling**
- Reading from and writing to files.
- Using `BufferedReader` and `BufferedWriter`.
- Serialization and deserialization of objects.

### 5. **Exception Handling**
- Custom exceptions.
- Advanced `try-catch-finally` blocks.
- Using `throw` and `throws` effectively.

### 6. **Generics**
- Generic classes and methods.
- Wildcards in generics (`? extends T`, `? super T`).

### 7. **Java 8 Features**
- Functional interfaces (`Predicate`, `Function`, `Consumer`).
- Lambda expressions.
- Streams API.
- Optional class.

### 8. **Unit Testing**
- Writing test cases using JUnit.
- Mocking with Mockito.
- Assertions and parameterized tests.

---

## **Structure**
The repository follows a structured hierarchy:

```
.
|-- src/
|   |-- enums/
|   |   |-- DayExample.java
|   |   |-- PlanetExample.java
|   |-- collections/
|   |   |-- ListExample.java
|   |   |-- MapExample.java
|   |-- concurrency/
|   |   |-- ThreadExample.java
|   |   |-- ExecutorExample.java
|   |-- file_handling/
|   |   |-- FileReadWrite.java
|   |-- tests/
|   |   |-- JUnitTestExample.java
|   |-- projects/
|       |-- MiniProject1.java
|       |-- MiniProject2.java
|-- README.md
```

---

## **How to Use**

### **Clone the Repository**
To get started, clone the repository using the following command:

```bash
$ git clone https://github.com/YourUsername/advanced-java-progress.git
```

### **Compile and Run Programs**
1. Navigate to the `src/` directory.
2. Compile the program you want to run:
   ```bash
   $ javac enums/DayExample.java
   ```
3. Run the compiled program:
   ```bash
   $ java enums.DayExample
   ```

### **Run Unit Tests**
To run the unit tests:
```bash
$ cd src/tests
$ java org.junit.runner.JUnitCore JUnitTestExample
```

---

## **Contribution**
Contributions are welcome! If you have suggestions or would like to add your programs to this repository:
1. Fork the repository.
2. Create a new branch:
   ```bash
   $ git checkout -b feature/your-feature
   ```
3. Commit your changes:
   ```bash
   $ git commit -m "Add your feature description"
   ```
4. Push to your forked repository:
   ```bash
   $ git push origin feature/your-feature
   ```
5. Submit a pull request.

---

## **Future Enhancements**
- Add more advanced topics like JavaFX, Spring Framework, and Hibernate.
- Incorporate design patterns (Singleton, Factory, etc.).
- Explore integrations with databases and REST APIs.

---

## **Contact**
If you have any questions or feedback, feel free to reach out:
- **Email:** [nipcts@gmail.com](mailto:nipcts@gmail.com)
- **LinkedIn:** [Patrick Ihirwe](https://www.linkedin.com/in/patrick-ihirwe-b105b6337/)

---

### **License**
This repository is licensed under the MIT License. Feel free to use and modify the code as needed.
