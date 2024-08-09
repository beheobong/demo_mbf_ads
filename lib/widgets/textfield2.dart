import 'package:flutter/material.dart';

class TextField2 extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType inputType;

  const TextField2({
    Key key,
    @required this.controller,
    @required this.labelText,
    this.inputType = TextInputType.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextField(
        keyboardType: inputType,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
