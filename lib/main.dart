import 'package:flutter/material.dart';
import 'package:jellywaves/login/login.dart';
import 'package:jellywaves/home/nav.dart';
import 'package:jellywaves/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authStorage = AuthStorage();
  final token = await authStorage.getToken();

  debugPrint("token: $token");

  runApp(
    MyApp(
      isLoggedIn: token != null
    )
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({
    super.key,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: isLoggedIn ? "/nav" : "/login",
      routes: {
        "/login": (context) => LoginScreen(),
        "/nav": (context) => NavScreen(),
      }
    );
  }
}
