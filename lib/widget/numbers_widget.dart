import 'package:flutter/material.dart';
import 'package:stress_detection_app/models/user.dart';
import 'package:intl/intl.dart';

class NumbersWidget extends StatelessWidget {
  NumbersWidget(this.user);
  final Info user;
  final date2 = DateTime.now();
  String formatDate(DateTime date) =>  (date2.year-date.year).toString();

  String findBMI(double height, double weight) => (weight*100*100 / (height * height)).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, formatDate(user.dob), 'Age'),
          buildDivider(),
          buildButton(context, user.weight.toString(), 'Weight'),
          buildDivider(),
          buildButton(context, user.height.toString(), 'Height'),
          buildDivider(),
          buildButton(context, findBMI(user.height, user.weight), 'BMI'),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(color: Colors.blue,),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
