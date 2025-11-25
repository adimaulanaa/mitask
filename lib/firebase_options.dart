// lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  /// -------------------------
  /// ANDROID CONFIG (VALID)
  /// -------------------------
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyADFYBX3l0i9AmvftFwNG8mDq99EGlWpxc",
    appId: "1:715079088355:android:c17c2af52527555b85add6",
    messagingSenderId: "715079088355",
    projectId: "mitask-6b25a",
    storageBucket: "mitask-6b25a.firebasestorage.app",
  );

  /// -------------------------
  /// iOS CONFIG (VALID)
  /// -------------------------
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyCGIamP3QyKDgCHJ3CjJMsS4FGK_uVcoeU",
    appId: "1:715079088355:ios:aa6a92be3bee270785add6",
    messagingSenderId: "715079088355",
    projectId: "mitask-6b25a",
    storageBucket: "mitask-6b25a.firebasestorage.app",
    iosBundleId: "com.bantraka.mitask",
  );

  /// -------------------------
  /// macOS CONFIG (boleh hapus kalau tidak pakai)
  /// Disamakan dengan iOS karena Firebase memakai file yang sama
  /// -------------------------
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyCGIamP3QyKDgCHJ3CjJMsS4FGK_uVcoeU",
    appId: "1:715079088355:ios:aa6a92be3bee270785add6",
    messagingSenderId: "715079088355",
    projectId: "mitask-6b25a",
    storageBucket: "mitask-6b25a.firebasestorage.app",
    iosBundleId: "com.bantraka.mitask",
  );
}
