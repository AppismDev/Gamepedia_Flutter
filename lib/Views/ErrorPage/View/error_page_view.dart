import 'package:flutter/material.dart';

class ErrorPageView extends StatelessWidget {
  const ErrorPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Error !!!"
        ),
      ),
    );
  }
}
