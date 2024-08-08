import java.util.ArrayList;
import java.util.List;
interface Stock {
    void registerObserver(Observer observer);
    void deregisterObserver(Observer observer);
    void notifyObservers();
}
class StockMarket implements Stock {
    private final List<Observer> observers = new ArrayList<>();
    private double price;
    public void setPrice(double price) {
        this.price = price;
        notifyObservers();
    }
    public double getPrice() {
        return price;
    }
    @Override
    public void registerObserver(Observer observer) {
        observers.add(observer);
    }
    @Override
    public void deregisterObserver(Observer observer) {
        observers.remove(observer);
    }
    @Override
    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update();
        }
    }
}
interface Observer {
    void update();
}
class MobileApp implements Observer {
    private final StockMarket stockMarket;
    public MobileApp(StockMarket stockMarket) {
        this.stockMarket = stockMarket;
        this.stockMarket.registerObserver(this);
    }
    @Override
    public void update() {
        System.out.println("Mobile App Notification: Stock price updated to $" + stockMarket.getPrice());
    }
}
class WebApp implements Observer {
    private final StockMarket stockMarket;
    public WebApp(StockMarket stockMarket) {
        this.stockMarket = stockMarket;
        this.stockMarket.registerObserver(this);
    }
    @Override
    public void update() {
        System.out.println("Web App Notification: Stock price updated to $" + stockMarket.getPrice());
    }
}
public class ObserverPatternExample {
    public static void main(String[] args) {
        StockMarket stockMarket = new StockMarket();
        MobileApp mobileApp = new MobileApp(stockMarket);
        WebApp webApp = new WebApp(stockMarket);
        stockMarket.setPrice(100.0);
        stockMarket.setPrice(105.5);
        stockMarket.deregisterObserver(mobileApp);
        stockMarket.setPrice(110.0);
    }
}
