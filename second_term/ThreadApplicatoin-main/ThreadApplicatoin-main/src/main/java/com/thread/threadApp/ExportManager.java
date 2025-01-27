package com.thread.threadApp;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ExportManager {

    public static void main(String[] args) {
        EmployeeDataExporter exporter = new EmployeeDataExporter();
        ExecutorService executorService = Executors.newFixedThreadPool(5);

        for (int i = 1; i <= 5; i++) {
            String fileName = "EmployeeData_" + i + ".xlsx";
            executorService.submit(() -> exporter.exportToExcel(fileName));
        }

        executorService.shutdown();
    }
}

