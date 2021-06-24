import 'package:flutter/material.dart';

const kSelectedDay = TextStyle(
  color: Colors.white,
  fontSize: 15.0,
);

final kNotSelectedDay = TextStyle(
  color: Colors.grey[300],
  fontSize: 12.0,
);

final kSelectedHour = TextStyle(
  color: Colors.white,
);

const kNotSelectedHour = TextStyle(
  color: Colors.white54,
);

final kHeading = TextStyle(
  color: Colors.grey[600],
  fontSize: 15.0,
);

const kValues = TextStyle(
  color: Colors.black,
  fontSize: 20.0,
);

final kFHeading = TextStyle(
  color: Colors.grey[600],
  fontSize: 15.0,
);

const kFValues = TextStyle(
  color: Colors.black,
  fontSize: 17.0,
);
final kTheme1 = LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  colors: [
    Colors.blue.shade900,
    Colors.lightBlue,
  ],
);
const kTheme2 = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.blue,
    Color(0xffD973B0),
  ],
);
const kTheme3 = LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  colors: [
    Colors.blue,
    Color(0xffD973B0),
  ],
);
const kTheme4 = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Colors.blue,
    Color(0xffD973B0),
  ],
);
final kThemes = [
  null,
  kTheme1,
  kTheme2,
  kTheme3,
  kTheme4,
];
