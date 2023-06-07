import 'package:flutter/material.dart';

import './chart_bar.dart';
import 'package:intl/intl.dart';
import '../models_used/transactions.dart';


class Chart extends StatelessWidget {
  final List<Transaction> rectentTransactions;

  Chart(this.rectentTransactions);

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as int);
    });
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      int totalSum=0;
      for(var i = 0; i < rectentTransactions.length; i++){
        if(rectentTransactions[i].date.day == weekday.day &&
           rectentTransactions[i].date.month == weekday.month &&
           rectentTransactions[i].date.year == weekday.year){
            totalSum += rectentTransactions[i].amount;
           }
      }
      print(DateFormat.E().format(weekday));
      print(totalSum);
      return {'day': DateFormat.E().format(weekday), 'amount': totalSum};
    }).reversed.toList();
  } 

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.only(left: 5, right: 5, top: 20, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((data) {
            return ChartBar(data['day'] as String, 
              data['amount'] as int, 
              data['amount'] == 0 ? 0.0 : (data['amount'] as int)/totalSpending);
          }).toList(),
        )
      ),
    );
  }
}