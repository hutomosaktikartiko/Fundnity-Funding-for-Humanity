import 'package:flutter/material.dart';

import '../../presentation/screens/main/pages/donation/donation_page.dart';
import '../../presentation/screens/main/pages/history/history_page.dart';
import '../../presentation/screens/main/pages/my_campaign/my_campaign_page.dart';
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

final List<TabModel> mockListTabsMain = [
  TabModel(id: 1, label: "Donation", iconData: Icons.volunteer_activism, widget: DonationPage()),
  TabModel(id: 2, label: "My Campaign", iconData: Icons.campaign, widget: MyCampaignPage()),
  TabModel(id: 3, label: "History", iconData: Icons.history, widget: HistoryPage()),
  TabModel(id: 4, label: "Account", iconData: Icons.person, widget: ProfilePage()),
];

final List<TabModel> mockListTabsHistoryModel = [
  TabModel(id: 1, label: "My Donation", iconData: Icons.volunteer_activism, widget: DonationPage()),
  TabModel(id: 2, label: "Create Campaign", iconData: Icons.campaign, widget: MyCampaignPage()),
];
