// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AuthInput extends StatefulWidget {
  final Function(String) changed;
  final String placeholder;
  final bool? isPassword;
  final dynamic formKey;
  //final String? Function(String?) formValidator;

  const AuthInput({
    Key? key,
    required this.changed,
    this.placeholder = '',
    this.isPassword,
    this.formKey,
    //required this.formValidator
  }) : super(key: key);

  @override
  _AuthInputState createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.isPassword == true
        ? Column(children: [
            SizedBox(
                width: size.width * 0.9,
                child: TextFormField(
                  validator: (val) => val == null || val.length < 6
                      ? 'Enter a password 6+ chars long'
                      : null,
                  obscureText: true,
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
          ])
        : Column(children: [
            SizedBox(
                width: size.width * 0.9,
                child: TextFormField(
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Enter an email' : null,
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
