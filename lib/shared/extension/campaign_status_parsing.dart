import 'package:flutter/material.dart';

import '../../features/main/data/models/campaign_model.dart';
import '../config/custom_color.dart';

extension CampaignStatusParsing on CampaignStatus? {
  Color campaignStatusToStrongColor() {
    switch (this) {
      case CampaignStatus.Active:
        return UniversalColor.blue2;
      case CampaignStatus.Complete:
        return UniversalColor.green4;
      case CampaignStatus.Inactive:
        return UniversalColor.red;
      default:
        return UniversalColor.gray4;
    }
  }

  Color campaignStatusToBgColor() {
    switch (this) {
      case CampaignStatus.Active:
        return BackgroundColor.bgBlue;
      case CampaignStatus.Complete:
        return BackgroundColor.bgGreen;
      case CampaignStatus.Inactive:
        return BackgroundColor.bgRed;
      default:
        return BackgroundColor.bgGray;
    }
  }

  String campaignStatusToLabel() {
    switch (this) {
      case CampaignStatus.Active:
        return "Active";
      case CampaignStatus.Complete:
        return "Complete";
      case CampaignStatus.Inactive:
        return "Failed";
      case CampaignStatus.Draft:
        return "Draft";
      default:
        return "Pending";
    }
  }
}
