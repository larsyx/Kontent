import 'package:flutter/material.dart';

class KontentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const KontentButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.normal, fontSize: 25),
        ),
      ),
    );
  }
}
