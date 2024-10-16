import 'package:api_provider_016/config/routes/route_name.dart';
import 'package:api_provider_016/repository/auth/auth_firebase.dart';
import 'package:flutter/material.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Auth auth = Auth();
          // LocalStorage localStorage = LocalStorage();
          auth.signOut().then((value) {
            Navigator.pushNamed(context, RoutesName.login);
          });

          // localStorage.clearValue('token').then((value) {
          //   Navigator.pushNamed(context, RoutesName.login);
          // });
        },
        child: const Center(child: Text('Logout')));
  }
}
