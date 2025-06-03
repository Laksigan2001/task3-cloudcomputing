// File: lib/firebase_options.dart
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIza...webKey",
    authDomain: "your-app.firebaseapp.com",
    projectId: "your-app",
    storageBucket: "your-app.appspot.com",
    messagingSenderId: "123456789",
    appId: "1:123456789:web:abc123",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIza...androidKey",
    appId: "1:123456789:android:abc123",
    messagingSenderId: "123456789",
    projectId: "your-app",
    storageBucket: "your-app.appspot.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIza...iosKey",
    appId: "1:123456789:ios:abc123",
    messagingSenderId: "123456789",
    projectId: "your-app",
    storageBucket: "your-app.appspot.com",
    iosClientId: "123456789.apps.googleusercontent.com",
    iosBundleId: "com.example.yourApp",
  );
}
