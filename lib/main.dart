import 'package:api_provider_016/config/routes/route_name.dart';
import 'package:api_provider_016/config/routes/routes.dart';

import 'package:api_provider_016/repository/auth/auth_firebase.dart';

import 'package:api_provider_016/view_model/login_view_model.dart';
import 'package:api_provider_016/view_model/news_api_model.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// news api key= 372c8b2d39164f998b78fff225053d43

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel(authRepository: Auth())),
          ChangeNotifierProvider(create: (_) => NewsProvider()),


        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: RoutesName.login,
          onGenerateRoute: Routes.generateRoute,
        )

        // home: LoginScreen()) ,
        );
  }
}
