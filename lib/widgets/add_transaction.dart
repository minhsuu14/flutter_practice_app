import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function addNewTransaction;
  const AddTransaction({Key? key, required this.addNewTransaction})
      : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _check = false;

  void _submitData() {
    final String enteredTitle = _titleController.text;
    final double enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _check == false) {
      return;
    }

    widget.addNewTransaction(enteredTitle, enteredAmount, _selectedDate);
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return _check;
      }
      _check = true;
      setState(() => _selectedDate = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
              controller: _amountController,
              onSubmitted: (_) => _submitData(),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _check == false
                        ? 'No date chosen'
                        : 'Picked date: ${DateFormat.yMEd().format(_selectedDate)}',
                  ),
                ),
                TextButton(
                  child: const Text('Pick a date'),
                  onPressed: _datePicker,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: _submitData,
              child: const Text('Add new transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
