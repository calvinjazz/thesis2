import 'package:flutter/material.dart';
//import 'package:thesis2/screens/psei_chart/psei_chart.dart';
import 'package:thesis2/screens/psei_chart/fetch_psei_chart.dart';

class App extends StatelessWidget {
  static final String title = 'Fetch Philippine Stock Exchange Index k-NN';
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.yellow),
        //direct to PSEiChartPage
        home: FetchPSEiChartPage(),
      );
}
