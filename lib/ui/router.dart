import 'package:flutter/material.dart';
import 'package:expense_tracker/core/database/database_helper.dart';
import 'package:expense_tracker/ui/views/details_view.dart';
import 'package:expense_tracker/ui/views/edit_view.dart';
import 'package:expense_tracker/ui/views/home_view.dart';
import 'package:expense_tracker/ui/views/insert_transaction_view.dart';
import 'package:expense_tracker/ui/views/new_transaction_view.dart';
import 'package:expense_tracker/ui/views/piechart_view.dart';
import 'package:expense_tracker/ui/views/reminder_view.dart';
import 'package:expense_tracker/ui/views/splash_screen.dart';

const String initialRoute = "login";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomeView());
      case 'edit':
        var transaction = settings.arguments as Transaction;
        return MaterialPageRoute(builder: (_) => EditView(transaction));
      case 'chart':
        return MaterialPageRoute(
            builder: (_) => const PieChartView(
                  key: Key('piechart_view'),
                ));
      case 'newtransaction':
        return MaterialPageRoute(builder: (_) => const NewTransactionView());
      case 'inserttransaction':
        var args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                InsertTranscationView(args.elementAt(0), args.elementAt(1)));
      case 'details':
        var transaction = settings.arguments as Transaction;
        return MaterialPageRoute(builder: (_) => DetailsView(transaction));
      case 'reminder':
        return MaterialPageRoute(
            builder: (_) => const ReminderView(
                  key: Key('reminder_view'),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
