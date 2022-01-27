import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/cubits.dart';
import 'states/loaded.dart';

class DonationLastPage extends StatefulWidget {
  const DonationLastPage({Key? key}) : super(key: key);

  @override
  _DonationLastPageState createState() => _DonationLastPageState();
}

class _DonationLastPageState extends State<DonationLastPage> {
  @override
  void initState() {
    // context.read<Web3ClientCubit>().changeNetwork(url: UrlsConfig.infuraRinkbeyProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CampaignFactoryDeployedContractCubit,
          CampaignFactoryDeployedContractState>(
        listener: (context, state) {
          if (state is CampaignFactoryDeployedContractLoaded) {
            context.read<GetAllAddressCampaignsCubit>().getAllAddressCampaigns(
                  deployedContract: state.deployedContract,
                  web3Client: context.read<Web3ClientCubit>().state.web3client
                );
          }
        },
        builder: (context, state) {
          if (state is CampaignFactoryDeployedContractLoaded) {
            return BlocBuilder<GetAllAddressCampaignsCubit,
                GetAllAddressCampaignsState>(
              builder: (context, state) {
                if (state is GetAllAddressCampaignsLoaded) {
                  return Loaded(listAddresses: state.listAddressCampaigns);
                } else if (state is GetAllAddressCampaignsLoadingFailure) {
                  return SizedBox();
                } else {
                  return SizedBox();
                }
              },
            );
          } else if (state is CampaignFactoryDeployedContractLoadingFailure) {
            return SizedBox();
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
