import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../service_locator.dart';
import '../../../../../../../shared/config/keys_config.dart';
import '../../../../../../../shared/config/urls_config.dart';
import '../../../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';
import '../../../../../../cubit/cubits.dart';
import 'states/loaded.dart';
import 'states/loading.dart';

class AllCampaignsWidget extends StatelessWidget {
  const AllCampaignsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetWithDefaultHorizontalPadding(
      child: BlocConsumer<CrowdfundingDeployedContractCubit,
          CrowdfundingDeployedContractState>(
        listener: (context, state) {
          if (state is CrowdfundingDeployedContractLoaded) {
            context.read<GetAllAddressCampaignsCubit>().getAllAddressCampaigns(
                  deployedContract: state.deployedContract,
                  web3Client: Web3Client(
                    UrlsConfig.alchemyRinkbey + KeysConfig.alchemyPrivateKey,
                    sl<Client>(),
                  ),
                );
          }
        },
        builder: (context, state) {
          if (state is CrowdfundingDeployedContractLoaded) {
            return BlocBuilder<GetAllAddressCampaignsCubit,
                GetAllAddressCampaignsState>(
              builder: (context, state) {
                if (state is GetAllAddressCampaignsLoaded) {
                  return Loaded();
                } else if (state is GetAllAddressCampaignsLoadingFailure) {
                  return SizedBox();
                } else {
                  return SizedBox();
                }
              },
            );
          } else if (state is CrowdfundingDeployedContractLoadingFailure) {
            return SizedBox();
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
