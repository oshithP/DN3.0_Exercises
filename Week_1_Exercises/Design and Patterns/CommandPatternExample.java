public class CommandPatternExample {
    interface Command {
        void execute();
    }
    static class LightOnCommand implements Command {
        private final Light light;
        public LightOnCommand(Light light) {
            this.light = light;
        }
        @Override
        public void execute() {
            light.turnOn();
        }
    }
    static class LightOffCommand implements Command {
        private final Light light;
        public LightOffCommand(Light light) {
            this.light = light;
        }
        @Override
        public void execute() {
            light.turnOff();
        }
    }
    static class Light {
        public void turnOn() {
            System.out.println("Light is ON");
        }
        public void turnOff() {
            System.out.println("Light is OFF");
        }
    }
    static class RemoteControl {
        private Command command;
        public void setCommand(Command command) {
            this.command = command;
        }
        public void pressButton() {
            command.execute();
        }
    }
    public static class CommandTest {
        public static void main(String[] args) {
            Light livingRoomLight = new Light();
            Command lightOn = new LightOnCommand(livingRoomLight);
            Command lightOff = new LightOffCommand(livingRoomLight);
            RemoteControl remoteControl = new RemoteControl();
            remoteControl.setCommand(lightOn);
            remoteControl.pressButton();
            remoteControl.setCommand(lightOff);
            remoteControl.pressButton();
        }
    }
}
