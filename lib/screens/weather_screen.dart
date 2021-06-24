import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/components/help_dialog.dart';
import 'package:weather_app/screens/forecast_screen.dart';
import 'package:weather_app/screens/search_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';

class WeatherScreen extends StatefulWidget {
  final weatherData;

  const WeatherScreen({Key? key, this.weatherData}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var today = true;
  var weather;
  var hourly;
  var remTime;
  bool isLoading = false;
  int selectedIndex = 0;
  String cityName = '';
  int selectedTheme = 0;

  void _getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedTheme = prefs.getInt('selectedTheme') ?? 0;
      print(selectedTheme);
    });
  }

  @override
  void initState() {
    _getTheme();
    weather = widget.weatherData[0];
    remTime = 24 -
        int.parse((DateFormat('Hm').format(DateTime.fromMillisecondsSinceEpoch(
                weather['current']['dt'] * 1000)))
            .split(':')[0]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: kThemes[selectedTheme],
          ),
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.search,
                color: Colors.indigo,
              ),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SearchScreen(),
                  ),
                );
              },
              splashColor: Colors.black54,
              backgroundColor: Colors.grey[200],
              elevation: 8.0,
            ),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.my_location,
                  size: 30.0,
                ),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  var data = await Weather().getLocationWeather();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeatherScreen(
                        weatherData: data,
                      ),
                    ),
                  );
                },
              ),
              centerTitle: true,
              title: Text(
                '${widget.weatherData[1].locality != null ? widget.weatherData[1].locality + ', ' : widget.weatherData[1].subAdminArea != null ? widget.weatherData[1].subAdminArea + ', ' : widget.weatherData[1].adminArea != null ? widget.weatherData[1].adminArea + ', ' : ''}${widget.weatherData[1].countryName ?? ''}',
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              actions: [
                PopupMenuButton(
                  icon: Icon(
                    Icons.settings,
                    size: 30.0,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context, "Theme");
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              contentPadding: EdgeInsets.all(10.0),
                              title: Text(
                                "Select theme",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey[300],
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      setState(() {
                                        selectedTheme = 0;
                                        prefs.setInt(
                                            'selectedTheme', selectedTheme);
                                      });
                                    },
                                    child: Text('Dark Theme'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      setState(() {
                                        selectedTheme = 1;
                                        prefs.setInt(
                                            'selectedTheme', selectedTheme);
                                      });
                                    },
                                    child: Text('Gradient Theme 1'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      setState(() {
                                        selectedTheme = 2;
                                        prefs.setInt(
                                            'selectedTheme', selectedTheme);
                                      });
                                    },
                                    child: Text('Gradient Theme 2'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      setState(() {
                                        selectedTheme = 3;
                                        prefs.setInt(
                                            'selectedTheme', selectedTheme);
                                      });
                                    },
                                    child: Text('Gradient Theme 3'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      setState(() {
                                        selectedTheme = 4;
                                        prefs.setInt(
                                            'selectedTheme', selectedTheme);
                                      });
                                    },
                                    child: Text('Gradient Theme 4'),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Apply",
                                    style: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        leading: Icon(
                          Icons.imagesearch_roller,
                          size: 25.0,
                        ),
                        title: Text(
                          "Theme",
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: Icon(
                          Icons.announcement,
                          size: 25.0,
                        ),
                        title: Text(
                          "Help & Feedback",
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context, "Help");
                          showDialog(
                            context: context,
                            builder: (context) => HelpDialog(
                              context: context,
                            ),
                          );
                        },
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context, "About");
                          showAboutDialog(
                              context: context,
                              applicationIcon: CircleAvatar(
                                  radius: 45.0,
                                  backgroundImage:
                                      AssetImage('images/logo.png')),
                              applicationName: "Weather-V",
                              applicationVersion: "version 1.0",
                              children: [
                                Text(
                                  "This app fetches you the current, hourly and weather forecast of next 7 days of any searched location.",
                                ),
                              ]);
                        },
                        leading: Icon(
                          Icons.info_outline_rounded,
                          size: 25.0,
                        ),
                        title: Text(
                          "About",
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 8.0,
                      right: 8.0,
                      bottom: 6.0,
                    ),
                    child: Text(
                      "Today",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('EEE, d MMM').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            weather['current']['dt'] * 1000)),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.0, color: Colors.grey[300]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                              left: 8.0,
                              right: 8.0,
                              bottom: 4.0,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text:
                                    "${weather['current']['temp'].toStringAsFixed(1)}°",
                                style: TextStyle(
                                  fontSize: 55.0,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: Offset(0.0, -23.0),
                                      child: Text(
                                        'C',
                                        style: TextStyle(fontSize: 30.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 4.0,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text:
                                    "feels like ${weather['current']['feels_like'].toStringAsFixed(1)}°",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey[300],
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: Offset(0.0, -4.0),
                                      child: Text(
                                        'C',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50.0,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: FaIcon(
                              Weather().getEmoji(
                                  weather['current']['weather'][0]['icon']),
                              color: Colors.white,
                              size: 70.0,
                            ),
                          ),
                          Text(
                            weather['current']['weather'][0]['description'],
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Today',
                              style: today ? kSelectedDay : kNotSelectedDay,
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Tomorrow',
                              style: today ? kNotSelectedDay : kSelectedDay,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForecastScreen(
                                forecast: weather['daily'].sublist(1),
                                locality: widget.weatherData[1].locality,
                                countryName: widget.weatherData[1].countryName,
                                subAdminArea:
                                    widget.weatherData[1].subAdminArea,
                                adminArea: widget.weatherData[1].adminArea,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Next 7 days >',
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 0.3,
                    indent: 20.0,
                    endIndent: 20.0,
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: 24,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, item) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = item;
                          });
                          if ((DateTime.fromMillisecondsSinceEpoch(
                                  weather['hourly'][item + 1]['dt'] * 1000))
                              .isAfter(DateTime.now()
                                  .add(Duration(hours: remTime)))) {
                            setState(() {
                              today = false;
                            });
                          } else {
                            setState(() {
                              today = true;
                            });
                          }
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(DateFormat('j').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    weather['hourly'][item + 1]['dt'] * 1000))),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 58.0,
                                height: 120.0,
                                padding: EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0,
                                    top: 25.0,
                                    bottom: 25.0),
                                decoration: BoxDecoration(
                                  gradient: selectedIndex == item
                                      ? LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.blue,
                                            Color(0xffD973B0),
                                          ],
                                        )
                                      : null,
                                  color: selectedIndex == item
                                      ? Colors.white
                                      : Colors.white12,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      Weather().getEmoji(weather['hourly']
                                          [item + 1]['weather'][0]['icon']),
                                      color: selectedIndex == item
                                          ? Colors.white
                                          : Colors.white54,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        "${weather['hourly'][item + 1]['temp'].toStringAsFixed(1)}°",
                                        style: selectedIndex == item
                                            ? kSelectedHour
                                            : kNotSelectedHour,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Table(
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Sunrise",
                                    style: kHeading,
                                  ),
                                  Text(
                                    weather['current']['sunrise'] != null
                                        ? DateFormat('jm').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                weather['current']['sunrise'] *
                                                    1000))
                                        : 'No Info',
                                    style: kValues,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Sunset",
                                    style: kHeading,
                                  ),
                                  Text(
                                    weather['current']['sunset'] != null
                                        ? DateFormat('jm').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                weather['current']['sunset'] *
                                                    1000))
                                        : 'No Info',
                                    style: kValues,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "UV Index",
                                    style: kHeading,
                                  ),
                                  Text(
                                    "${weather['current']['uvi']}",
                                    style: kValues,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Wind Speed",
                                    style: kHeading,
                                  ),
                                  Text(
                                    "${((weather['current']['wind_speed']))} m/sec",
                                    style: kValues,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Cloudiness",
                                    style: kHeading,
                                  ),
                                  Text(
                                    "${weather['current']['clouds']} %",
                                    style: kValues,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Humidity",
                                    style: kHeading,
                                  ),
                                  Text(
                                    "${weather['current']['humidity']} %",
                                    style: kValues,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isLoading
            ? Container(
                color: Colors.black87,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
