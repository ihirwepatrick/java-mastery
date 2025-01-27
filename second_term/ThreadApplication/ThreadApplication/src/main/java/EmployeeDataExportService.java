import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

@Service
public class EmployeeDataExporterService {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Async
    public void exportToExcel(String fileName) {
        List<Employee> employees = employeeRepository.findAll();

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Employees");

            // Create header row
            Row headerRow = sheet.createRow(0);
            String[] headers = {"ID", "Name", "Department", "Salary"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(createHeaderCellStyle(workbook));
            }

            // Write data rows
            int rowIndex = 1;
            for (Employee employee : employees) {
                Row row = sheet.createRow(rowIndex++);
                row.createCell(0).setCellValue(employee.getId());
                row.createCell(1).setCellValue(employee.getName());
                row.createCell(2).setCellValue(employee.getDepartment());
                row.createCell(3).setCellValue(employee.getSalary());
            }

            // Write to file
            synchronized (EmployeeDataExporterService.class) { // Ensure thread-safe file writing
                try (FileOutputStream fileOut = new FileOutputStream(fileName)) {
                    workbook.write(fileOut);
                    System.out.println("Data exported to " + fileName + " successfully.");
                }
            }

        } catch (IOException e) {
            System.err.println("Error exporting data: " + e.getMessage());
        }
    }

    private CellStyle createHeaderCellStyle(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        style.setFont(font);
        return style;
    }
}
