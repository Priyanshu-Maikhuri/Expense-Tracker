//To create a new transaction

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function handler;

  NewTransaction(this.handler);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _itemInput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime? _selectedDate = null;

  void _displayDatePicker() {
    showDatePicker(context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null)
        return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitData(){
    if(_amountInput.text.isEmpty)  {return;}
    final enteredTitle = _itemInput.text;
    final enteredAmount = int.parse(_amountInput.text);

    if(enteredAmount<=0 || enteredTitle.isEmpty || _selectedDate == null)
      {return;}
    
    widget.handler(
      enteredTitle, 
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(decoration: InputDecoration(labelText: 'Item Title'),
                controller: _itemInput,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => _submitData, //_ means it takes an argument which we don't care
              ),
              TextField(decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountInput,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData,
              ),
              Container(
                height: 80,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null ? 'No Date Chosen!\t'
                        : 'Picked Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}'
                      ),
                    ),
                    TextButton(onPressed: _displayDatePicker, 
                      child: const Text('Choose Date', 
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: _submitData,
                  child: const Text('Add',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}