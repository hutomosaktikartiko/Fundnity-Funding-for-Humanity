import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../shared/config/keys_config.dart';
import '../../../../../../../shared/config/urls_config.dart';
import '../../../../../../../service_locator.dart';
import '../../../../../../cubit/cubits.dart';
import 'states/loaded.dart';

class CampaignWidget extends StatefulWidget {
  const CampaignWidget({
    Key? key,
    required this.campaignAddress,
  }) : super(key: key);

  final String campaignAddress;

  @override
  _CampaignWidgetState createState() => _CampaignWidgetState();
}

class _CampaignWidgetState extends State<CampaignWidget> {
  CampaignDeployedContractCubit campaignDeployedContractCubit =
      sl<CampaignDeployedContractCubit>();

  GetCampaignCubit getCampaignCubit = sl<GetCampaignCubit>();

  @override
  void initState() {
    super.initState();
    campaignDeployedContractCubit.getDeployedContract(
        address: widget.campaignAddress);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => campaignDeployedContractCubit,
      child: BlocConsumer<CampaignDeployedContractCubit,
          CampaignDeployedContractState>(
        listener: (context, state) {
          if (state is CampaignDeployedContractLoaded) {
            getCampaignCubit.getCampaign(
              deployedContract: state.deployedContract,
              web3Client: Web3Client(
                  UrlsConfig.infuraRinkbeyProvider +
                      KeysConfig.infuraPrivateKey,
                  sl<Client>()),
            );
          }
        },
        builder: (context, state) {
          if (state is CampaignDeployedContractLoaded) {
            return BlocProvider(
              create: (context) => getCampaignCubit,
              child: BlocBuilder<GetCampaignCubit, GetCampaignState>(
                builder: (context, state) {
                  if (state is GetCampaignLoaded) {
                    return Loaded(
                      campaign: state.campaign,
                    );
                  } else if (state is GetCampaignLoadingFailure) {
                    return SizedBox();
                  } else {
                    return SizedBox();
                  }
                },
              ),
            );
          } else if (state is CampaignDeployedContractLoadingFailure) {
            return SizedBox();
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
