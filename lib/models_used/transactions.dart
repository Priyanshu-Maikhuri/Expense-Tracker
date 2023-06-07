import 'package:flutter/foundation.dart';

class Transaction {
  final String transactionId;
  final String item;
  final int amount;
  final DateTime date;

  Transaction({
    required this.transactionId,
    required this.item,
    required this.amount,
    required this.date,
  });
}