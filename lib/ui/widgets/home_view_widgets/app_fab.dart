import 'package:flutter/material.dart';

import 'package:expense_tracker/ui/shared/app_colors.dart';

class AppFAB extends StatelessWidget {
  final Function closeMonthPicker;

  const AppFAB(this.closeMonthPicker, {required void Function() onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        closeMonthPicker();
        Navigator.of(context).pushNamed("newtransaction");
      },
      backgroundColor: backgroundColor,
      child: const Icon(Icons.add, color: Colors.black38),
    );
  }
}
