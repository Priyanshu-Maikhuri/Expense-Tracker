import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label; //weekday
  final int amountSpent;
  final double pct;

  ChartBar(this.label, this.amountSpent, this.pct);

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints){
        return Column(children: <Widget>[
          Container(
            height: constraints.maxHeight*0.15, 
            child: FittedBox(child: Text('₹${amountSpent}'))
          ),
          SizedBox(height: constraints.maxHeight*0.05,),
          Container(
            height: constraints.maxHeight*0.6,
            width: 20,
            child: Stack(
              children: [
                Container(
                  //margin: EdgeInsets.symmetric(horizontal: 5,),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0,),
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                ),
                FractionallySizedBox(heightFactor: pct, 
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight*0.05,),
          Expanded(
            child: Container(
              height: 20,//constraints.maxHeight*0.15,
              child: FittedBox(child: Text(label))
            ),
          ),
        ],);
      }
    );
  }
}