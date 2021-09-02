import 'package:thesis2/model/trading_day.dart';
import 'package:gsheets/gsheets.dart';

class TradingDaysSheetsApi {
  //give service account access to sheets
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "thesis2-324517",
  "private_key_id": "7a132c96895c493fac7de0117101aa86bea67bc8",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQClIhh8JVLsqIAI\nou9xTBU7fC+yK5+UD+U9rGQoxu2RV+LhHI8pTo/NkgwnINQaEEheKwrkS0boJ1XS\n+fQ/XNmyC9Y7nO8KYU0am38JcrL2jTDCLLZnwZ49IlNN09cgnzuNRz6Ni64Q+4Ld\nzRj+C6K+LnY2TCzYdkPyWaY9bZ6/euCg7FokI0Adi3UcmhVp4YU/ekDAUUOoRB9p\nGNIA3TO2I4s1zzJmH/q/0vmLcfrvsDwuC612M7RBxOerELqVUMpy3NZyt0ql60NG\nqlbeOnOhCdh6tW/kFzb48zwjLtIEJzKfgoeTfxxIoX0rDCVGfR7JXs0BQSD7AeA/\nDousEICZAgMBAAECggEAHAZ51lP1S2HbfNu+PGG3tsVASQI7ToMWGk3wH7WHKyQZ\nxq+0okOJh09yjY92P8gkqAqxCga2jX7jg29VYw2MirmUjcB4FzBlSA8806sqMUrM\nDCBPgrNq+iAhuDMsLwanMjZ1qMscaxhsYN1GkRMDdzhmapeqAsCrjm1ll8ZLa16W\nwsIFu1+i7OIyT9FGn6SNeauFsPqBfTkTNv5vfR1S2RtnImxVrJNMasriYej/eLIQ\nD4gwZ5rqcB2Bwm3aCD1LVeoSoWGJgXpvgD6Eyt+zv0zCGJwxzpA95LdergPpYFf6\n2NFhhc8Tj3mt9TVn+ZWWBmLml9JDiP2LbsqVA2uXmwKBgQDgfyLli+hL0i7hF9VI\nFqTcYWmmdl1CeVNB4GQEKXJ2I+35j9iQCnat9VZ16xCiJGKsiMIjXRSt2XcOBUjv\ng9L2VAJJJYQpvqi38IdV7iW4HDvs6scJBMKCrdCsur+CEDMyGcNhkVGZ+Dzjxx1b\ntH3UWmvMs99S8MlyuzlQSiXJWwKBgQC8Tl/s6lJDVQ9sNiAcCBiIXPdDyw8kRzLd\nyR09zbs60QbaAR7gTBpVbniqmRY5WWrAZGjmmCQw89qWPtk3sTHiXOWEq+WZsW/6\nqaa8uy2KmOur2CZqB/z9Xx5ilg0dhKM4uL7sBpsseSBhTUycC0fhyjj1xGRFWePP\nSt3yuywMGwKBgCvz2EI23RkTIoiBYQmHHWnkTIoBvIqKNGm+Y/aIotdMe4gTyKOS\n2N+AHBhkGFKWaxc6gz/nNmg/HlcJY9k45vHBSt1FUhXWNTQmDGkfghUEuhrNcIBs\nhSSOoT9gJKRzRYK2lpEgoWhSuKEj17Sfps8PkPF3+e5EJDypOTRl//XnAoGBALLQ\n0jLOSRP7gEvIEjHMVk+XyI6uE1Dl8528z3HTHcq6mAEJM2LXoeIip5+JBButl7vf\nHeZr72I1DwvB3tAOCkrk4GdePQf4AVhNJjLupE6K7LEg70mdEFcirl38E7RGMiE4\n/sRveYd/9omvt+IurDHzsKdhub5JoBVHCQDpUOilAoGBANuMK2lA+6oxAukrtX/F\nFFX2BXeGmiqSI3qZk0cgKM2yHNDiXpdqfJPuOc2xc2HAmp0IfqPLr93Jm4f/1fk7\nbfFmlLJWbCRkzE8Lk8oZyhRMk0pvl+t/RtLpkRBOV0oLPknVllAkMHnXceu0HhEv\nH5MgwfdBQiCUIWVlvLH8JpAM\n-----END PRIVATE KEY-----\n",
  "client_email": "psei-635@thesis2-324517.iam.gserviceaccount.com",
  "client_id": "114772897627096496755",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/psei-635%40thesis2-324517.iam.gserviceaccount.com"
}
  ''';
  //define sheet id
  static final _spreadsheetID = '1-_hmUp9JVtsN4np8AKHAG8BBr1XeL31jQaz2DuAWT_g';

  //initialize google sheets package
  static final _gsheets = GSheets(_credentials);

  //the worksheet
  static Worksheet? _testSheet;

  //access worksheet
  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetID);
      //which worksheet to extract
      _testSheet = await _getWorkSheet(spreadsheet, title: 'test');
      //get list of fields for the first row
      final firstRow = TradingDayFields.getFields();
      //insert list of fields in first row
      _testSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      //if worksheet doesn't exist
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      //return the spreadsheet
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  //get number of rows
  static Future<int> getRowCount() async {
    if (_testSheet == null) return 0;
    //get the last row in worksheet
    final lastRow = await _testSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<List<TradingDay>> getAll() async {
    if (_testSheet == null) return <TradingDay>[];

    final tradingDays = await _testSheet!.values.map.allRows();
    return tradingDays == null
        ? <TradingDay>[]
        : tradingDays.map(TradingDay.fromJson).toList();
  }

  //get values of one trading day using id
  static Future<TradingDay?> getById(int id) async {
    if (_testSheet == null) return null;

    final json = await _testSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : TradingDay.fromJson(json);
  }

  //append row of data
  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_testSheet == null) return;

    _testSheet!.values.map.appendRows(rowList);
  }
}
