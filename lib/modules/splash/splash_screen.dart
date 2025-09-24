import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_assets.dart';
import 'package:news_app/core/routes/app_routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2),() {
      Navigator.pushReplacementNamed(context, RoutesName.home);
    },);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    return  Scaffold(
    body: Center(
      child: Column(
        children: [
          Spacer(),
          Image.asset(AppAssets.micSplash,color:theme.primaryColorLight ,),
          Spacer(),
          Image.asset(AppAssets.logoSplash,width: 200,color:theme.primaryColorLight )

        ],
      ),
    ),
    );
  }
}
