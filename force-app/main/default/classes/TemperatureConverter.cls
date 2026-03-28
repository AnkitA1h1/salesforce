public with sharing class TemperatureConverter {
    public static Decimal fahrenheitToCelsius(Decimal fahrenheit) {
        if(fahrenheit == null) {
            return null;
        }
        
        Decimal celsius = (fahrenheit - 32) * 5 / 9;
        return celsius.setScale(2);
    }
}