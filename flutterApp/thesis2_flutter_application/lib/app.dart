import 'package:flutter/material.dart';
import 'package:thesis2_flutter_application/screens/homepage.dart';

class App extends StatelessWidget {
  static final String title = 'Fetch Philippine Stock Exchange Index k-NN';
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.yellow),
        //direct to PSEiChartPage
        home: HomePage(),
      );
}
