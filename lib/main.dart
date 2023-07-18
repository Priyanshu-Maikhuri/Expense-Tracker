import 'dart:io'; //for ios

import 'package:flutter/material.dart';

import './widgets/chart.dart';
import '../models_used/transactions.dart';
import './widgets/transaction_list_output.dart';
import './widgets/new_transaction.dart';

void main() {
  //not allwing landscape mode
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        hintColor: Colors.indigoAccent,
        errorColor: Colors.redAccent,
        fontFamily: 'Quicsand',
        //textTheme: TextStyle(),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Sono',
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _userTransactions = [];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  static int i = 0;
  void _addTransaction(String title, int price, DateTime chosenDate) {
    final tx = Transaction(
      item: title,
      amount: price,
      date: chosenDate,
      transactionId: 't' + i.toString(),
    );
    i++;
    setState(() {
      _userTransactions.add(tx);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(_addTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    String item =
        _userTransactions.firstWhere((tx) => id == tx.transactionId).item;
    setState(() {
      _userTransactions.removeWhere((tx) => tx.transactionId == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Transaction \'$item\' has been removed.'),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final mq =
        MediaQuery.of(context); //fore more efficiency and better performance
    final appBar = AppBar(
      title: Text("Money Manager"),
      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: Icon(Icons.menu),
      //     color: Colors.black,
      //   ),
      // ],
    );
    final mode = (mq.orientation == Orientation.landscape);
    final txlist = Container(
        height: (mq.size.height -
                mq.padding
                    .top - //Top statusbar (showing time and notifications)
                appBar.preferredSize.height) *
            0.7,
        child: TransactionListOutput(_userTransactions, _deleteTransaction));
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (mode)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Show Chart'),
                    Switch.adaptive(
                        value: _showChart,
                        onChanged: (val) {
                          //adaptive:- automatically to the running OS platform
                          setState(() {
                            _showChart = val;
                          });
                        }),
                  ],
                ),
              if (mode)
                _showChart
                    ? Container(
                        height: (mq.size.height -
                                mq.padding
                                    .top - //Top statusbar (showing time and notifications)
                                appBar.preferredSize.height) *
                            0.7,
                        child: Chart(_recentTransactions))
                    : txlist
              else
                Column(
                  children: [
                    Container(
                        height: (mq.size.height -
                                mq.padding
                                    .top - //Top statusbar (showing time and notifications)
                                appBar.preferredSize.height) *
                            0.3,
                        child: Chart(_recentTransactions)),
                    txlist,
                  ],
                ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_outlined),
          onPressed: () => _startNewTransaction(context),
          backgroundColor: Colors.amber,
        ),
      ),
    );
  }
}
