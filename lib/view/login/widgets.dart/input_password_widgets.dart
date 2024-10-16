import 'package:api_provider_016/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class InputPasswordWidget extends StatelessWidget {
   InputPasswordWidget({Key? key ,required this.focusNode}) : super(key: key);

  final FocusNode focusNode;
  final ValueNotifier<bool> _obSecurePassword = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
        builder: (context, provider, child){
          return ValueListenableBuilder(
              valueListenable: _obSecurePassword,
              builder: (context , value, child){
                return TextFormField(
                  obscureText: _obSecurePassword.value,
                  focusNode: focusNode,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_open_rounded),
                    suffixIcon: InkWell(
                        onTap: (){
                          _obSecurePassword.value = !_obSecurePassword.value ;
                        },
                        child: Icon(
                            _obSecurePassword.value ?  Icons.visibility_off_outlined :
                            Icons.visibility
                        )),
                         border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                  onChanged: (value){
                    provider.setPassword(value);
                  },
                );

              }
          );
        }
    );
  }
}