import java.util.Arrays;

public class ECommerceSearch {
    static class Product {
        private String productId;
        private String productName;
        private String category;
        public Product(String productId, String productName, String category) {
            this.productId = productId;
            this.productName = productName;
            this.category = category;
        }
        public String getProductId() {
            return productId;
        }
        public String getProductName() {
            return productName;
        }
        public String getCategory() {
            return category;
        }
        @Override
        public String toString() {
            return "ProductID: " + productId + ", Name: " + productName + ", Category: " + category;
        }
    }
    public static Product linearSearch(Product[] products, String searchTerm) {
        for (Product product : products) {
            if (product.getProductId().equals(searchTerm) || product.getProductName().equals(searchTerm)) {
                return product;
            }
        }
        return null; 
    }
    public static Product binarySearch(Product[] products, String searchTerm) {
        int low = 0;
        int high = products.length - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            int comparison = products[mid].getProductId().compareTo(searchTerm);
            if (comparison == 0) {
                return products[mid];
            } else if (comparison < 0) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return null; 
    }
    public static void main(String[] args) {
        Product[] products = {
            new Product("P003", "Headphones", "Electronics"),
            new Product("P001", "Laptop", "Electronics"),
            new Product("P002", "Smartphone", "Electronics")
        };
        System.out.println("Unsorted Products:");
        for (Product product : products) {
            System.out.println(product);
        }
        System.out.println("\nLinear Search:");
        Product resultLinear = linearSearch(products, "P002");
        System.out.println(resultLinear != null ? resultLinear : "Product not found");
        Arrays.sort(products, (p1, p2) -> p1.getProductId().compareTo(p2.getProductId()));
        System.out.println("\nSorted Products:");
        for (Product product : products) {
            System.out.println(product);
        }
        System.out.println("\nBinary Search:");
        Product resultBinary = binarySearch(products, "P002");
        System.out.println(resultBinary != null ? resultBinary : "Product not found");
    }
}
