import 'package:crowdfunding/presentation/screens/auth/widgets/import_wallet.dart';
import 'package:crowdfunding/presentation/screens/auth/widgets/login_body.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImportWallet(),
    );
  }
}