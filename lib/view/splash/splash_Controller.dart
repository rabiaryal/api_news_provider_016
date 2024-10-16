import 'dart:async';
import 'package:api_provider_016/config/routes/route_name.dart';
import 'package:api_provider_016/services/session_controller.dart';
import 'package:flutter/material.dart';


class SplashServices {

  void checkAuthentication(BuildContext context)async{

    SessionController().getUserFromPreference().then((value)async{

      if(SessionController().isLogin!){
        Timer(const Duration(seconds: 2),
              () =>
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false),
        );
      }else {
        Timer(const Duration(seconds: 2),
              () =>
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false),
        );

      }

    }).onError((error, stackTrace){

      Timer(const Duration(seconds: 2),
            () =>
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false),
      );

    });

  }



}