import 'dart:convert';

final epoch = new DateTime(1899 - 12 - 30);

class TradingDayFields {
  static final String id = 'id';
  static final String date = 'date';
  static final String open = 'open';
  static final String high = 'high';
  static final String low = 'low';
  static final String close = 'close';
  static final String adjClose = 'adjClose';
  static final String volume = 'volume';

  //to get the list of strings
  static List<String> getFields() =>
      [id, date, open, high, low, close, adjClose, volume];
}

class TradingDay {
  final int? id;
  final String date;
  final String open;
  final String high;
  final String low;
  final String close;
  final String adjClose;
  final String volume;

  const TradingDay({
    this.id,
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.adjClose,
    required this.volume,
  });

  //it's a literal copy what do you expect
  TradingDay copy({
    int? id,
    String? date,
    String? open,
    String? high,
    String? low,
    String? close,
    String? adjClose,
    String? volume,
  }) =>
      TradingDay(
        id: id ?? this.id,
        date: date ?? this.date,
        open: open ?? this.open,
        high: high ?? this.high,
        low: low ?? this.low,
        close: close ?? this.close,
        adjClose: adjClose ?? this.adjClose,
        volume: volume ?? this.volume,
      );

//fix values from json method
  static TradingDay fromJson(Map<String, dynamic> json) => TradingDay(
        id: jsonDecode(json[TradingDayFields.id]),
        date: json[TradingDayFields.date],
        open: json[TradingDayFields.open],
        high: json[TradingDayFields.high],
        low: json[TradingDayFields.low],
        close: json[TradingDayFields.close],
        adjClose: json[TradingDayFields.adjClose],
        volume: json[TradingDayFields.volume],
      );

//fix values into json method
  Map<String, dynamic> toJson() => {
        TradingDayFields.id: id,
        TradingDayFields.date: date,
        TradingDayFields.open: open,
        TradingDayFields.high: high,
        TradingDayFields.low: low,
        TradingDayFields.close: close,
        TradingDayFields.adjClose: adjClose,
        TradingDayFields.volume: volume,
      };
}
