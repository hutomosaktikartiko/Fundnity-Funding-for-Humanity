import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../service_locator.dart';
import '../../../../../../../data/models/campaign_firestore_model.dart';
import '../../../../../../../data/models/campaign_model.dart';
import '../../../../../../cubit/my_campaigns/my_campaigns_cubit.dart';
import 'states/error.dart';
import 'states/loaded.dart';
import 'states/loading.dart';

class MyCampaignWidget extends StatefulWidget {
  const MyCampaignWidget({
    Key? key,
    required this.campaignFirestore,
    required this.campaigns,
  }) : super(key: key);

  final CampaignFirestoreModel? campaignFirestore;
  final List<CampaignModel> campaigns;

  @override
  State<MyCampaignWidget> createState() => _MyCampaignWidgetState();
}

class _MyCampaignWidgetState extends State<MyCampaignWidget> {
  MyCampaignsCubit myCampaignsCubit = sl<MyCampaignsCubit>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<CampaignModel?> _init() async {
    final CampaignModel? campaign = await context
        .read<MyCampaignsCubit>()
        .getMyCampaign(
          campaigns: widget.campaigns,
          campaignFirestore: widget.campaignFirestore,
        );

    return campaign;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CampaignModel?>(
      future: _init(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Loaded(
            campaign: snapshot.data,
          );
        } else if (snapshot.hasError) {
          return Error();
        }

        return Loading();
      },
    );
  }
}
