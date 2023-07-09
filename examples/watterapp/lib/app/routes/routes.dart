import 'package:flutter/widgets.dart';
import 'package:watterApp/app/app.dart';
import 'package:watterApp/app/routes/page.dart';

import 'package:watterApp/login/login.dart';
import 'package:watterApp/onboarding/onboarding_screen.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [NavBottom.page()];
    case AppStatus.unauthenticated:
      return [OnboardingScreen.page()];
  }
}
