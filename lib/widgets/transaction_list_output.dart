import 'package:flutter/material.dart';

import '../models_used/transactions.dart';
import './transaction_item.dart';

class TransactionListOutput extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTansaction;
  TransactionListOutput(this.transactions, this.deleteTansaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                SizedBox(height: 15),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                    key: ValueKey(tx.transactionId),
                    transaction: tx, 
                    deleteTansaction: deleteTansaction
                  ))
                .toList(),
          );
  }
}
