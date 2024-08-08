public class EmployeeManagementSystem {
    static class Employee {
        private String employeeId;
        private String name;
        private String position;
        private double salary;
        public Employee(String employeeId, String name, String position, double salary) {
            this.employeeId = employeeId;
            this.name = name;
            this.position = position;
            this.salary = salary;
        }
        public String getEmployeeId() {
            return employeeId;
        }
        public void setEmployeeId(String employeeId) {
            this.employeeId = employeeId;
        }
        public String getName() {
            return name;
        }
        public void setName(String name) {
            this.name = name;
        }
        public String getPosition() {
            return position;
        }
        public void setPosition(String position) {
            this.position = position;
        }
        public double getSalary() {
            return salary;
        }
        public void setSalary(double salary) {
            this.salary = salary;
        }
        @Override
        public String toString() {
            return "EmployeeID: " + employeeId + ", Name: " + name +
                   ", Position: " + position + ", Salary: $" + salary;
        }
    }
    static class EmployeeManager {
        private Employee[] employees;
        private int size;
        public EmployeeManager(int capacity) {
            employees = new Employee[capacity];
            size = 0;
        }
        public void addEmployee(Employee employee) {
            if (size < employees.length) {
                employees[size++] = employee;
            } else {
                System.out.println("Array is full, cannot add more employees.");
            }
        }
        public Employee searchEmployee(String employeeId) {
            for (int i = 0; i < size; i++) {
                if (employees[i].getEmployeeId().equals(employeeId)) {
                    return employees[i];
                }
            }
            return null; 
        }
        public void traverseEmployees() {
            if (size == 0) {
                System.out.println("No employees to display.");
                return;
            }
            for (int i = 0; i < size; i++) {
                System.out.println(employees[i]);
            }
        }
        public void deleteEmployee(String employeeId) {
            for (int i = 0; i < size; i++) {
                if (employees[i].getEmployeeId().equals(employeeId)) {
                    for (int j = i; j < size - 1; j++) {
                        employees[j] = employees[j + 1];
                    }
                    employees[--size] = null; 
                    return;
                }
            }
            System.out.println("Employee not found.");
        }
    }
    public static void main(String[] args) {
        EmployeeManager manager = new EmployeeManager(10); 
        manager.addEmployee(new Employee("E001", "Alice", "Engineer", 75000));
        manager.addEmployee(new Employee("E002", "Bob", "Manager", 85000));
        manager.addEmployee(new Employee("E003", "Charlie", "Technician", 60000));
        System.out.println("All Employees:");
        manager.traverseEmployees();
        System.out.println("\nSearching for employee with ID E002:");
        Employee searchResult = manager.searchEmployee("E002");
        System.out.println(searchResult != null ? searchResult : "Employee not found");
        System.out.println("\nDeleting employee with ID E003:");
        manager.deleteEmployee("E003");
        System.out.println("\nAll Employees after deletion:");
        manager.traverseEmployees();
    }
}
