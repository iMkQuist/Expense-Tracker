import 'package:expense_tracker/core/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/core/viewmodels/edit_model.dart';
import 'package:expense_tracker/ui/shared/app_colors.dart';
import 'package:expense_tracker/ui/shared/ui_helpers.dart';
import 'package:expense_tracker/ui/views/base_view.dart';

class EditView extends StatelessWidget {
  final Transaction transaction;
  EditView(this.transaction);

  @override
  Widget build(BuildContext context) {
    return BaseView<EditModel>(
      onModelReady: (model) => model.init(transaction as Map<String, dynamic>),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(model.category!.name),
                leading: CircleAvatar(
                    child: Icon(
                  model.category!.icon,
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
              const Divider(
                thickness: 2,
              ),
              Container(
                width: 20,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await model.selectDate(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue, // Set a background color if needed
                  ),
                  child: Text(model.getSelectedDate()),
                ),
              ),
              UIHelper.verticalSpaceLarge(),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () async {
                    await model.editTransaction(context, transaction.type,
                        transaction.categoryIndex, transaction.id);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: backgroundColor,
                  ),
                  child: const Text(
                    'EDIT',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
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
          color: Color(0xFFFF000000),
        ),
        helperText: helperText,
      ),
    );
  }
}
