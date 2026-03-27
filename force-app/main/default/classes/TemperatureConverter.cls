public with sharing class TemperatureConverter {
    public static Decimal fahrenheitToCelsius(Decimal fahrenheit) {
        Decimal celsius = (fahrenheit - 32) * 5 / 9;
        return celsius.setScale(2);
    }
}