
import 'package:api_provider_016/config/routes/route_name.dart';
import 'package:api_provider_016/view/login/widgets.dart/input_email_widgets.dart';
import 'package:api_provider_016/view/login/widgets.dart/input_password_widgets.dart';

import 'package:api_provider_016/view/login/widgets.dart/sign_up_button_widgets.dart';

import 'package:flutter/material.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SignUpScreen> {
  final TextEditingController _emialController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emialController.dispose();
    _passwordController.dispose();
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
            SignUpButtonWidget(),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.login);
                },
                child: const Text("Already have an account? Login"))
          ],
        ),
      ))),
    );
  }
}
