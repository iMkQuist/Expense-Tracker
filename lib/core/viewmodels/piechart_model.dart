// ignore_for_file: avoid_print

import 'package:expense_tracker/core/database/database_helper.dart';
import 'package:expense_tracker/core/enums/viewstate.dart';
import 'package:expense_tracker/core/services/category_icon_service.dart';
import 'package:expense_tracker/core/viewmodels/base_model.dart';
import 'package:expense_tracker/core/services/database_service.dart';
import '../../locator.dart';

class PieChartModel extends BaseModel {
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  final DatabaseService _databaseService = // Updated service
      locator<DatabaseService>();

  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

  List<Transaction> transactions = [];

  int selectedMonthIndex = 0;

  Map<String, double> dataMap = {};

  String type = 'expense';

  List<String> types = ["Income", "Expense"];

  Future<void> init(bool firstTime) async {
    if (firstTime) selectedMonthIndex = DateTime.now().month - 1;

    setState(ViewState.busy);
    notifyListeners();

    transactions = (await _databaseService.getAllTransactionsForType(
            months.elementAt(selectedMonthIndex), type))
        .cast<Transaction>();

    dataMap = getDefaultDataMap(transactions);

    for (var element in transactions) {
      prepareDataMap(element);
    }

    print(dataMap.toString());

    setState(ViewState.idle);
    notifyListeners();
  }

  Future<void> changeSelectedMonth(int val) async {
    selectedMonthIndex = val;

    transactions = (await _databaseService.getAllTransactionsForType(
            months.elementAt(selectedMonthIndex), type))
        .cast<Transaction>();

    // Clear old data
    dataMap = getDefaultDataMap(transactions);

    for (var element in transactions) {
      prepareDataMap(element);
    }

    notifyListeners();
  }

  Map<String, double> getDefaultDataMap(List<Transaction> transactions) {
    Map<String, double> fullExpensesMap = {
      'Food': 0,
      'Bills': 0,
      'Transportation': 0, // Fixed typo
      'Home': 0,
      'Entertainment': 0,
      'Shopping': 0,
      'Clothing': 0,
      'Insurance': 0,
      'Telephone': 0,
      'Health': 0,
      'Sport': 0,
      'Beauty': 0,
      'Education': 0,
      'Gift': 0,
      'Pet': 0,
      'Salary': 0,
      'Awards': 0,
      'Grants': 0,
      'Rental': 0,
      'Investment': 0,
      'Lottery': 0,
    };

    Map<String, double> fullIncomeMap = {
      'Salary': 0,
      'Awards': 0,
      'Grants': 0,
      'Rental': 0,
      'Investment': 0,
      'Lottery': 0,
    };

    List<String> transactionsCategories = [];

    for (var element in transactions) {
      String category;
      if (type == 'income') {
        category = _categoryIconService.incomeList
            .elementAt(element.categoryIndex)
            .name;
      } else {
        category = _categoryIconService.expenseList
            .elementAt(element.categoryIndex)
            .name;
      }
      transactionsCategories.add(category);
    }

    if (type == 'income') {
      fullIncomeMap.removeWhere((key, value) {
        return !transactionsCategories.contains(key);
      });
      return fullIncomeMap;
    }

    fullExpensesMap.removeWhere((key, value) {
      return !transactionsCategories.contains(key);
    });

    return fullExpensesMap;
  }

  Future<void> changeType(int val) async {
    // 0 => income
    // 1 => expense
    type = (val == 0) ? 'income' : 'expense';
    await init(false);
  }

  void prepareDataMap(Transaction element) {
    String categoryName;
    if (type == 'income') {
      categoryName =
          _categoryIconService.incomeList.elementAt(element.categoryIndex).name;
    } else {
      categoryName = _categoryIconService.expenseList
          .elementAt(element.categoryIndex)
          .name;
    }
    dataMap[categoryName] =
        (dataMap[categoryName] ?? 0.0) + element.amount.toDouble();
  }
}
