
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDYczyXEONBftf-6qhT1-ilgkrvyq1ArvQ',
    appId: '1:1099261895902:web:cd022208091fe6ae51ce4f',
    messagingSenderId: '1099261895902',
    projectId: 'idenzza',
    authDomain: 'idenzza.firebaseapp.com',
    storageBucket: 'idenzza.firebasestorage.app',
    measurementId: 'G-WSY53E0J2Z',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDYczyXEONBftf-6qhT1-ilgkrvyq1ArvQ',
    appId: '1:1099261895902:web:cd022208091fe6ae51ce4f',
    messagingSenderId: '1099261895902',
    projectId: 'idenzza',
    authDomain: 'idenzza.firebaseapp.com',
    storageBucket: 'idenzza.firebasestorage.app',
    measurementId: 'G-WSY53E0J2Z',
  );
}
