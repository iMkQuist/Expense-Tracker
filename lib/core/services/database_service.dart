import 'package:expense_tracker/core/database/database_helper.dart';

class DatabaseService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Map<String, dynamic>>> getAllTransactions(String month) async {
    List<Map<String, dynamic>> allTrans =
        await _databaseHelper.getTransactionForMonth(month);
    return allTrans;
  }

  Future<int> getIncomeSum(String month) async {
    int? sumOfIncome =
        await _databaseHelper.sumTheMoneyForMonth(month, "income");
    return sumOfIncome ?? 0;
  }

  Future<int> getExpenseSum(String month) async {
    int? sumOfExpense =
        await _databaseHelper.sumTheMoneyForMonth(month, "expense");
    return sumOfExpense ?? 0;
  }

  Future<int> deleteTransaction(int id) async {
    return await _databaseHelper.deleteTransaction(id);
  }

  Future<int> insertTransaction(Map<String, dynamic> transaction) async {
    return await _databaseHelper.insertTransaction(transaction as Transaction);
  }

  Future<int> updateTransaction(Map<String, dynamic> transaction) async {
    return await _databaseHelper.updateTransaction(transaction as Transaction);
  }

  Future<List<Map<String, dynamic>>> getAllTransactionsForType(
      String month, String type) async {
    return await _databaseHelper.getAllTransactionsForType(month, type);
  }
}
