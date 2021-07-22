import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionCallback;

  NewTransaction(this.addTransactionCallback);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void addTransactionPressed() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    widget.addTransactionCallback(
      title,
      amount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _handleShowDatepicker() {
    DateTime date = DateTime.now();

    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      firstDate: DateTime(date.year),
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: titleController,
                onSubmitted: (_) => addTransactionPressed(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                controller: amountController,
                onSubmitted: (_) => addTransactionPressed(),
              ),
              Row(children: [
                Expanded(
                  child: Text(_selectedDate != null
                      ? DateFormat('dd.MM.y').format(_selectedDate)
                      : 'No Date Cohosen'),
                ),
                TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueAccent),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(fontSize: 16),
                      )),
                  child: Text('Select date'),
                  onPressed: _handleShowDatepicker,
                )
              ]),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.fromLTRB(16, 4, 16, 4),
                  ),
                ),
                child: Text('Add Transaction'),
                onPressed: addTransactionPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}
