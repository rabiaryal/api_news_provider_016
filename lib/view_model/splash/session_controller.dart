import 'dart:convert';
import 'package:api_provider_016/view_model/splash/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SessionController {
  LocalStorage sharedPreferenceClass = LocalStorage();
  static final SessionController _session = SessionController._internal();

  bool? isLogin;
  Map<String, dynamic>? user;

  factory SessionController() {
    return _session;
  }

  SessionController._internal() {
    isLogin = false;
  }

  // Save user session using Firebase Authentication
  Future<void> saveUserInPreference(User? firebaseUser) async {
    if (firebaseUser != null) {
      // Manually create a Map<String, dynamic> to store the Firebase user details
      final userMap = {
        'uid': firebaseUser.uid,
        'email': firebaseUser.email,
        'displayName': firebaseUser.displayName,
        'photoURL': firebaseUser.photoURL,
      };

      await sharedPreferenceClass.setValue('token', jsonEncode(userMap)); // Save the user data as JSON string
      await sharedPreferenceClass.setValue('isLogin', 'true');
    }
  }

  // Retrieve user from Firebase authentication
  Future<void> getUserFromFirebase() async {
    try {
      User? firebaseUser = FirebaseAuth.instance.currentUser;
      isLogin = firebaseUser != null;
      if (isLogin!) {
        user = {
          'uid': firebaseUser!.uid,
          'email': firebaseUser.email,
          'displayName': firebaseUser.displayName,
          'photoURL': firebaseUser.photoURL,
        };
      }
    } catch (e) {
      // debugPrint(e.toString());
      isLogin = false;
    }
  }

  // Logging out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await sharedPreferenceClass.clearValue('token');
    await sharedPreferenceClass.clearValue('isLogin');
    isLogin = false;
  }
}
