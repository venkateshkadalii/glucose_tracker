import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final Function() onPressed;
  final String buttonText;
  final Color backgroundColor;
  final TextStyle? textStyle;

  const AppTextButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    required this.backgroundColor,
    this.textStyle = const TextStyle(color: Colors.white),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: textStyle,
        ),
      ),
    );
  }
}
