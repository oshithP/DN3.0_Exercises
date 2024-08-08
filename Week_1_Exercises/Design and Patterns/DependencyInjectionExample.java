public class DependencyInjectionExample {
    interface CustomerRepository {
        String findCustomerById(int id);
    }
    static class CustomerRepositoryImpl implements CustomerRepository {
        @Override
        public String findCustomerById(int id) {
            if (id == 1) {
                return "John Doe";
            } else if (id == 2) {
                return "Jane Smith";
            } else {
                return "Customer not found";
            }
        }
    }
    static class CustomerService {
        private final CustomerRepository customerRepository;
        public CustomerService(CustomerRepository customerRepository) {
            this.customerRepository = customerRepository;
        }
        public String getCustomerName(int id) {
            return customerRepository.findCustomerById(id);
        }
    }
    public static class DependencyInjectionTest {
        public static void main(String[] args) {
            CustomerRepository customerRepository = new CustomerRepositoryImpl();
            CustomerService customerService = new CustomerService(customerRepository);
            System.out.println("Customer with ID 1: " + customerService.getCustomerName(1));
            System.out.println("Customer with ID 2: " + customerService.getCustomerName(2));
            System.out.println("Customer with ID 3: " + customerService.getCustomerName(3));
        }
    }
}
