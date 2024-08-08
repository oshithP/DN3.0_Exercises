public class ProxyPatternExample {
    interface Image {
        void display();
    }
    static class RealImage implements Image {
        private final String filename;
        public RealImage(String filename) {
            this.filename = filename;
            loadFromServer();
        }
        private void loadFromServer() {
            System.out.println("Loading image: " + filename);
        }
        @Override
        public void display() {
            System.out.println("Displaying image: " + filename);
        }
    }
    static class ProxyImage implements Image {
        private RealImage realImage;
        private final String filename;
        public ProxyImage(String filename) {
            this.filename = filename;
        }
        @Override
        public void display() {
            if (realImage == null) {
                realImage = new RealImage(filename);
            }
            realImage.display();
        }
    }
    public static class ProxyTest {
        public static void main(String[] args) {
            Image image1 = new ProxyImage("image1.jpg");
            Image image2 = new ProxyImage("image2.jpg");
            image1.display(); 
            image1.display(); 
            image2.display(); 
            image2.display(); 
        }
    }
}
