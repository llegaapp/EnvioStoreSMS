import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/config/app_constants.dart';
import 'app/config/app_string.dart';
import 'app/config/app_theme.dart';
import 'app/config/app_utils.dart';
import 'app/data_source/api_clients.dart';
import 'app/modules/home/home_binding.dart';
import 'app/modules/home/home_page.dart';
import 'app/repository/main_repository.dart';
import 'app/services/listeners.dart';
import 'app/services/push_notification_service.dart';
import 'dart:io' show Platform;

AppTheme themeApp = AppTheme();

void main() async {
  themeApp.init();
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

  final apiClients = ApiClients();
  final mainRepository = MainRepository(apiClients);
  Get.put(mainRepository);
  await GetStorage.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(AppGestion());
}

class AppGestion extends StatefulWidget {
  @override
  State<AppGestion> createState() => _AppGestionState();
}

class _AppGestionState extends State<AppGestion> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      AppUtils.solicitarEnvioSMS();
    }
    AppUtils.areSimCards();
    AppUtils.prefs.smsFiltredBy = AppConstants.SMS_STATUS_ALL;
    PushNotificationService.messageStream
        .listen((message) async => Listeners.listenPush(message));
    AppUtils.prefs.fireBaseToken = PushNotificationService.token!;
    print(AppUtils.prefs.fireBaseToken);
  }

  @override
  Widget build(BuildContext context) {
    var _theme = ThemeData(
      fontFamily: 'TitilliumWeb',
      primarySwatch: themeApp.primarySwatch,
    );

    return GetMaterialApp(
      title: titleAppStr,
      debugShowCheckedModeBanner: false,
      theme: _theme,
      home: HomePage(),
      initialBinding: HomeBinding(),
    );
  }
}
