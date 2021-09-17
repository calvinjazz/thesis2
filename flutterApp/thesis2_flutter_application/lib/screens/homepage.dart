import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  openURL() async {
    if (await canLaunch("https://thesis2-calvinjazz.herokuapp.com/")) {
      await launch("https://thesis2-calvinjazz.herokuapp.com/",
          forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could Not Launch URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  openURL();
                },
                child: Text("Get started!", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
