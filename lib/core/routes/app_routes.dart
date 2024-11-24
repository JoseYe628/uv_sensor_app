import 'package:flutter/material.dart';
import 'package:uv_sensor_app/features/education/presentation/screens/skin_measures_sreen.dart';
import 'package:uv_sensor_app/features/education/presentation/screens/skin_phototype_info_screen.dart';
import 'package:uv_sensor_app/features/education/presentation/screens/skin_phototype_screen.dart';
import 'package:uv_sensor_app/features/iuv/presentation/screens/admin_screen.dart';
import 'package:uv_sensor_app/features/iuv/presentation/screens/home_screen.dart';



class AppRoutes {

  static const initialRoute = 'admin';

  static final routeItems = [
    // Aquí los screens
    RouteItem(routeName: "home", screen: HomeScreen()),
    RouteItem(routeName: "admin", screen: AdminScreen()),
    RouteItem(routeName: "phototype", screen: SkinPhototypeScreen()),
    RouteItem(routeName: "pinfo", screen: SkinPhototypeInfoScreen()),
    RouteItem(routeName: "pmeasures", screen: SkinMeasuresSreen()),
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
