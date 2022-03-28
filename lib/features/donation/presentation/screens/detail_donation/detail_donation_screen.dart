import 'package:flutter/material.dart';

import 'states/loaded.dart';

class DetailDonationScreen extends StatelessWidget {
  const DetailDonationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Loaded(),
      ),
    );
  }
}
