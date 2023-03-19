// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserInput extends StatefulWidget {
  final Function newTransaction;
  UserInput(this.newTransaction);

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  TextEditingController titleCont = TextEditingController();
  TextEditingController amountCont = TextEditingController();
  DateTime pkdate = DateTime.now();
  bool isselected = false;

  void submitData() {
    final enteredTitle = titleCont.text;
    final enteredAmount = double.parse(amountCont.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || !isselected) {
      return;
    }
    print("title cont = " + titleCont.text);
    widget.newTransaction(
      enteredTitle,
      enteredAmount,
      pkdate,
    );
    Navigator.of(context).pop();
  }

  void Datepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      setState(() {
        pkdate = value;
        isselected = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleCont,
              onSubmitted: (value) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: amountCont,
              onSubmitted: (value) => submitData(),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(isselected == false
                      ? "No Date Chosen!"
                      : "Picked Date: ${DateFormat.yMd().format(pkdate)}"),
                ),
                TextButton(
                  onPressed: Datepicker,
                  child: Text("Choose Date"),
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text('Add Transaction'),
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
