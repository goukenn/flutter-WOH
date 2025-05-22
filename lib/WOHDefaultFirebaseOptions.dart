// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: WOHDefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class WOHDefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'WOHDefaultFirebaseOptions have not been configured for macos - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'WOHDefaultFirebaseOptions have not been configured for windows - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'WOHDefaultFirebaseOptions have not been configured for linux - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'WOHDefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDVZvPIYeGozE7rU8PD6wFSImJZovUGJ58",
    appId: "1:754693177402:android:9dd6a4dd360330ea893503",
    messagingSenderId: "754693177402",
    projectId: "hubkilo-trial",
    androidClientId: "754693177402-591j5gue73i5mm7u80r3rd5jrh2scmvj.apps.googleusercontent.com",
    storageBucket: "hubkilo-trial.appspot.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyDVZvPIYeGozE7rU8PD6wFSImJZovUGJ58",
    appId: "1:754693177402:android:9dd6a4dd360330ea893503",
    messagingSenderId: "754693177402",
    projectId: "hubkilo-trial",
    storageBucket: "hubkilo-trial.appspot.com",
    iosClientId: '739267820418-ego0tsnaktg58eca2o74m3gqiv5sbt8c.apps.googleusercontent.com',
    iosBundleId: 'com.hubkiloservice.app',
  );
}