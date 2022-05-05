import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  const Error({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
