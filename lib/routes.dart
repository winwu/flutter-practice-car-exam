import 'package:flutter/widgets.dart';
import 'package:car_license_exams/screens/home/home_screen.dart';
import 'package:car_license_exams/screens/overview/overview_screen.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder> {
  '/': (BuildContext context) => MyAppHomeScreen(),
  '/overview': (BuildContext context) => OverviewScreen()
};