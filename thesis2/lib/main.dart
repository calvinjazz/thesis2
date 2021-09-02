import 'package:flutter/material.dart';
import 'app.dart';
import 'package:thesis2/api/sheets/trading_days_sheets_api.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await TradingDaysSheetsApi.init();

  runApp(App());
}
