import 'package:crowdfunding/presentation/screens/main/pages/donation_last/donation_last_page.dart';
import 'package:flutter/material.dart';

import '../../presentation/screens/main/pages/donation/donation_page.dart';
import '../../presentation/screens/main/pages/history/history_page.dart';
import '../../presentation/screens/main/pages/my_campaign/my_campaign_screen.dart';
import '../../presentation/screens/main/pages/profile/profile_page.dart';

class TabModel {
  int id;
  String label;
  IconData iconData;
  Widget widget;

  TabModel({
    required this.id,
    required this.label,
    required this.iconData,
    required this.widget,
  });
}

final List<TabModel> mockListTabModel = [
  TabModel(id: 1, label: "Donasi", iconData: Icons.volunteer_activism, widget: DonationLastPage()),
  TabModel(id: 2, label: "Campaign Saya", iconData: Icons.campaign, widget: MyCampaignPage()),
  TabModel(id: 3, label: "Riawayat", iconData: Icons.history, widget: HistoryPage()),
  TabModel(id: 4, label: "Akun", iconData: Icons.person, widget: ProfilePage()),
];
