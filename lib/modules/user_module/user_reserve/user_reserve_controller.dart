import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserReserveController extends GetxController {
  DateTime? _selectedDate = DateTime.now();
  DateTime? get selectedDate => _selectedDate;
  String? _formattedDate;
  String? get formattedDate => _formattedDate;

  TimeOfDay? _selectedHour = TimeOfDay.now();
  TimeOfDay? get selectedHour => _selectedHour;

  @override
  void onInit() {
    _formattedDate = DateFormat.yMMMMd().format(_selectedDate!);
    super.onInit();
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate!,
        firstDate: DateTime(2019, 1),
        lastDate: DateTime(2111));
    if (picked != null) {
      _selectedDate = picked;
      _formattedDate = DateFormat.yMMMMd().format(_selectedDate!);
      update();
    }
  }

  selectHour(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedHour!,
    );
    if (picked != null) {
      _selectedHour = picked;
      update();
    }
  }
}
