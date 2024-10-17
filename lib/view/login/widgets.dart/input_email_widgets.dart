import 'package:api_provider_016/config/components/utils.dart';
import 'package:api_provider_016/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class InputEmailWidget extends StatelessWidget {
  final FocusNode emailfocusNode , passwordFocusNode;
  const InputEmailWidget({Key? key ,required this.emailfocusNode , required this.passwordFocusNode}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
        builder: (context, provider, child){
          return TextFormField(
            keyboardType: TextInputType.emailAddress,
            focusNode: emailfocusNode,
            decoration: InputDecoration(
                  hintText: "xyz@gmail.com",
                  labelText: "Enter Email",
                  prefixIcon: const Icon(Icons.alternate_email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
             onFieldSubmitted: (value){
              Utils.fieldFocusChange(context, emailfocusNode, passwordFocusNode);
            },
            onChanged: (value){
              provider.setEmail(value);
            },
          );
        }
    );
  }
}