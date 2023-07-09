import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:watterApp/app/screens/gaugetile.dart';



import '../screens/timegraph.dart';
import '../screens/settings_page.dart';
import '../screens/user_screen.dart';

class NavBottom extends StatefulWidget {
  @override
  _NavBottomState createState() => _NavBottomState();
  static Page<void> page() => MaterialPage<void>(child: NavBottom());
}

class _NavBottomState extends State<NavBottom> {

  int selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    /// [AnnotatedRegion<SystemUiOverlayStyle>] only for android black navigation bar. 3 button navigation control (legacy)

    return 
         Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: <Widget>[
              HomePage(),
              NotificationPage(),
              UserPage(),
              SettingsPage(),
            ],
          ),
          bottomNavigationBar: SizedBox(
            child: WaterDropNavBar(
               backgroundColor: Color.fromRGBO(37, 49, 109, 1.0),
              onItemSelected: (int index) {
                setState(() {
                  selectedIndex = index;
                });
                pageController.animateToPage(selectedIndex,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutQuad);
              },
              selectedIndex: selectedIndex,
              barItems: <BarItem>[
                BarItem(
                  filledIcon: Icons.bookmark_rounded,
                  outlinedIcon: Icons.bookmark_border_rounded,
                ),
                BarItem(
                    filledIcon: Icons.favorite_rounded,
                    outlinedIcon: Icons.favorite_border_rounded),
                BarItem(
                  filledIcon: Icons.email_rounded,
                  outlinedIcon: Icons.email_outlined,
                ),
                BarItem(
                  filledIcon: Icons.folder_rounded,
                  outlinedIcon: Icons.folder_outlined,
                ),
              ],
            ),
          ),
        );
  }
}
