import 'package:expense_tracker/core/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/core/services/database_service.dart';
import 'package:expense_tracker/core/viewmodels/base_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../locator.dart';

class InsertTransactionModel extends BaseModel {
  TextEditingController memoController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final DatabaseService _databaseService = // Updated service
      locator<DatabaseService>();

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

  String selectedDay = '';
  String selectedMonth = '';
  DateTime selectedDate = DateTime.now();
  String type = '';
  int categoryIndex = 0;

  Future<void> selectDate(BuildContext context) async {
    // Hide the keyboard
    unFocusFromTheTextField(context);

    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());

    if (picked != null) {
      selectedMonth = months[picked.month - 1];
      selectedDay = picked.day.toString();
      selectedDate = picked;

      notifyListeners();
    }
  }

  void init(int selectedCategory, int index) {
    // Initial values are current day and month
    selectedMonth = months[DateTime.now().month - 1];
    selectedDay = DateTime.now().day.toString();
    type = (selectedCategory == 1) ? 'income' : 'expense';
    categoryIndex = index;
  }

  void unFocusFromTheTextField(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  String getSelectedDate() {
    if (int.parse(selectedDay) == DateTime.now().day &&
        DateTime.now().month == months.indexOf(selectedMonth) + 1) {
      return 'Today $selectedMonth, $selectedDay';
    } else {
      return '$selectedMonth, $selectedDay';
    }
  }

  Future<void> addTransaction(BuildContext context) async {
    String memo = memoController.text;
    String amount = amountController.text;

    if (memo.isEmpty || amount.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill all the fields!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
      return;
    }

    Transaction newTransaction = Transaction(
      id: 0, // Placeholder value, adjust as needed
      type: type,
      day: selectedDay,
      month: selectedMonth,
      memo: memo,
      amount: int.parse(amount),
      categoryIndex: categoryIndex,
    );

    // Insert it
    await _databaseService
        .insertTransaction(newTransaction as Map<String, dynamic>);

    Fluttertoast.showToast(
        msg: "Added successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);

    // Return to the home
    Navigator.of(context)
        .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
  }
}
