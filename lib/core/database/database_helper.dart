import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Transaction {
  int id;
  String type;
  String day;
  String month;
  String memo;
  int amount;
  int categoryIndex;

  Transaction({
    required this.id,
    required this.type,
    required this.day,
    required this.month,
    required this.memo,
    required this.amount,
    required this.categoryIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'day': day,
      'month': month,
      'memo': memo,
      'amount': amount,
      'categoryindex': categoryIndex,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      type: map['type'],
      day: map['day'],
      month: map['month'],
      memo: map['memo'],
      amount: map['amount'],
      categoryIndex: map['categoryindex'],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static DatabaseHelper get instance => _instance;
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null, instantiate it
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get the directory for storing databases
    String path = join(await getDatabasesPath(), 'transactions.db');

    // Open the database, creating it if it doesn't exist
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        day TEXT NOT NULL,
        month TEXT NOT NULL,
        memo TEXT NOT NULL,
        amount INTEGER NOT NULL,
        categoryindex INTEGER NOT NULL
      )
      ''',
    );
  }

  Future<int> insertTransaction(Transaction transaction) async {
    final db = await database;
    return await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Transaction>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');

    return List.generate(maps.length, (i) {
      return Transaction.fromMap(maps[i]);
    });
  }

  Future<int> updateTransaction(Transaction transaction) async {
    final db = await database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> deleteTransaction(int id) async {
    final db = await database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Additional methods to be implemented based on your requirements
  getTransactionForMonth(String month) {}

  sumTheMoneyForMonth(String month, String s) {}

  getAllTransactionsForType(String month, String type) {}
}
