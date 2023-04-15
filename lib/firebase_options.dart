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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHhm9LcKLYCMarASWo4XiGSwMHldqpLzk',
    appId: '1:236232584201:android:0c9fb5212861c0d032dcd8',
    messagingSenderId: '236232584201',
    projectId: 'quit-smoking-ffce6',
    storageBucket: 'quit-smoking-ffce6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBinJ_pXBszk1GJLPA4vyTc0HYvs2AKvcE',
    appId: '1:236232584201:ios:c04a8110093ba69e32dcd8',
    messagingSenderId: '236232584201',
    projectId: 'quit-smoking-ffce6',
    storageBucket: 'quit-smoking-ffce6.appspot.com',
    androidClientId: '236232584201-gq29eqm62a47n3n7mi2851i4442sc4i2.apps.googleusercontent.com',
    iosClientId: '236232584201-h06v58vfv7f4n2hhi884stf3d940vb99.apps.googleusercontent.com',
    iosBundleId: 'com.example.newQc',
  );
}
