// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA1APUALSEAKp7Y7LSokXRDW3W4u9fPxOE',
    appId: '1:322805337020:web:4e185e1bce399d8cafb9b9',
    messagingSenderId: '322805337020',
    projectId: 'webcustomer-7bc4f',
    authDomain: 'webcustomer-7bc4f.firebaseapp.com',
    storageBucket: 'webcustomer-7bc4f.firebasestorage.app',
    measurementId: 'G-FHGRGEH4JC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBctGHaxtzXfEcMQ-dnFUYHbQHEXXNXokg',
    appId: '1:322805337020:android:551f9d46f3393445afb9b9',
    messagingSenderId: '322805337020',
    projectId: 'webcustomer-7bc4f',
    storageBucket: 'webcustomer-7bc4f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCY4KSRX1TnlnAd3a37354RnOpZZ4q5qFU',
    appId: '1:322805337020:ios:2e0f450615ecd3e6afb9b9',
    messagingSenderId: '322805337020',
    projectId: 'webcustomer-7bc4f',
    storageBucket: 'webcustomer-7bc4f.firebasestorage.app',
    iosBundleId: 'com.example.webCustomer',
  );
}
