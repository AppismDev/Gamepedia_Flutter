import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Widgets/Bounce/bounce.dart';

class SettingsCard extends StatelessWidget {
  VoidCallback onPressed;
  Icon leading;
  Text title;

  SettingsCard({Key? key, required this.onPressed, required this.leading, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllLow,
      child: Bounce(
        scaleFactor: 0.5,
        duration: Duration(milliseconds: 100),
        onPressed: onPressed,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: leading,
            title: title,
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}
