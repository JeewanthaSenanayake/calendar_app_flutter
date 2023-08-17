import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';


Map<DateTime, List<Map>> data = Map<DateTime, List<Map>>();

void func(
    DateTime date, String title, String note, TimeOfDay start, TimeOfDay end) {
  Map<String, dynamic> dataInEvent = Map<String, dynamic>();

  dataInEvent.addAll({
    "title": title,
    "note": note,
    "start": start,
    "end": end,
  });

  if (data[date] != null) {
    data[date]!.add(dataInEvent);
  } else {
    data.addAll({
      date: [dataInEvent],
    });
  }
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
