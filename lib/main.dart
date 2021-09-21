import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice_app/widgets/chart.dart';
import 'package:flutter/services.dart';

import './models/transaction.dart';
import './widgets/add_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Manager',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        fontFamily: 'Glory',
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleTextStyle: TextStyle(
            fontFamily: 'Glory',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  void _addNewTransaction(String title, double amount, DateTime date) {
    final tx = Transaction(
      id: DateTime.now().toString(),
      amount: amount,
      title: title,
      date: date,
    );
    setState(() {
      _userTransactions.add(tx);
    });
  }

  void _removeTransaction(Transaction tx) {
    setState(() {
      _userTransactions.remove(tx);
    });
  }

  void _popUpAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddTransaction(
            addNewTransaction: _addNewTransaction,
          );
        });
  }

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Expenses manager'),
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[
        IconButton(
          onPressed: () => _popUpAddTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show chart'),
                Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() => _showChart = val);
                    }),
              ],
            ),
          _userTransactions.isEmpty
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          'No transaction added yet !',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 200,
                        child: Image.asset(
                          'assets/images/clipart109487.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  child: isLandscape
                      ? Column(
                          children: [
                            if (_showChart)
                              Container(
                                  height: (MediaQuery.of(context).size.height -
                                          appBar.preferredSize.height -
                                          MediaQuery.of(context).padding.top) *
                                      0.7,
                                  child:
                                      Chart(transaction: _recentTransaction)),
                            if (!_showChart)
                              Container(
                                height: (MediaQuery.of(context).size.height -
                                        appBar.preferredSize.height -
                                        MediaQuery.of(context).padding.top) *
                                    0.7,
                                child: TransactionList(
                                  transaction: _userTransactions,
                                  remove: _removeTransaction,
                                ),
                              ),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                                height: (MediaQuery.of(context).size.height -
                                        appBar.preferredSize.height -
                                        MediaQuery.of(context).padding.top) *
                                    0.3,
                                child: Chart(transaction: _recentTransaction)),
                            Container(
                              height: (MediaQuery.of(context).size.height -
                                      appBar.preferredSize.height -
                                      MediaQuery.of(context).padding.top) *
                                  0.7,
                              child: TransactionList(
                                transaction: _userTransactions,
                                remove: _removeTransaction,
                              ),
                            ),
                          ],
                        ),
                ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _popUpAddTransaction(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
