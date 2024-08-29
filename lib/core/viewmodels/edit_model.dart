import 'package:flutter/material.dart';
import 'package:expense_tracker/core/models/category.dart';
import 'package:expense_tracker/core/services/category_icon_service.dart';
import 'package:expense_tracker/core/services/database_service.dart'; // Updated import
import 'package:expense_tracker/core/viewmodels/base_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../locator.dart';

class EditModel extends BaseModel {
  TextEditingController memoController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final DatabaseService _databaseService = // Updated service
      locator<DatabaseService>();

  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

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

  String? selectedDay;
  String? selectedMonth;
  DateTime selectedDate = DateTime.now();
  Category? category;

  Future<void> selectDate(BuildContext context) async {
    // Hide the keyboard
    unFocusFromTheTextField(context);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedMonth = months[picked.month - 1];
      selectedDay = picked.day.toString();
      selectedDate = picked;

      notifyListeners();
    }
  }

  void unFocusFromTheTextField(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  String getSelectedDate() {
    if (int.parse(selectedDay ?? '0') == DateTime.now().day &&
        DateTime.now().month == months.indexOf(selectedMonth ?? '') + 1) {
      return 'Today ${selectedMonth ?? ''}, ${selectedDay ?? ''}';
    } else {
      return '${selectedMonth ?? ''}, ${selectedDay ?? ''}';
    }
  }

  void init(Map<String, dynamic> transaction) {
    // Initial values are current day and month
    selectedMonth = transaction['month'];
    selectedDay = transaction['day'];
    if (transaction['type'] == 'income') {
      category = _categoryIconService.incomeList
          .elementAt(transaction['categoryindex']);
    } else {
      category = _categoryIconService.expenseList
          .elementAt(transaction['categoryindex']);
    }
    memoController.text = transaction['memo'];
    amountController.text = transaction['amount'].toString();
    notifyListeners();
  }

  Future<void> editTransaction(
      BuildContext context, String type, int categoryIndex, int id) async {
    String memo = memoController.text;
    String amount = amountController.text;

    if (memo.isEmpty || amount.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill all the fields!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    // Create updated transaction as a map
    Map<String, dynamic> updatedTransaction = {
      'type': type,
      'day': selectedDay,
      'id': id,
      'month': selectedMonth,
      'memo': memo,
      'amount': int.parse(amount),
      'categoryindex': categoryIndex,
    };

    // Update the transaction
    await _databaseService.updateTransaction(updatedTransaction);

    Fluttertoast.showToast(
      msg: "Edited successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );

    // Return to the home
    Navigator.of(context).pushNamedAndRemoveUntil(
      'details',
      (Route<dynamic> route) => false,
      arguments: updatedTransaction,
    );
  }
}
