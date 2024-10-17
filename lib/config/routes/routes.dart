



import 'package:api_provider_016/config/routes/route_name.dart';

import 'package:api_provider_016/view/display/display_format.dart';
import 'package:api_provider_016/view/home/home_screen.dart';
import 'package:api_provider_016/view/login/login_screen.dart';
import 'package:api_provider_016/view/login/sign_up_screen.dart';
import 'package:api_provider_016/view/splash/splash_view.dart';
import 'package:flutter/material.dart';


class Routes {

  static Route<dynamic>  generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());

      case RoutesName.display:
        return MaterialPageRoute(builder: (BuildContext context) => const DisplayMainUnit());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen(apiUrl: '',));

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginScreen());

       case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context) => const SignUpScreen());

      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });

    }
  }
}