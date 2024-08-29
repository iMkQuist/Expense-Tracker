import 'package:flutter/material.dart';
import 'package:expense_tracker/core/enums/viewstate.dart';
import 'package:expense_tracker/core/services/notification_service.dart';
import 'package:expense_tracker/core/services/sharedprefs_service.dart';
import 'package:expense_tracker/core/viewmodels/base_model.dart';

import '../../locator.dart';

// rreminder model
class ReminderModel extends BaseModel {
  final NotificationService _notificationService =
      locator<NotificationService>();

  final SharedPrefrencesService _sharedPrefrencesService =
      locator<SharedPrefrencesService>();

  late TimeOfDay selectedTime;

  String timeText = '';

  void scheduleNotifaction() {
    _notificationService.showNotificationDaily(
        1,
        'Money manager',
        'Don\'t forget to record your expenses!',
        selectedTime.hour,
        selectedTime.minute);
  }

  pickTime(context) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      selectedTime = time;
      scheduleNotifaction();

      storeTime(); // in shaerd prefs
      timeText = await getTime();

      notifyListeners();
    }
  }

  getTime() async {
    return await _sharedPrefrencesService.getTime();
  }

  storeTime() async {
    await _sharedPrefrencesService.storeTime(
        selectedTime.hour, selectedTime.minute);
  }

  init() async {
    setState(ViewState.busy);
    notifyListeners();
    timeText = await getTime();
    setState(ViewState.idle);
    notifyListeners();
  }
}
