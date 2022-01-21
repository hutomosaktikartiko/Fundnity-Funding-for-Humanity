import 'package:flutter/material.dart';

import '../../../core/utils/preferences.dart';
import '../../../injection_container.dart';
import 'widgets/bottom_widget.dart';
import 'widgets/page_view_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController(initialPage: 0);

  void initState() {
    super.initState();
    // Set new user to [false]
    sl<Preferences>().isNewUser = false;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageViewWidget(pageController: pageController),
          BottomWidget(pageController: pageController),
        ],
      ),
    );
  }
}
