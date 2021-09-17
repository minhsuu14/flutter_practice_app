import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double totalAmount;
  final double weeklyTotal;
  final String day;
  const ChartBar({
    Key? key,
    required this.totalAmount,
    required this.weeklyTotal,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text('\$${totalAmount.toStringAsFixed(0)}'),
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: totalAmount / weeklyTotal,
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
        const SizedBox(
          height: 4,
        ),
        Text(day.substring(0, 2)),
      ],
    );
  }
}
