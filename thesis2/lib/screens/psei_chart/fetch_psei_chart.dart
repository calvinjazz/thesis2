import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesis2/api/sheets/trading_days_sheets_api.dart';
import 'package:thesis2/widget/trading_day_form_widget.dart';
import 'package:thesis2/app.dart';

class FetchPSEiChartPage extends StatefulWidget {
  @override
  _FetchPSEiChartState createState() => _FetchPSEiChartState();
}

class _FetchPSEiChartState extends State<FetchPSEiChartPage> {
  @override
  void initState() {
    super.initState();

    getTradingDays();
  }

  Future getTradingDays() async {
    final tradingDay = await TradingDaysSheetsApi.getById(2);
    print(tradingDay!.toJson());
  }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(App.title),
          centerTitle: true,
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            children: [
              TradingDayFormWidget(
                onSavedTradingDay: (tradingDay) async {},
              ),
            ],
          ),
        ),
      );
}
