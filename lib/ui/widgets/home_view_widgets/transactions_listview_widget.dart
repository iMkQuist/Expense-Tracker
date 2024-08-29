import 'package:expense_tracker/core/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/core/viewmodels/home_model.dart';

class TransactionsListView extends StatefulWidget {
  final List<Transaction> transactions;
  final HomeModel model;

  // Corrected to use named parameters for better clarity
  const TransactionsListView({
    super.key,
    required this.transactions,
    required this.model,
  });

  @override
  _TransactionsListViewState createState() => _TransactionsListViewState();
}

class _TransactionsListViewState extends State<TransactionsListView> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        controller: widget.model.scrollController,
        padding: const EdgeInsets.all(8),
        children: widget.transactions.map((transaction) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "details", arguments: transaction)
                    .then((value) => {
                          if (value != null)
                            {
                              if (value == '') {widget.model.init()}
                            }
                        });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${transaction.day}, ${transaction.month}',
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "${transaction.type}: ${transaction.amount}",
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue.withOpacity(.1),
                        child: widget.model.getIconForCategory(
                            transaction.categoryIndex, transaction.type),
                      ),
                      title: Text(transaction.memo),
                      trailing: transaction.type == 'expense'
                          ? Text('- ${transaction.amount}',
                              style: const TextStyle(fontSize: 20))
                          : Text(transaction.amount.toString(),
                              style: const TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
