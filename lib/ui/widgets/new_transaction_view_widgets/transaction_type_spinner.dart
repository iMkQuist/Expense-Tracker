import 'package:flutter/material.dart';

class TransactionTypeSpinner extends StatelessWidget {
  final selectedItem;
  final Function changedSelectedItem;
  const TransactionTypeSpinner(this.selectedItem, this.changedSelectedItem);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedItem,
        items: const [
          DropdownMenuItem(
            value: 1,
            child: Text("Income"),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text("Expense"),
          ),
        ],
        onChanged: (value) {
          changedSelectedItem(value);
        });
  }
}
