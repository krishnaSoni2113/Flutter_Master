import 'MasterConstant.dart';
import 'package:flutter/cupertino.dart';

class MIPicker {
  static final MIPicker shared = new MIPicker._init();

  factory MIPicker() {
    return shared;
  }

  MIPicker._init();

  Future<DateTime> datePicker(String dateFormat, BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: new DateTime(DateTime.now().year - 5),
      lastDate: DateTime(2101),
    );

    return pickedDate;
  }

  Future<TimeOfDay> timePicker(BuildContext context) async {
    final TimeOfDay pickedTime =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    return pickedTime;
  }
  

  
}
