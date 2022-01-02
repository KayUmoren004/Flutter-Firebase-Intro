// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppInput extends StatefulWidget {
  final Function(String) changed;
  final String placeholder;
  final bool? isPassword;
  final dynamic formKey;
  final String? initialValue;
  //final String? Function(String?) formValidator;

  const AppInput(
      {Key? key,
      required this.changed,
      this.placeholder = '',
      this.isPassword,
      this.formKey,
      this.initialValue
      //required this.formValidator
      })
      : super(key: key);

  @override
  _AppInputState createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      SizedBox(
          width: size.width * 0.9,
          child: TextFormField(
            initialValue: widget.initialValue,
            validator: (val) =>
                val == null || val.isEmpty ? 'Enter a name' : null,
            onChanged: widget.changed,
            decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          )),
      SizedBox(
        height: 10,
      ),
    ]);
  }
}
