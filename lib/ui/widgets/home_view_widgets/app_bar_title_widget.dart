import 'package:flutter/material.dart';
import 'package:expense_tracker/core/viewmodels/home_model.dart';

class AppBarTitle extends StatelessWidget {
  final HomeModel model;
  final String title;
  const AppBarTitle(
      {required Key key, required this.model, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        model.titleClicked();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            model.isCollapsed
                ? const Icon(
                    Icons.arrow_drop_down,
                  )
                : const Icon(
                    Icons.arrow_drop_up,
                  ),
          ],
        ),
      ),
    );
  }
}
