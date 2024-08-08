public class BuilderPatternExample {
    static class Computer {
        private final String CPU;
        private final String RAM;
        private final String storage;
        private final boolean hasGraphicsCard;
        private final boolean hasWiFi;
        private Computer(Builder builder) {
            this.CPU = builder.CPU;
            this.RAM = builder.RAM;
            this.storage = builder.storage;
            this.hasGraphicsCard = builder.hasGraphicsCard;
            this.hasWiFi = builder.hasWiFi;
        }
        public String getCPU() {
            return CPU;
        }
        public String getRAM() {
            return RAM;
        }
        public String getStorage() {
            return storage;
        }
        public boolean hasGraphicsCard() {
            return hasGraphicsCard;
        }
        public boolean hasWiFi() {
            return hasWiFi;
        }
        @Override
        public String toString() {
            return "Computer{" +
                    "CPU='" + CPU + '\'' +
                    ", RAM='" + RAM + '\'' +
                    ", Storage='" + storage + '\'' +
                    ", Has Graphics Card=" + hasGraphicsCard +
                    ", Has WiFi=" + hasWiFi +
                    '}';
        }
        public static class Builder {
            private String CPU;
            private String RAM;
            private String storage;
            private boolean hasGraphicsCard;
            private boolean hasWiFi;
            public Builder setCPU(String CPU) {
                this.CPU = CPU;
                return this;
            }
            public Builder setRAM(String RAM) {
                this.RAM = RAM;
                return this;
            }
            public Builder setStorage(String storage) {
                this.storage = storage;
                return this;
            }
            public Builder setGraphicsCard(boolean hasGraphicsCard) {
                this.hasGraphicsCard = hasGraphicsCard;
                return this;
            }
            public Builder setWiFi(boolean hasWiFi) {
                this.hasWiFi = hasWiFi;
                return this;
            }
            public Computer build() {
                return new Computer(this);
            }
        }
    }
    public static class BuilderTest {
        public static void main(String[] args) {
            Computer gamingPC = new Computer.Builder()
                    .setCPU("Intel Core i9")
                    .setRAM("32GB")
                    .setStorage("1TB SSD")
                    .setGraphicsCard(true)
                    .setWiFi(true)
                    .build();
            Computer officePC = new Computer.Builder()
                    .setCPU("Intel Core i5")
                    .setRAM("16GB")
                    .setStorage("512GB SSD")
                    .setGraphicsCard(false)
                    .setWiFi(true)
                    .build();
            System.out.println("Gaming PC Configuration: " + gamingPC);
            System.out.println("Office PC Configuration: " + officePC);
        }
    }
}
