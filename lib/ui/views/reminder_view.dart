import 'package:flutter/material.dart';
import 'package:expense_tracker/core/enums/viewstate.dart';
import 'package:expense_tracker/core/viewmodels/reminder_model.dart';
import 'package:expense_tracker/ui/views/base_view.dart';

class ReminderView extends StatelessWidget {
  const ReminderView({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ReminderModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: const Text('Reminder')),
        body: model.state == ViewState.busy
            ? const CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Daily Reminder'),
                    subtitle: Text(model.timeText),
                    trailing: InkWell(
                      child: const Icon(Icons.edit),
                      onTap: () {
                        model.pickTime(context);
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
