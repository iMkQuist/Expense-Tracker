import 'package:flutter/material.dart';
import 'package:expense_tracker/core/models/category.dart';
import 'package:expense_tracker/core/viewmodels/insert_transaction_model.dart';
import 'package:expense_tracker/ui/shared/app_colors.dart';
import 'package:expense_tracker/ui/shared/ui_helpers.dart';
import 'package:expense_tracker/ui/views/base_view.dart';

class InsertTranscationView extends StatelessWidget {
  final Category category;
  final int selectedCategory;
  const InsertTranscationView(this.category, this.selectedCategory,
      {super.key});
  @override
  Widget build(BuildContext context) {
    return BaseView<InsertTransactionModel>(
      onModelReady: (model) => model.init(selectedCategory, category.index),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: selectedCategory == 1
              ? const Text('Income')
              : const Text('Expense'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(category.name),
                  leading: CircleAvatar(
                      child: Icon(
                    category.icon,
                    size: 20,
                  )),
                ),
                UIHelper.verticalSpaceMedium(),
                buildTextField(model.memoController, 'Memo:',
                    "Enter a memo for your transaction", Icons.edit, false),
                UIHelper.verticalSpaceMedium(),
                buildTextField(
                    model.amountController,
                    'Amount:',
                    "Enter a the amount for the transaction",
                    Icons.attach_money,
                    true),
                UIHelper.verticalSpaceMedium(),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'SELECT DATE:',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                SizedBox(
                  width: 20,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await model.selectDate(context);
                    },
                    child: Text(model.getSelectedDate()),
                  ),
                ),
                UIHelper.verticalSpaceLarge(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () async {
                      await model.addTransaction(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: backgroundColor, // Text color
                    ),
                    child: const Text(
                      'ADD',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTextField(TextEditingController controller, String text,
      String helperText, IconData icon, isNumeric) {
    return TextFormField(
      cursorColor: Colors.black,
      maxLength: isNumeric ? 10 : 40,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: text,
        suffixIcon: InkWell(
          onTap: () {
            controller.clear();
          },
          child: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        helperText: helperText,
      ),
    );
  }
}
