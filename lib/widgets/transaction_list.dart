import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {Key? key, required this.transaction, required this.remove})
      : super(key: key);

  final List<Transaction> transaction;
  final Function remove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: ListTile(
                leading: CircleAvatar(
                  child: FittedBox(
                    child: Text('\$${transaction[index].amount}'),
                  ),
                  radius: 30,
                  backgroundColor: Theme.of(context).primaryColorDark,
                ),
                title: Text(
                  transaction[index].title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  DateFormat.yMMMEd().format(transaction[index].date),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    remove(transaction[index]);
                  },
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
          );
        },
        itemCount: transaction.length,
      ),
    );
  }
}
