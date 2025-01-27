package com.thread.threadApp;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.thread.threadApp.Config.DatabaseConnection;


public class EmployeeDataExporter {

    public synchronized void exportToExcel(String fileName) {
        String query = "SELECT * FROM employees";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery();
             Workbook workbook = new XSSFWorkbook()) {

            Sheet sheet = workbook.createSheet("Employees");
            createHeaderRow(sheet);

            int rowCount = 0;
            while (resultSet.next()) {
                Row row = sheet.createRow(++rowCount);
                writeEmployeeRow(resultSet, row);
            }

            try (FileOutputStream outputStream = new FileOutputStream(fileName)) {
                workbook.write(outputStream);
                System.out.println("Exported data to " + fileName);
            }

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }

    private void createHeaderRow(Sheet sheet) {
        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("ID ");
        header.createCell(1).setCellValue("Name ");
        header.createCell(2).setCellValue("Department ");
        header.createCell(3).setCellValue("Email ");
        header.createCell(4).setCellValue("Salary  ");
    }

    private void writeEmployeeRow(ResultSet resultSet, Row row) throws SQLException {
        row.createCell(0).setCellValue(resultSet.getInt("id"));
        row.createCell(1).setCellValue(resultSet.getString("name"));
        row.createCell(2).setCellValue(resultSet.getString("department"));
        row.createCell(3).setCellValue(resultSet.getString("email"));
        row.createCell(4).setCellValue(resultSet.getDouble("salary"));
    }
}
