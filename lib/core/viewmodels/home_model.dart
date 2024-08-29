import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:expense_tracker/core/enums/viewstate.dart';
import 'package:expense_tracker/core/services/category_icon_service.dart';
import 'package:expense_tracker/core/services/database_service.dart'; // Updated import
import 'package:expense_tracker/core/viewmodels/base_model.dart';

import '../../locator.dart';

class HomeModel extends BaseModel {
  final DatabaseService _databaseService = // Updated service
      locator<DatabaseService>();

  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

  ScrollController scrollController =
      ScrollController(); // Set controller on scrolling
  bool show = true;

  bool get isCollapsed => _isCollapsed;
  bool _isCollapsed = false; // or any default value

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

  List<Map<String, dynamic>> transactions = []; // Updated to Map
  bool isCollapsing = false;
  String? appBarTitle; // Selected month
  String? selectedYear;
  int selectedMonthIndex = 0; // From month list above

  int expenseSum = 0;
  int incomeSum = 0;

  Future<void> monthClicked(String clickedMonth) async {
    selectedMonthIndex = months.indexOf(clickedMonth);
    appBarTitle = clickedMonth;
    transactions = await _databaseService.getAllTransactions(appBarTitle!);
    expenseSum = await _databaseService.getExpenseSum(appBarTitle!);
    incomeSum = await _databaseService.getIncomeSum(appBarTitle!);
    titleClicked();
  }

  void titleClicked() {
    isCollapsing = !isCollapsing;
    notifyListeners();
  }

  Color getColor(String month) {
    int monthIndex = months.indexOf(month);
    // Color the selected month
    if (monthIndex == selectedMonthIndex) {
      return Colors.orange;
    } else {
      return Colors.black;
    }
  }

  void closeMonthPicker() {
    isCollapsing = false;
    notifyListeners();
  }

  Future<void> init() async {
    handleScroll();

    selectedMonthIndex = DateTime.now().month - 1;
    appBarTitle = months[selectedMonthIndex];

    expenseSum = await _databaseService.getExpenseSum(appBarTitle!);
    incomeSum = await _databaseService.getIncomeSum(appBarTitle!);

    print("Expense : $expenseSum");
    print("Income : $incomeSum");
    // Show the loading bar
    setState(ViewState.busy);
    notifyListeners();

    transactions = await _databaseService.getAllTransactions(appBarTitle!);
    // Show the list
    setState(ViewState.idle);
    notifyListeners();
  }

  void handleScroll() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideFloatingButton();
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloatingButton();
      }
    });
  }

  void showFloatingButton() {
    show = true;
    notifyListeners();
  }

  void hideFloatingButton() {
    show = false;
    notifyListeners();
  }

  Icon getIconForCategory(int index, String type) {
    if (type == 'income') {
      final categoryIcon = _categoryIconService.incomeList.elementAt(index);

      return Icon(
        categoryIcon.icon,
        color: categoryIcon.color,
      );
    } else {
      final categoryIcon = _categoryIconService.expenseList.elementAt(index);

      return Icon(
        categoryIcon.icon,
        color: categoryIcon.color,
      );
    }
  }
}
