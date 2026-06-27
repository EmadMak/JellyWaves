import 'package:flutter/material.dart';
import 'package:jellywaves/home/settings/components.dart';
import 'package:jellywaves/services/auth.dart';
import 'package:jellywaves/utils/text.dart';
import 'package:jellywaves/utils/buttons.dart';
import 'package:jellywaves/services/jellyfin_api.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const SettingsScreen({
    super.key,
    required this.onLogout
  });

  @override 
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final authStorage = AuthStorage();

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      body: _buildSettingsScreen()
    );
  }

  Widget _buildSettingsScreen() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: appText(
              text: "Settings",
              fontSize: 26,
              fontWeight: FontWeight.bold
            )
          ),
          Divider(
            color: Color(0xffDDC6A7).withValues(alpha: 0.6),
            height: 20,
            thickness: 0.5
          ),
          settingsBox(
            title: "Server",
            items: [
              FutureBuilder(
                future: authStorage.getServer(),
                builder: (context, snapshot) {
                  return appText(
                    text: snapshot.data ?? "No server saved",
                  );
                }
              )
            ]
          ),
          Spacer(),
          redButton(
            text: "Log Out",
            onPressed: () async {
              final token = await authStorage.getToken();

              await JellyfinApi.instance.logout(token!);
              await authStorage.clearSession();
              JellyfinApi.dispose();
  
              widget.onLogout();
            }
          )
        ],
      )
    );
  }
}
