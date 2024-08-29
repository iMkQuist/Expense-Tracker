import 'package:flutter/material.dart';
import 'package:expense_tracker/core/services/category_icon_service.dart';
import 'package:expense_tracker/core/services/database_service.dart';
import 'package:expense_tracker/core/viewmodels/base_model.dart';

import '../../locator.dart';

class DetailsModel extends BaseModel {
  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

  final DatabaseService _databaseService = // Updated service
      locator<DatabaseService>();

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

  String getCategoryIconName(int index, String type) {
    if (type == 'income') {
      return _categoryIconService.incomeList.elementAt(index).name;
    } else {
      return _categoryIconService.expenseList.elementAt(index).name;
    }
  }

  Future<int> deleteTransaction(int id) async {
    return await _databaseService.deleteTransaction(id);
  }
}
