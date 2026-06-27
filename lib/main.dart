import 'package:flutter/material.dart';
import 'package:jellywaves/login/login.dart';
import 'package:jellywaves/home/nav.dart';
import 'package:jellywaves/services/auth.dart';
import 'package:jellywaves/services/jellyfin_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp()
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override 
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authStorage = AuthStorage();

  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override 
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final token = await authStorage.getToken();
    final serverUrl = await authStorage.getServer();

    if (token != null && serverUrl != null) {
      await JellyfinApi.initialize(baseUrl: serverUrl);
      _isLoggedIn = true;
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _handleLogin() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override 
  Widget build(BuildContext context) {
    if(_isLoading) {
      return const MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xff1A1A1A),
          body: Center(
            child: CircularProgressIndicator()
          )
        )
      );
    }

    return MaterialApp(
      home: _isLoggedIn 
        ? NavScreen(onLogout: _handleLogout)
        : LoginScreen(onLogin: _handleLogin)
    );
  }
}
