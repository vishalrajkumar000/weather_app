import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpDialog extends StatelessWidget {
  final BuildContext context;

  const HelpDialog({Key? key, required this.context}) : super(key: key);

  void _launchURL(int i) async {
    const instaURL = 'https://instagram.com';
    const mailURL = 'mailto:vishalrajkumar13232@gmail.com';
    if (i == 1) {
      if (await canLaunch(mailURL)) {
        Navigator.of(context).pop();
        await launch(mailURL);
        print('i was called');
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Sorry check your connection and try again!⚡",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.grey[800],
          duration: Duration(seconds: 2),
        ));
      }
    } else if (i == 2) {
      if (await canLaunch(instaURL)) {
        Navigator.of(context).pop();
        await launch(instaURL);
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Sorry check your connection and try again!⚡",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.grey[800],
          duration: Duration(seconds: 2),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 30.0,
      title: Text('Help and Feedback'),
      content: Text(
        'For any help or queries contact us.Give us your valuable suggestions.',
      ),
      actions: [
        IconButton(
          onPressed: () {
            _launchURL(1);
          },
          icon: Icon(
            Icons.mail_outline,
            size: 30.0,
          ),
        ),
        IconButton(
          onPressed: () {
            _launchURL(2);
          },
          icon: FaIcon(
            FontAwesomeIcons.instagram,
            size: 30.0,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Close",
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 17.0,
            ),
          ),
        ),
      ],
    );
  }
}
