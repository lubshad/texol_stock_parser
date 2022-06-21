import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';

import 'screens/category_details/category_details.dart';
import 'screens/navigation_screen/navigation_screen.dart';

class AppRoute {
  // Routes
  static const String initial = '/';
  static const String stockCategoryDetails = "/category_details";

  // onGenerateRoute
  static Route onGenerateRoute(RouteSettings settings) {
    final routeName = getRouteName(settings);
    final arguments = getArguments(settings);
    switch (routeName) {
      case initial:
        return MaterialPageRoute(
            builder: (context) => const NavigationScreen());
      case stockCategoryDetails:
        return MaterialPageRoute(
            builder: (context) =>  StockCategoryDetails(stockCategory: arguments,));
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(
                    child: Text('Route not found'),
                  ),
                ));
    }
  }

  static List<Route> onGenerateInitialRoute(String initialRoute) {
    return [
      MaterialPageRoute(
        builder: (context) => const NavigationScreen(),
      ),
    ];
  }
}


