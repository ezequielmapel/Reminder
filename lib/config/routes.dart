import 'package:flutter/cupertino.dart';
import 'package:reminder/views/reminderPage.dart';
import 'package:reminder/views/splashScreenPage.dart';

Map<String, WidgetBuilder> routes(BuildContext context) {
  return {
    '/splash': (context) => SplashScreenPage(
          title: 'Reminder',
        ),
    '/home': (context) => ReminderViewPage(),
    '/': (context) => ReminderViewPage(),
  };
}
