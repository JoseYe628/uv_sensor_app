import 'package:flutter/material.dart';
import 'package:uv_sensor_app/features/iuv/presentation/screens/admin_screen.dart';
import 'package:uv_sensor_app/features/iuv/presentation/screens/home_screen.dart';



class AppRoutes {

  static const initialRoute = 'admin';

  static final routeItems = [
    // Aquí los screens
    RouteItem(routeName: "home", screen: HomeScreen()),
    RouteItem(routeName: "admin", screen: AdminScreen()),
  ];

  static Map<String, Widget Function(BuildContext)> generateRoutes() {
    Map<String, Widget Function(BuildContext)> routes = {};
    for(final routeItem in routeItems){
      routes.addAll({
        routeItem.routeName: (_) => routeItem.screen,
      });
    }
    return routes;
  }
}


class RouteItem {
  String routeName;
  Widget screen;
  RouteItem({
    required this.routeName,
    required this.screen,
  });
}
