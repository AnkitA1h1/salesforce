@IsTest
private with sharing class TemperatureConverterTest {

    @IsTest
    static void testWarmTemp() {
        Decimal fahrenheit = 70;
        Decimal celsius = TemperatureConverter.fahrenheitToCelsius(fahrenheit);
        Assert.areEqual(21.11, celsius, '70°F should convert to 21.11°C');
    }
}