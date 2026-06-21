import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:jellywaves/home/home.dart';
import 'package:jellywaves/home/settings.dart';

class NavScreen extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: HomeScreen(),
          item: ItemConfig(
            icon: Icon(Icons.home),
            title: "Home",
            inactiveForegroundColor: Color(0xffDDC6A7),
            activeForegroundColor: Color(0xffB83A2E),
          )
        ),
        PersistentTabConfig(
          screen: SettingsScreen(),
          item: ItemConfig(
            icon: Icon(Icons.settings),
            title: "Settings",
            inactiveForegroundColor: Color(0xffDDC6A7),
            activeForegroundColor: Color(0xffB83A2E),
          )
        )
      ],
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: Color(0xff1A1A1A),
          border: BoxBorder.fromLTRB(
            top: BorderSide(
              color: Color(0xffDDC6A7).withValues(alpha: 0.6),
              width: 0.5
            )
          ),
        ),
        
      ),
    );
  }
}
