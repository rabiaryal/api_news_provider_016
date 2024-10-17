import 'package:api_provider_016/config/components/rooundbutton.dart';
import 'package:api_provider_016/config/components/utils.dart';
import 'package:api_provider_016/config/routes/route_name.dart';
import 'package:api_provider_016/config/validator/email_validator.dart';
import 'package:api_provider_016/view_model/login_view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, provider, child) {
        return RoundButton(
          title: 'Login',
          loading:
              provider.isLoading, // Using the loading state from AuthViewModel
          onPress: () async {
            FocusScope.of(context).unfocus();

            if (provider.email.isEmpty) {
              Utils.flushBarErrorMessage('Please enter an email', context);
            } else if (!AppValidator.emailValidator(provider.email)) {
              Utils.flushBarErrorMessage('Please enter a valid email', context);
            } else if (provider.password.isEmpty) {
              Utils.flushBarErrorMessage('Please enter a password', context);
            } else if (provider.password.length < 6) {
              Utils.flushBarErrorMessage(
                  'Password must be at least 6 characters long', context);
            } else {
              try {
                await provider.login(context); // Call login from AuthViewModel

                if (provider.errorMessage == null) {
                  Utils.flushBarErrorMessage("Login Successful", context);

                  Navigator.pushNamed(
                    context,
                    RoutesName.display,
                  );
                } else {
                  // Display error message if there is an issue
                  Utils.flushBarErrorMessage(provider.errorMessage!, context);
                }
              } catch (e) {
                // If there's an exception, show the error message
                Utils.flushBarErrorMessage(e.toString(), context);
              }
            }
          },
        );
      },
    );
  }
}
