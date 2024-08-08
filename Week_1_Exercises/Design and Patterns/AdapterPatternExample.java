public class AdapterPatternExample {
    interface PaymentProcessor {
        void processPayment(double amount);
    }
    static class PayPal {
        void payWithPayPal(double amount) {
            System.out.println("Processing payment of $" + amount + " using PayPal.");
        }
    }
    static class Stripe {
        void charge(double amount) {
            System.out.println("Charging $" + amount + " using Stripe.");
        }
    }
    static class PayPalAdapter implements PaymentProcessor {
        private final PayPal payPal;
        public PayPalAdapter(PayPal payPal) {
            this.payPal = payPal;
        }
        @Override
        public void processPayment(double amount) {
            payPal.payWithPayPal(amount);
        }
    }
    static class StripeAdapter implements PaymentProcessor {
        private final Stripe stripe;
        public StripeAdapter(Stripe stripe) {
            this.stripe = stripe;
        }
        @Override
        public void processPayment(double amount) {
            stripe.charge(amount);
        }
    }
    public static class AdapterTest {
        public static void main(String[] args) {
            PayPal payPal = new PayPal();
            Stripe stripe = new Stripe();
            PaymentProcessor payPalAdapter = new PayPalAdapter(payPal);
            PaymentProcessor stripeAdapter = new StripeAdapter(stripe);
            payPalAdapter.processPayment(100.0); 
            stripeAdapter.processPayment(200.0);
        }
    }
}
