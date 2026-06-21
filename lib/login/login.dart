import 'package:flutter/material.dart';
import 'package:jellywaves/login/login_utils/components.dart';
import 'package:jellywaves/services/jellyfin_api.dart';
import 'package:jellywaves/services/auth.dart';
import 'package:jellywaves/network/http_client_factory.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override 
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController urlController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode urlFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool _isFormValid() {
    return urlController.text.isNotEmpty &&
      nameController.text.isNotEmpty &&
      passwordController.text.isNotEmpty;
  }
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      resizeToAvoidBottomInset: false,
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
            nameFocusNode: nameFocusNode,
            passwordController: passwordController,
            passwordFocusNode: passwordFocusNode
          ),
          SizedBox(height: 10),
          connectButton(
            enabled: _isFormValid(),
            onPressed: () async {
              try {
                final authStorage = AuthStorage();
                final client = await buildHttpClient();

                final api = JellyfinApi(
                  baseUrl: urlController.text,
                  client: client
                );

                final token = await api.login(
                  username: nameController.text,
                  password: passwordController.text
                );
                
                authStorage.saveSession(token: token, serverUrl: urlController.text);
                Navigator.of(context).pushReplacementNamed("/nav");
              } catch (e) {
                debugPrint("Error: $e");
              }
            }
          )
        ],
      );
  }

}
