import 'package:flutter/material.dart';
import 'package:news_app/core/routes/app_routes_name.dart';
import 'package:news_app/modules/home/pages/home_screen.dart';
import 'package:news_app/modules/splash/splash_screen.dart';

import '../../modules/news/news_screen.dart';

class AppRoutes{
  static Map<String, Widget Function(BuildContext)> routes={
RoutesName.splash:(_)=>SplashScreen(),
RoutesName.home:(_)=>HomeScreen(),
RoutesName.news:(_)=>NewsScreen(),
};
}