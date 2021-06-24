import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:weather_app/utilities/secrets.dart';

import 'location_request.dart';
import 'network_request.dart';

const String apiKey = API_KEY;
const String openWeatherURL =
    'https://api.openweathermap.org/data/2.5/onecall?';

class Weather {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getLocation();
    Address address =
        await location.getCityName(location.latitude, location.longitude);
    Network network = Network(
        '${openWeatherURL}lat=${location.latitude}&lon=${location.longitude}&units=metric&exclude=minutely,alerts&appid=$apiKey');
    var weatherData = await network.getData();
    return [weatherData, address];
  }

  Future<dynamic> getCityWeather(Coordinates coordinates) async {
    Address address = await Location()
        .getCityName(coordinates.latitude, coordinates.longitude);
    Network network = Network(
        '$openWeatherURL&lat=${coordinates.latitude}&lon=${coordinates.longitude}&units=metric&exclude=minutely,alerts&appid=$apiKey');
    var weatherData = await network.getData();
    return [weatherData, address];
  }

  IconData getEmoji(String code) {
    code = code.substring(0, 2);
    if (code.compareTo('01') == 0) {
      return Icons.wb_sunny;
    } else if (code.compareTo('02') == 0) {
      return FontAwesomeIcons.cloudSun;
    } else if (code.compareTo('03') == 0) {
      return FontAwesomeIcons.cloud;
    } else if (code.compareTo('04') == 0) {
      return FontAwesomeIcons.cloud;
    } else if (code.compareTo('09') == 0) {
      return FontAwesomeIcons.cloudRain;
    } else if (code.compareTo('10') == 0) {
      return FontAwesomeIcons.cloudSunRain;
    } else if (code.compareTo('11') == 0) {
      return FontAwesomeIcons.cloudShowersHeavy;
    } else if (code.compareTo('13') == 0) {
      return FontAwesomeIcons.snowflake;
    } else {
      return FontAwesomeIcons.smog;
    }
  }
}
