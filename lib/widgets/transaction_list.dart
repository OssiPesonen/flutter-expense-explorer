import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transcation.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactionCallback;

  TransactionList(this.transactions, this.deleteTransactionCallback);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Container(
                    child: Text('No transactions yet'),
                    margin: EdgeInsets.all(16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                    height: 100,
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.fromLTRB(4, 8, 4, 8),
                  child: ListTile(
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    subtitle: Text(
                      DateFormat('dd.MM.y').format(transactions[index].date),
                      style: TextStyle(
                        color: Color.fromRGBO(100, 100, 100, 1),
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: FittedBox(
                          child: Text(
                            transactions[index]
                                    .amount
                                    .toStringAsFixed(2)
                                    .replaceAll('.', ',') +
                                " €",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromRGBO(150, 150, 150, 1),
                      ),
                      tooltip: 'Delete transaction',
                      onPressed: () {
                        deleteTransactionCallback(transactions[index].id);
                      },
                    ),
                  ),
                );
              },
              itemCount: transactions.length),
    );
  }
}
