import 'package:flutter/foundation.dart';

class transaction {
  String id;
  String title;
  double amount;
  DateTime date;
  transaction({
    required this.amount,
    required this.date,
    required this.id,
    required this.title,
  });
}
