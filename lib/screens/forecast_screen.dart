import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';

class ForecastScreen extends StatefulWidget {
  final forecast, locality, countryName, subAdminArea, adminArea;
  const ForecastScreen({
    Key? key,
    this.forecast,
    this.locality,
    this.countryName,
    this.subAdminArea,
    this.adminArea,
  }) : super(key: key);

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          color: Colors.grey[900],
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          '${widget.locality != null ? widget.locality + ', ' : widget.subAdminArea != null ? widget.subAdminArea + ', ' : widget.adminArea != null ? widget.adminArea + ', ' : ''}${widget.countryName ?? ''}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Next 7 days',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[700],
                    backgroundColor: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5.0,
                    color: Colors.grey[50],
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.all(10.0),
                      leading: FaIcon(
                        Weather().getEmoji(
                            widget.forecast[index]['weather'][0]['icon']),
                        color: Colors.black54,
                        size: 30.0,
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          "${widget.forecast[index]['feels_like']['day'].round()}°",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 195.0,
                                child: Text(
                                  DateFormat('EEE, d MMM').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          widget.forecast[index]['dt'] * 1000)),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  "${widget.forecast[index]['temp']['day'].round()}°",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              widget.forecast[index]['weather'][0]
                                  ['description'],
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      childrenPadding: EdgeInsets.only(bottom: 12.0),
                      backgroundColor: Colors.grey[200],
                      children: [
                        Table(
                          children: [
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Sunrise",
                                      style: kFHeading,
                                    ),
                                    Text(
                                      DateFormat('jm').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              widget.forecast[index]
                                                      ['sunrise'] *
                                                  1000)),
                                      style: kFValues,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Sunset",
                                      style: kFHeading,
                                    ),
                                    Text(
                                      DateFormat('jm').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              widget.forecast[index]['sunset'] *
                                                  1000)),
                                      style: kFValues,
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
                                      style: kFHeading,
                                    ),
                                    Text(
                                      "${widget.forecast[index]['uvi']}",
                                      style: kFValues,
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
                                      style: kFHeading,
                                    ),
                                    Text(
                                      "${((widget.forecast[index]['wind_speed']))} m/sec",
                                      style: kFValues,
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
                                      "Cloudiness",
                                      style: kFHeading,
                                    ),
                                    Text(
                                      "${widget.forecast[index]['clouds']} %",
                                      style: kFValues,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Humidity",
                                      style: kFHeading,
                                    ),
                                    Text(
                                      "${widget.forecast[index]['humidity']} %",
                                      style: kFValues,
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
