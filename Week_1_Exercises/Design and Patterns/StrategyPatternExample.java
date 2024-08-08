public class StrategyPatternExample {
    interface PaymentStrategy {
        void pay(double amount);
    }
    static class CreditCardPayment implements PaymentStrategy {
        private final String cardNumber;
        private final String cardHolder;
        public CreditCardPayment(String cardNumber, String cardHolder) {
            this.cardNumber = cardNumber;
            this.cardHolder = cardHolder;
        }
        @Override
        public void pay(double amount) {
            System.out.println("Paying $" + amount + " using Credit Card.");
            System.out.println("Card Number: " + cardNumber);
            System.out.println("Card Holder: " + cardHolder);
        }
    }
    static class PayPalPayment implements PaymentStrategy {
        private final String email;
        public PayPalPayment(String email) {
            this.email = email;
        }
        @Override
        public void pay(double amount) {
            System.out.println("Paying $" + amount + " using PayPal.");
            System.out.println("PayPal Email: " + email);
        }
    }
    static class PaymentContext {
        private PaymentStrategy paymentStrategy;
        public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
            this.paymentStrategy = paymentStrategy;
        }
        public void executePayment(double amount) {
            paymentStrategy.pay(amount);
        }
    }
    public static class StrategyTest {
        public static void main(String[] args) {
            PaymentContext paymentContext = new PaymentContext();
            PaymentStrategy creditCard = new CreditCardPayment("1234-5678-9876-5432", "John Doe");
            paymentContext.setPaymentStrategy(creditCard);
            paymentContext.executePayment(100.0);
            PaymentStrategy payPal = new PayPalPayment("john.doe@example.com");
            paymentContext.setPaymentStrategy(payPal);
            paymentContext.executePayment(200.0);
        }
    }
}
