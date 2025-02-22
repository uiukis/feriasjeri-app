import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return macos;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBTVqtmNyf1jAHFyFnzPSKAlnPTzb5DO5I',
    appId: '1:1003092382547:web:0968d9ce770a0ce2a187a6',
    messagingSenderId: '1003092382547',
    projectId: 'feriasjeri-app',
    authDomain: 'feriasjeri-app.firebaseapp.com',
    storageBucket: 'feriasjeri-app.firebasestorage.app',
    measurementId: 'G-NFCTY21TNW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPpc3xt-rTW_IS_tPZORkSJ98-A3YWfjE',
    appId: '1:1003092382547:android:e908a499d646527ca187a6',
    messagingSenderId: '1003092382547',
    projectId: 'feriasjeri-app',
    storageBucket: 'feriasjeri-app.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8aBrYoBJ9XhVZoMnmxiMUsWUGfkOXTw0',
    appId: '1:1003092382547:ios:763c780ff49bf004a187a6',
    messagingSenderId: '1003092382547',
    projectId: 'feriasjeri-app',
    storageBucket: 'feriasjeri-app.firebasestorage.app',
    iosBundleId: 'com.example.feriasjeriApp',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8aBrYoBJ9XhVZoMnmxiMUsWUGfkOXTw0',
    appId: '1:1003092382547:ios:763c780ff49bf004a187a6',
    messagingSenderId: '1003092382547',
    projectId: 'feriasjeri-app',
    storageBucket: 'feriasjeri-app.firebasestorage.app',
    iosBundleId: 'com.example.feriasjeriApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCUjpBy4xSXU6RtLOMLj8swuXTKgMTAR8Q',
    appId: '1:1003092382547:web:5060e9710c03f46ea187a6',
    messagingSenderId: '1003092382547',
    projectId: 'feriasjeri-app',
    authDomain: 'feriasjeri-app.firebaseapp.com',
    storageBucket: 'feriasjeri-app.firebasestorage.app',
    measurementId: 'G-T5Q4WES5GY',
  );
}
