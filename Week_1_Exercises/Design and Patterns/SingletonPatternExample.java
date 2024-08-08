public class SingletonPatternExample {
    static class Logger {
        private static Logger instance;
        private Logger() {
            // Private constructor to prevent instantiation
        }
        public static synchronized Logger getInstance() {
            if (instance == null) {
                instance = new Logger();
            }
            return instance;
        }
        public void log(String message) {
            System.out.println("Log: " + message);
        }
    }
    public static class SingletonTest {
        public static void main(String[] args) {
            Logger logger1 = Logger.getInstance();
            Logger logger2 = Logger.getInstance();
            if (logger1 == logger2) {
                System.out.println("Both logger instances are the same.");
            } else {
                System.out.println("Different logger instances.");
            }
            logger1.log("This is a test log message.");
            logger2.log("This message should come from the same logger instance.");
        }
    }
}
