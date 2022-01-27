import 'package:flutter/material.dart';

import '../../../data/models/tab_model.dart';
import '../../widgets/custom_box_shadow.dart';
import 'pages/donation/donation_page.dart';
import 'pages/favorite/favorite_page.dart';
import 'pages/history/history_page.dart';
import 'pages/profile/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: mockListTabModel[currentTab].widget,
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return Container(
      decoration:
          BoxDecoration(boxShadow: [CustomBoxShadow.defaultBoxShadow()]),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        child: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: _moveTab,
          items: mockListTabModel
              .map(
                (tab) => BottomNavigationBarItem(
                  icon:
                     Padding(
                       padding: const EdgeInsets.only(bottom: 2),
                       child: Icon(tab.iconData),
                     ),
                  label: tab.label,
                ),
              )
              .toList(),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          iconSize: 18,
        ),
      ),
    );
  }

  void _moveTab(int index) => setState(() => currentTab = index);
}
