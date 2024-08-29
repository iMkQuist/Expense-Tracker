import 'package:expense_tracker/core/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/core/viewmodels/details_model.dart';
import 'package:expense_tracker/ui/shared/ui_helpers.dart';
import 'package:expense_tracker/ui/widgets/details_view_widgets/details_table.dart';

class DetailsCard extends StatelessWidget {
  final Transaction transaction;
  final DetailsModel model;
  const DetailsCard(
      {super.key, required this.transaction, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blueAccent.withOpacity(.1),
                  child: model.getIconForCategory(
                      transaction.categoryIndex, transaction.type)),
              title: Text(
                "\t\t\t${model.getCategoryIconName(transaction.categoryIndex, transaction.type)}",
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            UIHelper.verticalSpaceSmall(),
            DetailsTable(
              transaction: transaction,
              key: const Key('transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
