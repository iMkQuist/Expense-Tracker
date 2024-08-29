import 'package:expense_tracker/core/services/notification_service.dart';
import 'package:expense_tracker/core/services/sharedprefs_service.dart';
import 'package:expense_tracker/core/viewmodels/details_model.dart';
import 'package:expense_tracker/core/viewmodels/edit_model.dart';
import 'package:expense_tracker/core/viewmodels/insert_transaction_model.dart';
import 'package:expense_tracker/core/viewmodels/new_transcation.dart';
import 'package:expense_tracker/core/viewmodels/piechart_model.dart';
import 'package:expense_tracker/core/viewmodels/reminder_model.dart';
import 'package:get_it/get_it.dart';
import 'core/services/category_icon_service.dart';
import 'core/services/database_service.dart';
import 'core/viewmodels/home_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //!SERVICES
  locator.registerLazySingleton(() => CategoryIconService());
  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => SharedPrefrencesService());
  //!VIEWMODELS
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => DetailsModel());
  locator.registerFactory(() => EditModel());
  locator.registerFactory(() => NewTransactionModel());
  locator.registerFactory(() => InsertTransactionModel());
  locator.registerFactory(() => PieChartModel());
  locator.registerFactory(() => ReminderModel());
}
