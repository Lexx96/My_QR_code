import 'package:flutter/material.dart';

/// Виджет вывода кнопки
class ElevatedButtonWidget extends StatelessWidget {
  final Function onPressed;
  final Color backgroundColor;
  final Widget child;

  const ElevatedButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.backgroundColor,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          backgroundColor,
        ),
      ),
      child: child,
    );
  }
}
