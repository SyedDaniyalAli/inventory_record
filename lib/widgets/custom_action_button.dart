import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String btnText;
  final IconData icon;

  CustomActionButton(
      {@required this.onPressed, @required this.btnText, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon),
            if (icon != null)
              SizedBox(
                width: 10,
              ),
            Text(
              btnText,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      shape: const StadiumBorder(),
      onPressed: onPressed,
    );
  }
}
