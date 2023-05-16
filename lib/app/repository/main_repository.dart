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

  Future<List<SmsPush>> getSmsList(bool bySend) async {
    return LocalDB.getSmsList(bySend);
  }

  Future<void> dropSmsDB() async {
    return LocalDB.dropSmsDB();
  }

  Future<Map<String, dynamic>> getAppHomePokemonList(
      int skip, int limit) async {
    return _api.getAppHomePokemonList(skip, limit);
  }

  Future<Map<String, dynamic>> getAppHomePokemonDetailList(String url) async {
    return _api.getAppHomePokemonDetailList(url);
  }
}
