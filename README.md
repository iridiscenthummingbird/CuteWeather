<h1 align="center">Cute Weather</h1>
<img src="https://i.ibb.co/4S2KMw3/Cute-Weather.png" width="100%">
<h2 align="center"><a  href="https://drive.google.com/file/d/1NUVrfU2HeMeIwNxHm6B9gla5qRtgFH6o/view?usp=sharing">APK Demo</a></h2>

## Description
Cute Weather is a Flutter pet-project.

- [OpenWeatherAPI](https://openweathermap.org/api)
- [Icon Pack](https://www.flaticon.com/packs/weather-507)
- Localization
    - English
    - Ukrainian
    - Russian

<p align="center">
  <img src="https://media.giphy.com/media/3BNv6cI2cOux1MBU7h/giphy.gif" alt="GIF"/>
  <img src="https://media.giphy.com/media/iQ2YccbAL0gckSRNrc/giphy.gif" alt="GIF"/>
</p>

## Installation
Previously you should add your own key from [OpenWeatherAPI](https://openweathermap.org/api) to lib\utils\keys.dart.
```dart
class Keys {
  static String apiKey = "Your key";
}
```
Also you should run this commands in terminal:
```
flutter pub get
flutter packages pub run build_runner build
```
