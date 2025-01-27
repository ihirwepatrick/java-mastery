import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EmployeeDataExportController {

    @Autowired
    private EmployeeDataExporterService employeeDataExporterService;

    @GetMapping("/export")
    public String exportEmployeeData() {
        String fileName = "EmployeeData_" + System.currentTimeMillis() + ".xlsx";
        employeeDataExporterService.exportToExcel(fileName);
        return "Export started, check the console for success message.";
    }
}
