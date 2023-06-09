// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCNU5UU5cliNx6Nnti_F4KQfoalZ2TKtjs',
    appId: '1:556933853493:web:8c6bf3e6c79596e5161c7c',
    messagingSenderId: '556933853493',
    projectId: 'wotd-kiet',
    authDomain: 'wotd-kiet.firebaseapp.com',
    storageBucket: 'wotd-kiet.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJADaxMXilvzqnB3xBokCc2EqhyNtpCek',
    appId: '1:556933853493:android:316403d73e0e5d9b161c7c',
    messagingSenderId: '556933853493',
    projectId: 'wotd-kiet',
    storageBucket: 'wotd-kiet.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANO7pVRTvk6Fm-YnEAQvDq-pAg7FzAYKE',
    appId: '1:556933853493:ios:550465f9c1d0dbb5161c7c',
    messagingSenderId: '556933853493',
    projectId: 'wotd-kiet',
    storageBucket: 'wotd-kiet.appspot.com',
    androidClientId: '556933853493-r8jnhlb7bk300l6vf2oeedhd5nbo4q7g.apps.googleusercontent.com',
    iosClientId: '556933853493-glrqpe74gk26kd9nvs3hduac4bggssiq.apps.googleusercontent.com',
    iosBundleId: 'com.example.wotdKiet',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyANO7pVRTvk6Fm-YnEAQvDq-pAg7FzAYKE',
    appId: '1:556933853493:ios:550465f9c1d0dbb5161c7c',
    messagingSenderId: '556933853493',
    projectId: 'wotd-kiet',
    storageBucket: 'wotd-kiet.appspot.com',
    androidClientId: '556933853493-r8jnhlb7bk300l6vf2oeedhd5nbo4q7g.apps.googleusercontent.com',
    iosClientId: '556933853493-glrqpe74gk26kd9nvs3hduac4bggssiq.apps.googleusercontent.com',
    iosBundleId: 'com.example.wotdKiet',
  );
}
