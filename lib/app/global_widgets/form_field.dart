import 'package:flutter/material.dart';

class FormField extends StatefulWidget {
  final Function(FormFieldState)? builder;

  FormField({
    Key? key,
    this.builder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormFieldState();
}

class FormFieldState extends State<FormField> {
  didChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return widget.builder!(this);
  }
}
