import 'package:app/helper/value_based_on_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getValueOnWidth returns correct value for mobile screen', () {
    final valueBasedOnScreen = ValueBasedOnScreen();
    final value = valueBasedOnScreen.getValueOnWidth(
      mobile: 10,
      tablet: 20,
      desktop: 30,
      screenWidth: 400,
    );
    expect(value, equals(10));
  });

  test('getValueOnWidth returns correct value for tablet screen', () {
    final valueBasedOnScreen = ValueBasedOnScreen();
    final value = valueBasedOnScreen.getValueOnWidth(
      mobile: 10,
      tablet: 20,
      desktop: 30,
      screenWidth: 800,
    );
    expect(value, equals(20));
  });

  test('getValueOnWidth returns correct value for desktop screen', () {
    final valueBasedOnScreen = ValueBasedOnScreen();
    final value = valueBasedOnScreen.getValueOnWidth(
      mobile: 10,
      tablet: 20,
      desktop: 30,
      screenWidth: 1200,
    );
    expect(value, equals(30));
  });

  test('getValueOnHeight returns correct value for short screen', () {
    final valueBasedOnScreen = ValueBasedOnScreen();
    final value = valueBasedOnScreen.getValueOnHeight(
      shortScreen: 10,
      mediumScreen: 20,
      longScreen: 30,
      screenHeight: 500,
    );
    expect(value, equals(10));
  });

  test('getValueOnHeight returns correct value for medium screen', () {
    final valueBasedOnScreen = ValueBasedOnScreen();
    final value = valueBasedOnScreen.getValueOnHeight(
      shortScreen: 10,
      mediumScreen: 20,
      longScreen: 30,
      screenHeight: 800,
    );
    expect(value, equals(20));
  });

  test('getValueOnHeight returns correct value for long screen', () {
    final valueBasedOnScreen = ValueBasedOnScreen();
    final value = valueBasedOnScreen.getValueOnHeight(
      shortScreen: 10,
      mediumScreen: 20,
      longScreen: 30,
      screenHeight: 1400,
    );
    expect(value, equals(30));
  });
}
