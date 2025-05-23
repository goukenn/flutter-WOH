// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/localizations.dart';
// import 'package:flutter/flutter_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
// import 'app/models/WOHNotificationModel.dart';
// import 'app/providers/firebase_provider.dart';
// import 'app/providers/WOHLaravelApiClientProvider.dart';
// import 'app/routes/theme1_app_pages.dart';
// import 'app/services/auth_service.dart';
// import 'app/services/firebase_messaging_service.dart';
// import 'app/services/WOHGlobalService.dart';
// import 'app/services/WOHSettingsService.dart';

import 'WOHConstants.dart';
import 'WOHDefaultFirebaseOptions.dart';
import 'WOHMyHttpOverrides.dart';
import 'app/models/WOHModelNotificationModel.dart';
// import 'app/providers/WOHLaravelApiClientProvider.dart';
// import 'app/routes/WOHThemeAppPages.dart';
// import 'app/services/WOHFireBaseMessagingService.dart';
// import 'app/services/WOHSettingsService.dart';
// import 'app/services/WOHGlobalService.dart';
// import 'app/routes/WOHThemeAppPages.dart';
// import 'app/services/WOHFireBaseMessagingService.dart';
// import 'app/models/WOHModelNotificationModel.dart';
// import 'app/providers/firebase_provider.dart';
// import 'app/providers/laravel_provider.dart';
// import 'app/routes/WOHThemeAppPages.dart'; 
// import 'app/services/auth_service.dart';
// import 'app/services/firebase_messaging_service.dart';

// + declare global variable
AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Checks JOB DATA' + WOHConstants.serverPort,
          ),
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  DartPluginRegistrant.ensureInitialized();
  await Firebase.initializeApp(options: WOHDefaultFirebaseOptions.currentPlatform);

  WOHDefaultFirebaseOptions.currentPlatform;

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }

  final remoteModel = WOHModelNotificationModel(
    title: message.notification?.title.toString(),
    id: message.messageId.toString(),
    isSeen: false,
    message: message.notification?.body.toString(),
    timestamp: message.sentTime.toString(),
    disable: false,
  );

  await Hive.initFlutter();
  if (Hive.isBoxOpen('backgroundMessage')) {
    await Hive.box('backgroundMessage').close();
  }

  await Hive.openBox('backgroundMessage');
  final bgBox = Hive.box("backgroundMessage");
  bgBox.add(remoteModel.toJson());
  bgBox.close();
}

void initServices() async {
  Get.log('starting services ...');

    await GetStorage.init();
    // await Get.putAsync(() => WOHGlobalService().init());
    await Firebase.initializeApp();
    if (Firebase.apps.isEmpty) {
      Firebase.initializeApp();
    } else {
      Firebase.app();
    }// if already initialized, use that one
    
    // await Get.putAsync(() => WOHAuthService().init());
    // await Get.putAsync(() => WOHLaravelApiClientProvider().init());
    // await Get.putAsync(() => WOHFirebaseProviderProvider().init());
    // await Get.putAsync(() => WOHSettingsService().init());
    //await Get.putAsync(() => TranslationService().init());
    Get.log('All services started...');

    final box = GetStorage();
}

void mainMM() async {
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = WOHMyHttpOverrides();
    await Firebase.initializeApp(
      name: 'willonhair-v3',
      options: WOHDefaultFirebaseOptions.currentPlatform,
    );
    initServices();

     await Hive.initFlutter();
     await Hive.openBox('myBox');
     await Hive.openBox('notifications');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
          "high_importance_channel", 'High Importance Notifications');
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          ?.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel!);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
    }

/*

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
      GetMaterialApp(
        title: WOHConstants.AppName,
        initialRoute: WOHThemeAppPages.INITIAL,
        onReady: () async {
          await Get.putAsync(() => WOHFireBaseMessagingService().init());
        },
        getPages: WOHThemeAppPages.routes,
        // localizationsDelegates: GlobalMaterialLocalizations.delegates,
        //supportedLocales: Get.find<TranslationService>().supportedLocales(),
        //translationsKeys: Get.find<TranslationService>().translations,
        //locale: Get.find<TranslationService>().getLocale(),
        //fallbackLocale: Get.find<TranslationService>().getLocale(),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        themeMode: Get.find<WOHSettingsService>().getThemeMode(),
        theme: Get.find<WOHSettingsService>().getLightTheme(),
        darkTheme: Get.find<WOHSettingsService>().getDarkTheme(),
      ),
    ),
  );

*/


}