import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String? message;

  const Error({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
