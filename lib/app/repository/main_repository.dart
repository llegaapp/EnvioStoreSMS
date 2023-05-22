import '../data_source/api_clients.dart';
import '../data_source/local_data_source.dart';
import '../models/smsPush.dart';

class MainRepository {
  final ApiClients _api;

  MainRepository(this._api);

  late Map<String, dynamic> result;
  late Map<String, dynamic> datos;

  Future<int> insertSmsDB(SmsPush item) async {
    return LocalDB.insertSmsDB(item);
  }

  Future<int> updateSmsDB({required int? send, required int? id}) async {
    return LocalDB.updateSmsDB(send: send, id: id);
  }

  Future<int?> getSmsCount({required String where}) async {
    return LocalDB.getSmsCount(where: where);
  }

  Future<List<SmsPush>> getSmsList({required String where}) async {
    return LocalDB.getSmsList(where: where);
  }

  Future<void> dropSmsDB() async {
    return LocalDB.dropSmsDB();
  }
}
