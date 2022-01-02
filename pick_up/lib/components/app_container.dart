// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pick_up/components/auth/auth_button.dart';
import 'package:pick_up/components/auth/auth_input.dart';

class AppContainer extends StatefulWidget {
  final Function(String) emailChanged;
  final Function(String) passwordChanged;
  final String title;
  final String description;
  final Function() forgotPassPressed;
  final bool forgotPassSeen;
  final String buttonText;
  final Function buttonPressed;
  final Color buttonColor;
  final Color buttonTextColor;
  final double buttonRadius;
  final double buttonMargin;
  final String emailInputPlaceholder;
  final String passInputPlaceholder;
  final String bottomMessage;
  final String bottomActionText;
  final Function() bottomActionPressed;
  final bool isAuthScreen;
  final String err;
  //final dynamic formkey;

  const AppContainer(
      {Key? key,
      required this.emailChanged,
      required this.passwordChanged,
      required this.title,
      required this.description,
      required this.forgotPassPressed,
      required this.forgotPassSeen,
      required this.buttonText,
      required this.buttonPressed,
      required this.buttonColor,
      required this.buttonTextColor,
      required this.buttonRadius,
      required this.buttonMargin,
      required this.emailInputPlaceholder,
      required this.passInputPlaceholder,
      required this.bottomMessage,
      required this.bottomActionText,
      required this.bottomActionPressed,
      required this.isAuthScreen,
      required this.err})
      : super(key: key);

  @override
  _AppContainerState createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  final _formKey = GlobalKey<FormState>();

  checkKey() async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      return await widget.buttonPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: size.height),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: size.width * 0.5,
                        height: size.width * 0.4,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 34,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: widget.isAuthScreen
                            ? Column(children: [
                                AuthInput(
                                  formKey: _formKey,
                                  changed: widget.emailChanged,
                                  placeholder: widget.emailInputPlaceholder,
                                  // formValidator: (val) =>
                                  //     val!.isEmpty ? 'Enter an email' : null,
                                ),
                                AuthInput(
                                  formKey: _formKey,
                                  changed: widget.passwordChanged,
                                  placeholder: widget.passInputPlaceholder,
                                  isPassword: true,
                                  // formValidator: (val) => val!.length < 6
                                  //     ? 'Enter a password 6+ chars long'
                                  //     : null,
                                )
                              ])
                            : AuthInput(
                                formKey: _formKey,
                                changed: widget.emailChanged,
                                placeholder: widget.emailInputPlaceholder,
                                isPassword: false,
                                //   formValidator: (val) =>
                                //       val!.isEmpty ? 'Enter an email' : null,
                              ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.err,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (widget.forgotPassSeen == false)
                            SizedBox.shrink()
                          else
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: TextButton(
                                onPressed: widget.forgotPassPressed,
                                child: Text(
                                  'Forgot password?',
                                ),
                              ),
                            ),
                        ],
                      ),
                      Spacer(),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              AuthButton(
                                  text: widget.buttonText,
                                  press: checkKey,
                                  color: widget.buttonColor,
                                  textColor: widget.buttonTextColor,
                                  radius: widget.buttonRadius,
                                  margin: widget.buttonMargin),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(widget.bottomMessage),
                                  TextButton(
                                      onPressed: widget.bottomActionPressed,
                                      child: Text(widget.bottomActionText)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
