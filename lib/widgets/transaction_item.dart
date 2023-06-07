import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models_used/transactions.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.deleteTansaction,
  });

  final Transaction transaction;
  final Function deleteTansaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? bg_color;

  @override
  void initState() {
    const availableColors = [
      Colors.black,
      Colors.indigo,
      Colors.deepPurple,
      Colors.deepOrange
    ];

    bg_color = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: bg_color,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: FittedBox(
              child: Text(
                '₹${widget.transaction.amount}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.item,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(DateFormat('dd/MM/yyyy').format(
          widget.transaction.date,
        )),
        trailing: MediaQuery.of(context).size.width > 500
            ? TextButton.icon(
                icon: Icon(Icons.delete),
                label: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
                onPressed: () =>
                    widget.deleteTansaction(widget.transaction.transactionId),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    widget.deleteTansaction(widget.transaction.transactionId),
              ),
      ),
    );
  }
}
