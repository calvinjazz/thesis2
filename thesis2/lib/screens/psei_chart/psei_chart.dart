import 'package:flutter/material.dart';
import 'package:thesis2/api/sheets/trading_days_sheets_api.dart';
import 'package:thesis2/model/trading_day.dart';
import 'package:thesis2/app.dart';
import 'package:thesis2/widget/trading_day_form_widget.dart';

class PSEiChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(App.title),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(32),
          //form for inputting trading days into google sheets
          child: SingleChildScrollView(
            child: TradingDayFormWidget(
              onSavedTradingDay: (tradingDay) async {
                //increment id by 1
                final id = await TradingDaysSheetsApi.getRowCount() + 1;
                //put id in trading day object
                final newTradingDay = tradingDay.copy(id: id);
                //use method to append data
                await TradingDaysSheetsApi.insert([newTradingDay.toJson()]);
              },
            ),
          ),
        ),
      );

  //define trading days to input
  Future insertTradingDays() async {
    final tradingDays = [
      TradingDay(
          id: 1,
          date: 'Aug 27, 2021',
          open: '6,799.08',
          high: '6,831.26',
          low: '6,774.02',
          close: '6,786.62',
          adjClose: '6,786.62',
          volume: '91,700'),
      TradingDay(
          id: 2,
          date: 'Aug 26, 2021',
          open: '6,822.83',
          high: '6,850.18',
          low: '6,808.94',
          close: '6,820.53',
          adjClose: '6,820.53',
          volume: '191,300'),
      TradingDay(
          id: 3,
          date: 'Aug 25, 2021',
          open: '6,682.93',
          high: '6,822.15',
          low: '6,666.93',
          close: '6,822.15',
          adjClose: '6,822.15',
          volume: '98,900'),
      TradingDay(
          id: 4,
          date: 'Aug 24, 2021',
          open: '6,631.87',
          high: '6,678.82',
          low: '6,628.40',
          close: '6,678.82',
          adjClose: '6,678.82',
          volume: '126,300'),
      TradingDay(
          id: 5,
          date: 'Aug 23, 2021',
          open: '6,679.52',
          high: '6,690.18',
          low: '6,591.67',
          close: '6,591.67',
          adjClose: '6,591.67',
          volume: '107,900'),
    ];

    //convert shit man idk
    final jsonTradingDays =
        tradingDays.map((tradingDay) => tradingDay.toJson()).toList();

    await TradingDaysSheetsApi.insert(jsonTradingDays);
  }
}
