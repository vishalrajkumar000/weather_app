import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/services/location_request.dart';
import 'package:weather_app/services/weather.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String cityName = '';
  bool error = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Container(
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Search City ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 45.0,
                )
              ],
            ),
            TextField(
              decoration: InputDecoration(
                  errorText: error ? 'Search for valid city name!' : null,
                  focusColor: Colors.grey,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              cursorColor: Colors.black,
              cursorHeight: 30.0,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                cityName = value;
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54)),
                onPressed: () async {
                  var co = await Location().getCoordinates(cityName);
                  print(co);
                  if (co != null) {
                    var data = await Weather().getCityWeather(co);
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WeatherScreen(
                          weatherData: data,
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      error = true;
                    });
                  }
                },
                child: Text(
                  'Get Weather',
                  style: TextStyle(fontSize: 19.0, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
