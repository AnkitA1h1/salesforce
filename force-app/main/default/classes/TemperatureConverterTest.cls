@IsTest
private with sharing class TemperatureConverterTest {

    @IsTest
    static void testWarmTemp() {
        Decimal fahrenheit = 70;
        Decimal celsius = TemperatureConverter.fahrenheitToCelsius(fahrenheit);
        Assert.areEqual(21.11, celsius, '70°F should convert to 21.11°C');
    }

    @IsTest
    static void testFreezingPoint() {
        Decimal celsius = TemperatureConverter.fahrenheitToCelsius(32);
        Assert.areEqual(0, celsius, '32°F should convert to 0°C');
    }

    @IsTest
    static void testBoilingPoint() {
        Decimal celsius = TemperatureConverter.fahrenheitToCelsius(212);
        Assert.areEqual(100, celsius, '212°F should convert to 100°C');
    }

    @IsTest
    static void testNegativeTemp() {
        Decimal celsius = TemperatureConverter.fahrenheitToCelsius(-10);
        Assert.areEqual(-23.33, celsius, '-10°F should convert to -23.33°C');
    }
}