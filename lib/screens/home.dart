import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  String sayHello() {
    DateTime date = new DateTime.now();
    int hour = date.hour;
    if (hour < 12) {
      return "Good Morning ";
    } else if (hour < 18) {
      return "Good Afternoon";
    }
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Text(sayHello(), textDirection: TextDirection.rtl),
      ),
    );
  }
}
