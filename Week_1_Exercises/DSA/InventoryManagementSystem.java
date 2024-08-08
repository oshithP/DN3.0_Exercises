import java.util.HashMap;
import java.util.Map;
public class InventoryManagementSystem {
    static class Product {
        private String productId;
        private String productName;
        private int quantity;
        private double price;
        public Product(String productId, String productName, int quantity, double price) {
            this.productId = productId;
            this.productName = productName;
            this.quantity = quantity;
            this.price = price;
        }
        public String getProductId() {
            return productId;
        }
        public void setProductId(String productId) {
            this.productId = productId;
        }
        public String getProductName() {
            return productName;
        }
        public void setProductName(String productName) {
            this.productName = productName;
        }
        public int getQuantity() {
            return quantity;
        }
        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }
        public double getPrice() {
            return price;
        }
        public void setPrice(double price) {
            this.price = price;
        }
        @Override
        public String toString() {
            return "ProductID: " + productId + ", Name: " + productName +
                   ", Quantity: " + quantity + ", Price: " + price;
        }
    }
    static class Inventory {
        private Map<String, Product> products;

        public Inventory() {
            products = new HashMap<>();
        }
        public void addProduct(Product product) {
            products.put(product.getProductId(), product);
        }
        public void updateProduct(String productId, Product updatedProduct) {
            if (products.containsKey(productId)) {
                products.put(productId, updatedProduct);
            } else {
                System.out.println("Product not found!");
            }
        }
        public void deleteProduct(String productId) {
            if (products.containsKey(productId)) {
                products.remove(productId);
            } else {
                System.out.println("Product not found!");
            }
        }
        public void displayProducts() {
            for (Product product : products.values()) {
                System.out.println(product);
            }
        }
    }
    public static void main(String[] args) {
        Inventory inventory = new Inventory();
        Product product1 = new Product("P001", "Laptop", 50, 999.99);
        Product product2 = new Product("P002", "Smartphone", 150, 499.99);
        Product product3 = new Product("P003", "Headphones", 200, 199.99);
        inventory.addProduct(product1);
        inventory.addProduct(product2);
        inventory.addProduct(product3);
        System.out.println("Inventory after adding products:");
        inventory.displayProducts();
        Product updatedProduct1 = new Product("P001", "Laptop", 45, 949.99);
        inventory.updateProduct("P001", updatedProduct1);
        System.out.println("\nInventory after updating a product:");
        inventory.displayProducts();
        inventory.deleteProduct("P002");
        System.out.println("\nInventory after deleting a product:");
        inventory.displayProducts();
    }
}
