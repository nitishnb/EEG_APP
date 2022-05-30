import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightBlue[200],
        child: Center(
          child: SpinKitChasingDots(
            size: 150.0, color: Colors.blue.shade900,
          ),
        )
    );
  }
}