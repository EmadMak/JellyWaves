import 'package:flutter/material.dart';
import 'package:jellywaves/login/login_utils/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override 
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController urlController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  FocusNode urlFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      body: _buildLoginScreen()
    );
  }

  Widget _buildLoginScreen() {
    return 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildLoginBox(
            onChanged: (_) => setState(() {}),
            urlController: urlController,
            urlFocusNode: urlFocusNode,
            nameController: nameController,
            nameFocusNode: nameFocusNode
          )
        ],
      );
  }

}
