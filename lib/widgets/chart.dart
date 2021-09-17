import 'package:flutter/material.dart';
import 'package:flutter_practice_app/widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transaction;
  const Chart({Key? key, required this.transaction}) : super(key: key);

  List<Map<String, Object>> get singleChartColumnData {
    return List.generate(7, (index) {
      final day = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;
      for (var i = 0; i < transaction.length; i++) {
        if (transaction[i].date.day == day.day &&
            transaction[i].date.month == day.month &&
            transaction[i].date.year == day.year) {
          totalAmount += transaction[i].amount;
        }
      }

      return ({'day': DateFormat.E().format(day), 'total': totalAmount});
    }).reversed.toList();
  }

  double get weeklyTotal {
    double sum = singleChartColumnData.fold(0.0, (value, element) {
      return value + (element['total'] as double);
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: singleChartColumnData.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                totalAmount: (data['total'] as double),
                weeklyTotal: weeklyTotal,
                day: data['day'].toString(),
              ),
            );
          }).toList(),
        ),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 15),
    );
  }
}
