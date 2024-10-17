import 'dart:async';
import 'package:api_provider_016/config/routes/route_name.dart';
import 'package:api_provider_016/view_model/splash/session_controller.dart';
import 'package:flutter/material.dart';

class SplashServices {
  // Check authentication using Firebase
  void checkAuthentication(BuildContext context) async {
    await SessionController().getUserFromFirebase();
    
    if (SessionController().isLogin!) {
      // User is logged in, navigate to Home screen
      Timer(const Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.display, (route) => false
        );
      });
    } else {
      // User is not logged in, navigate to Login screen
      Timer(const Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.login, (route) => false
        );
      });
    }
  }
}
