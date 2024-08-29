import 'package:flutter/material.dart';
import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/ui/router.dart' as app_router;
import 'package:expense_tracker/ui/shared/app_colors.dart';
import 'package:expense_tracker/ui/views/home_view.dart';
import 'package:expense_tracker/ui/views/splash_screen.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: backgroundColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
      ),
      initialRoute: '/splash',
      onGenerateRoute: app_router.Router.generateRoute,
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const HomeView(),
      },
    );
  }
}
