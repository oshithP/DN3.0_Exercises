public class DecoratorPatternExample {
    interface Notifier {
        void send(String message);
    }
    static class EmailNotifier implements Notifier {
        @Override
        public void send(String message) {
            System.out.println("Sending Email with message: " + message);
        }
    }
    abstract static class NotifierDecorator implements Notifier {
        protected final Notifier notifier;
        public NotifierDecorator(Notifier notifier) {
            this.notifier = notifier;
        }
        @Override
        public void send(String message) {
            notifier.send(message);
        }
    }
    static class SMSNotifierDecorator extends NotifierDecorator {
        public SMSNotifierDecorator(Notifier notifier) {
            super(notifier);
        }
        @Override
        public void send(String message) {
            super.send(message);
            System.out.println("Sending SMS with message: " + message);
        }
    }
    static class SlackNotifierDecorator extends NotifierDecorator {
        public SlackNotifierDecorator(Notifier notifier) {
            super(notifier);
        }
        @Override
        public void send(String message) {
            super.send(message);
            System.out.println("Sending Slack message with message: " + message);
        }
    }
    public static class DecoratorTest {
        public static void main(String[] args) {
            Notifier emailNotifier = new EmailNotifier();
            Notifier smsEmailNotifier = new SMSNotifierDecorator(emailNotifier);
            Notifier slackSMSEmailNotifier = new SlackNotifierDecorator(smsEmailNotifier);
            slackSMSEmailNotifier.send("Hello, world!");
        }
    }
}
