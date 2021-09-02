import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesis2/api/sheets/trading_days_sheets_api.dart';
import 'package:thesis2/widget/trading_day_form_widget.dart';
import 'package:thesis2/app.dart';
import 'package:thesis2/model/trading_day.dart';
import 'package:thesis2/widget/navigate_trading_days_widget.dart';

class FetchPSEiChartPage extends StatefulWidget {
  @override
  _FetchPSEiChartState createState() => _FetchPSEiChartState();
}

class _FetchPSEiChartState extends State<FetchPSEiChartPage> {
  List<TradingDay> tradingDays = [];
  int index = 0;

  @override
  void initState() {
    super.initState();

    getTradingDays();
  }

  Future getTradingDays() async {
    final tradingDays = await TradingDaysSheetsApi.getAll();

    setState(() {
      this.tradingDays = tradingDays;
    });
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
                tradingDay: tradingDays.isEmpty ? null : tradingDays[index],
                onSavedTradingDay: (tradingDay) async {},
              ),
              const SizedBox(height: 16),
              if (tradingDays.isNotEmpty) buildTradingDayControls(),
            ],
          ),
        ),
      );

  Widget buildTradingDayControls() => NavigateTradingDaysWidget(
        text: '${index + 1}/${tradingDays.length} Trading Days',
        onClickedNext: () {
          final nextIndex = index >= tradingDays.length - 1 ? 0 : index + 1;

          setState(() => index = nextIndex);
        },
        onClickedPrevious: () {
          final previousIndex = index <= 0 ? tradingDays.length - 1 : index - 1;

          setState(() => index = previousIndex);
        },
      );
}
