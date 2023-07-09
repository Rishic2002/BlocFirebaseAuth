import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_manager.dart';
import '../bloc/app_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = true;
  }

  String? user;

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Welcome'),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
               
                ListTile(
                  title: Text(isDarkMode ? "Dark Mode" : "Light Mode"),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = !isDarkMode;
                      });
                      themeManager.toggleTheme();
                    },
                  ),
                ),
                const Text(
                  "User Settings",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SettingList(
                  settingsTitle: "Edit Profile",
                  onTap: () {},
                ),
                SettingList(settingsTitle: "Change Password", onTap: () {}),
                const SettingList(
                  settingsTitle: "Privacy",
                ),
                SettingList(
                    isSuffixIcon: false,
                    settingsTitle: "Log Out",
                    onTap: () {
                      context.read<AppBloc>().add(const AppLogoutRequested());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingList extends StatelessWidget {
  final dynamic iconasset;
  final String settingsTitle;
  final bool? isSuffixIcon;
  final Function()? onTap;
  final iconButton;

const SettingList({
  Key? key,
  this.iconasset,
  required this.settingsTitle,
  this.isSuffixIcon,
  this.onTap,
  this.iconButton
}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: InkWell(
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 10.5,
                        ),
                        Text(
                          settingsTitle,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              thickness: 1.5,
              color: Color(0xffC6C6C6),
            )
          ],
        ),
      ),
    );
  }
}
