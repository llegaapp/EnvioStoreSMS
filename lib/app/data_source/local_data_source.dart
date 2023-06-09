import 'package:enviostoresms/app/models/smsPush.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../config/constant.dart';
import '../config/utils.dart';

class LocalDB {
  static Future<Database> _openDB() async {
    List<String> queries = [];
    String _sql;
    String _nameDB = '';

    _sql = "CREATE TABLE IF NOT EXISTS SMS( ";
    _sql = _sql + "   id INTEGER PRIMARY KEY AUTOINCREMENT,";
    _sql = _sql + "   phone          TEXT      NOT NULL,";
    _sql = _sql + "   name           TEXT      NOT NULL,";
    _sql = _sql + "   message        TEXT      NOT NULL,";
    _sql = _sql + "   send         INTEGER  ,";
    _sql = _sql + "   date           TEXT      NOT NULL";
    _sql = _sql + ");";

    queries.add(_sql);

    // Crea la base de datos en caso de que no exista y crea las tablas
    _nameDB = Utils.getNameDB();
    return openDatabase(join(await getDatabasesPath(), _nameDB),
        onCreate: (db, version) async {
      for (String query in queries) {
        await db.execute(query);
      }
    }, version: 1);
  }

  static Future<int> insertSmsDB(SmsPush item) async {
    Database database = await _openDB();
    return database.insert("SMS", item.toMap());
  }

  static Future<void> dropSmsDB() async {
    Database database = await _openDB();
    final batch = database.batch();
    batch.delete("SMS");
    await batch.commit(noResult: true);
  }

  static Future<int?> getSmsCount({required String where}) async {
    Database database = await _openDB();
    String _where = '';
    if (where == Constant.SMS_STATUS_SEND) _where = 'WHERE send= 1';
    if (where == Constant.SMS_STATUS_NOT_SEND) _where = 'WHERE send= 0';
    if (where == Constant.SMS_STATUS_ALL) _where = '';
    var result = Sqflite.firstIntValue(await database
        .rawQuery("SELECT count(*) as num FROM SMS $_where ORDER BY ID DESC "));
    return result;
  }

  static Future<List<SmsPush>> getSmsList({required String where}) async {
    Database database = await _openDB();
    String _where = '';
    if (where == Constant.SMS_STATUS_SEND) _where = 'WHERE send= 1';
    if (where == Constant.SMS_STATUS_NOT_SEND) _where = 'WHERE send= 0';
    if (where == Constant.SMS_STATUS_ALL) _where = '';
    String query = "SELECT * FROM SMS $_where ORDER BY ID DESC ";
    final List<Map<String, dynamic>> itemsMap = await database.rawQuery(query);
    return List.generate(
        itemsMap.length,
        (i) => SmsPush(
            id: itemsMap[i]['id'],
            phone: itemsMap[i]['phone'].toString(),
            name: itemsMap[i]['name'].toString(),
            message: itemsMap[i]['message'].toString(),
            date: itemsMap[i]['date'].toString(),
            send: itemsMap[i]['send']));
  }

  static Future<int> updateSmsDB({required int? send, required int? id}) async {
    Database database = await _openDB();

    String query = "UPDATE SMS SET send = $send WHERE id = $id; ";
    var result = await database.rawUpdate(query);
    return result;
  }
}
