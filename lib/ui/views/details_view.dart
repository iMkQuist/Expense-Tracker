import 'package:expense_tracker/core/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/core/viewmodels/details_model.dart';
import 'package:expense_tracker/ui/shared/app_colors.dart';
import 'package:expense_tracker/ui/views/base_view.dart';
import 'package:expense_tracker/ui/widgets/details_view_widgets/details_card.dart';

class DetailsView extends StatelessWidget {
  final Transaction transaction;

  DetailsView(this.transaction);

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailsModel>(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushReplacementNamed('home');
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              child: const Icon(Icons.arrow_back),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('home');
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Details'),
                InkWell(
                  child: const Icon(Icons.delete),
                  onTap: () {
                    showDeleteDialog(context, model);
                  },
                ),
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 300,
                padding: const EdgeInsets.all(10.0),
                child: DetailsCard(
                  transaction: transaction,
                  model: model,
                ),
              ),
              Positioned(
                right: 18,
                top: 235,
                child: FloatingActionButton(
                  backgroundColor: backgroundColor,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('edit', arguments: transaction);
                  },
                  child: const Icon(Icons.edit, color: Colors.black38),
                ),
              )
            ],
          ),
        ),
      ),
      onModelReady: (model) {
        // This function is called when the model is ready.
        // Perform any actions you need with the model here.
// Example action
      },
    );
  }

  showDeleteDialog(BuildContext context, DetailsModel model) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete"),
          content:
              const Text("Are you sure you want to delete this transaction?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Delete"),
              onPressed: () async {
                await model
                    .deleteTransaction(transaction.id); // Updated method name
                // Hide dialog
                Navigator.of(context).pop();
                // Exit details screen
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
