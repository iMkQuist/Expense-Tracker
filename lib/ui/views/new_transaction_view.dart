import 'package:flutter/material.dart';
import 'package:expense_tracker/core/viewmodels/new_transcation.dart';
import 'package:expense_tracker/ui/shared/ui_helpers.dart';
import 'package:expense_tracker/ui/views/base_view.dart';
import 'package:expense_tracker/ui/widgets/new_transaction_view_widgets/transaction_type_spinner.dart';

class NewTransactionView extends StatelessWidget {
  const NewTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<NewTransactionModel>(
      onModelReady: (model) async {
        // Perform any actions needed when the model is ready.
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: TransactionTypeSpinner(
              model.selectedCategory, model.changeSelectedItem),
        ),
        body: SafeArea(
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            children: model
                .loadCategoriesIcons()
                .map((e) => Card(
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("inserttransaction",
                            arguments: [e, model.selectedCategory]);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(e.name),
                            UIHelper.verticalSpaceSmall(),
                            CircleAvatar(
                              radius: 30,
                              child: Center(
                                child: Icon(
                                  e.icon,
                                  size: 25,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )))
                .toList(),
          ),
        ),
      ),
    );
  }
}
