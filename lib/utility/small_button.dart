import 'package:flutter/material.dart';

class SmallButton extends StatefulWidget {
  const SmallButton({super.key, this.text, this.function, this.icon});

  final text;
  final function;
  final icon;

  @override
  State<SmallButton> createState() => _SmallButtonState();
}

class _SmallButtonState extends State<SmallButton> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
