import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../../home/view/home_page.dart';

import '../screens/notification_screen.dart';
import '../screens/settings_page.dart';
import '../screens/user_screen.dart';

class NavBottom extends StatefulWidget {
  @override
  _NavBottomState createState() => _NavBottomState();
   static Page<void> page() =>  MaterialPage<void>(child: NavBottom());
}

class _NavBottomState extends State<NavBottom> {
  final Color navigationBarColor = Color.fromARGB(255, 192, 238, 242);
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: navigationBarColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: <Widget>[
              Expanded(child: HomePage()),
              Expanded(
                child: NotificationPage(),
              ),
              Expanded(
                child: UserPage(),
              ),
              Expanded(child: SettingsPage()),
            ],
          ),
          bottomNavigationBar: SizedBox(
            child: WaterDropNavBar(
              backgroundColor: navigationBarColor,
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
        ));
  }
}
