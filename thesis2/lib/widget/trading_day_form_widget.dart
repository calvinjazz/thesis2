import 'package:flutter/material.dart';
import 'package:thesis2/model/trading_day.dart';
import 'button_widget.dart';

class TradingDayFormWidget extends StatefulWidget {
  final TradingDay? tradingDay;
  //send trading day out
  final ValueChanged<TradingDay> onSavedTradingDay;

  const TradingDayFormWidget({
    Key? key,
    this.tradingDay,
    required this.onSavedTradingDay,
  }) : super(key: key);

  @override
  _TradingDayFormWidgetState createState() => _TradingDayFormWidgetState();
}

class _TradingDayFormWidgetState extends State<TradingDayFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerDate;
  late TextEditingController controllerOpen;
  late TextEditingController controllerHigh;
  late TextEditingController controllerLow;
  late TextEditingController controllerClose;
  late TextEditingController controllerAdjClose;
  late TextEditingController controllerVolume;

  @override
  void initState() {
    super.initState();

    initTradingDay();
  }

  @override
  void didUpdateWidget(covariant TradingDayFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    initTradingDay();
  }

  //define default values
  void initTradingDay() {
    final date = widget.tradingDay == null ? '' : widget.tradingDay!.date;
    final open = widget.tradingDay == null ? '' : widget.tradingDay!.open;
    final high = widget.tradingDay == null ? '' : widget.tradingDay!.high;
    final low = widget.tradingDay == null ? '' : widget.tradingDay!.low;
    final close = widget.tradingDay == null ? '' : widget.tradingDay!.close;
    final adjClose =
        widget.tradingDay == null ? '' : widget.tradingDay!.adjClose;
    final volume = widget.tradingDay == null ? '' : widget.tradingDay!.volume;

    setState(() {
      controllerDate = TextEditingController(text: date);
      controllerOpen = TextEditingController(text: open);
      controllerHigh = TextEditingController(text: high);
      controllerLow = TextEditingController(text: low);
      controllerClose = TextEditingController(text: close);
      controllerAdjClose = TextEditingController(text: adjClose);
      controllerVolume = TextEditingController(text: volume);
    });
  }

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildDate(),
            const SizedBox(height: 16),
            buildOpen(),
            const SizedBox(height: 16),
            buildHigh(),
            const SizedBox(height: 16),
            buildLow(),
            const SizedBox(height: 16),
            buildClose(),
            const SizedBox(height: 16),
            buildAdjClose(),
            const SizedBox(height: 16),
            buildVolume(),
            const SizedBox(height: 16),
            buildSubmit(),
          ],
        ),
      );

  Widget buildDate() => TextFormField(
        controller: controllerDate,
        //appearance
        decoration: InputDecoration(
          labelText: 'Date',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Date' : null,
      );

  Widget buildOpen() => TextFormField(
        controller: controllerOpen,
        //appearance
        decoration: InputDecoration(
          labelText: 'Open',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Open' : null,
      );

  Widget buildHigh() => TextFormField(
        controller: controllerHigh,
        //appearance
        decoration: InputDecoration(
          labelText: 'High',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter High' : null,
      );

  Widget buildLow() => TextFormField(
        controller: controllerLow,
        //appearance
        decoration: InputDecoration(
          labelText: 'Low',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Low' : null,
      );

  Widget buildClose() => TextFormField(
        controller: controllerClose,
        //appearance
        decoration: InputDecoration(
          labelText: 'Close',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Close' : null,
      );

  Widget buildAdjClose() => TextFormField(
        controller: controllerAdjClose,
        //appearance
        decoration: InputDecoration(
          labelText: 'AdjClose',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter AdjClose' : null,
      );

  Widget buildVolume() => TextFormField(
        controller: controllerVolume,
        //appearance
        decoration: InputDecoration(
          labelText: 'Volume',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Volume' : null,
      );

  Widget buildSubmit() => ButtonWidget(
        text: 'Save',
        onClicked: () {
          final form = formKey.currentState!;
          //user validation
          final isValid = form.validate();
          //collect data from fields
          if (isValid) {
            final tradingDay = TradingDay(
              date: controllerDate.text,
              open: controllerOpen.text,
              high: controllerHigh.text,
              low: controllerLow.text,
              close: controllerClose.text,
              adjClose: controllerAdjClose.text,
              volume: controllerVolume.text,
            );
            //pass data
            widget.onSavedTradingDay(tradingDay);
          }
        },
      );
}
