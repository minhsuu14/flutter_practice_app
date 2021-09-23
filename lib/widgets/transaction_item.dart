import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.remove,
  }) : super(key: key);

  final Transaction transaction;
  final Function remove;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              child: Text('\$${transaction.amount}'),
            ),
            radius: 30,
            backgroundColor: Theme.of(context).primaryColorDark,
          ),
          title: Text(
            transaction.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            DateFormat.yMMMEd().format(transaction.date),
          ),
          trailing: MediaQuery.of(context).size.width > 450
              ? TextButton.icon(
                  onPressed: () {
                    remove(transaction);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  label: Text(
                    'Delete',
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    remove(transaction);
                  },
                  color: Theme.of(context).errorColor,
                ),
        ),
      ),
    );
  }
}
