import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
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
    apiKey: "AIzaSyDRGH1W-x0SgJo7rSJM3C7DKhwmLOd8sm0",
    authDomain: "mad-internal-practical.firebaseapp.com",
    projectId: "mad-internal-practical",
    storageBucket: "mad-internal-practical.firebasestorage.app",
    messagingSenderId: "270249682689",
    appId: "1:270249682689:web:e24bf6c0b05e7bd35f5d00",
    measurementId: "G-FXD7Z9V24P",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDRGH1W-x0SgJo7rSJM3C7DKhwmLOd8sm0",
    appId: "1:270249682689:android:e24bf6c0b05e7bd35f5d00",
    messagingSenderId: "270249682689",
    projectId: "mad-internal-practical",
    storageBucket: "mad-internal-practical.firebasestorage.app",
  );
} 