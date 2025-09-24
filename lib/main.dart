import 'package:flutter/material.dart';
import 'package:news_app/core/manager/app_provider.dart';
import 'package:news_app/core/routes/app_routes.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final appProvider = AppProvider();
  await appProvider.getTheme();
  runApp(ChangeNotifierProvider(create:(context) => appProvider,child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        var appProvider=Provider.of<AppProvider>(context);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appProvider.themeMode,
      );
  }
}
