import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount;
  final double height;
  const ChartBar(this.day, this.amount, this.height);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, Constraints) {
      return Container(
        child: Column(
          children: [
            Container(
              height: Constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  "\$${amount.toStringAsFixed(0)}",
                ),
              ),
            ),
            SizedBox(
              height: Constraints.maxHeight * 0.05,
            ),
            Container(
              height: Constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 5,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: height,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: Constraints.maxHeight * 0.05,
            ),
            Container(
              height: Constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(day),
              ),
            ),
          ],
        ),
      );
    });
  }
}
