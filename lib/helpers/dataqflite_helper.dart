import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sql;

import '../const.dart';

class DataSqflite {
  static Future<Database> database() async {
    sql.sqfliteFfiInit();
    final databaseFactory = sql.databaseFactoryFfi;
    // final pathData = path.join(databaseFactory.toString(), 'misapay.db');
    return await databaseFactory.openDatabase(pathData);
  }

  static Future<List<Map<String, dynamic>>> getData(String key) async {
    final data = await database();
    return await data.query(key);
  }
}
