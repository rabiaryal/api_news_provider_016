

import 'package:api_provider_016/config/routes/route_name.dart';
import 'package:api_provider_016/view/login/widgets.dart/input_email_widgets.dart';
import 'package:api_provider_016/view/login/widgets.dart/input_password_widgets.dart';
import 'package:api_provider_016/view/login/widgets.dart/login_button_widgets.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<LoginScreen> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    FocusScope.of(context).unfocus(); 
  });
    
  }

  @override
  void dispose() {
    super.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: SafeArea(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputEmailWidget(
                emailfocusNode: emailFocusNode,
                passwordFocusNode: passwordFocusNode),
            SizedBox(
              height: height * .02,
            ),
            InputPasswordWidget(focusNode: passwordFocusNode),
            SizedBox(height: height * 0.03),
            const LoginButtonWidget(),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.signUp);
                },
                child: const Text("Don't have an account ? SignUp"))
          ],
        ),
      ))),
    );
  }
}
