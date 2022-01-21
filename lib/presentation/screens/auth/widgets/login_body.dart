import 'dart:io';

import 'package:crowdfunding/presentation/widgets/button/custom_button_label.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({ Key? key }) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {

  TextEditingController passwordController = TextEditingController();
  File? walletFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButtonLabel(label: "Import Json File", onTap: (){}),
      ],
    );
  }
}