import 'package:dio/dio.dart';


class ApiClients {
  Map<String, dynamic> datos = Map<String, dynamic>();
  late Response response;

  Dio dio = Dio();
  var apidata;
  bool error = false;
  bool loading = false;
  bool cache = false;
  String errmsg = "";

  get developer => null;
}
