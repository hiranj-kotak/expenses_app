import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './models/transaction.dart';

import './widgets/user_input.dart';
import './widgets/transactions_list.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<transaction> transactions = [
    // transaction(
    //   amount: 100,
    //   date: DateTime.now(),
    //   id: "t1",
    //   title: "hns",
    // ),
    // transaction(
    //   amount: 500,
    //   date: DateTime.now(),
    //   id: "t2",
    //   title: "anand",
    // ),
  ];

  void newTransaction(String txTitle, double txAmount, DateTime pkdate) {
    final obj = transaction(
      amount: txAmount,
      date: pkdate,
      id: DateTime.now().toString(),
      title: txTitle,
    );
    setState(() {
      transactions.add(obj);
    });
  }

  List<transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransactions(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: ModalBottomSheetDemo(newTransaction, transactions,
          _recentTransactions, _deleteTransactions),
    );
  }
}

class ModalBottomSheetDemo extends StatelessWidget {
  final Function newTransaction;
  final List<transaction> transactions;
  final List<transaction> _recentTransactions;
  final Function _deleteTransactions;
  ModalBottomSheetDemo(this.newTransaction, this.transactions,
      this._recentTransactions, this._deleteTransactions);

  addNewTransactionPage(context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return UserInput(newTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text("Personal Expenses"),
      actions: [
        IconButton(
            onPressed: (() => addNewTransactionPage(context)),
            icon: Icon(Icons.add)),
      ],
    );
    return Scaffold(
      appBar: appbar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (() => addNewTransactionPage(context)),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: (MediaQuery.of(context).size.height -
                    appbar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.25,
            child: Chart(_recentTransactions),
          ),
          Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.75,
              child: TransactionsList(transactions, _deleteTransactions)),
        ]),
      ),
    );
  }
}
