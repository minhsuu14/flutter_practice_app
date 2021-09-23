import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

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
          return TransactionItem(
              transaction: transaction[index], remove: remove);
        },
        itemCount: transaction.length,
      ),
    );
  }
}
