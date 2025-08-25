import 'package:flutter/material.dart';

class WideButton extends StatefulWidget {
  final Icon? icon;
  final Text label;
  final void Function()? function;
  final Color color;
  const WideButton({
    this.icon,
    required this.label,
    required this.function,
    this.color = Colors.blue,
    super.key,
  });

  @override
  State<WideButton> createState() => _WideButtonState();
}

class _WideButtonState extends State<WideButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: widget.color,
          elevation: 1,
        ),
        onPressed: widget.function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ?widget.icon,
            ?widget.icon != null ? SizedBox(width: 5) : null,
            widget.label,
          ],
        ),
      ),
    );
  }
}
/*
TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
*/