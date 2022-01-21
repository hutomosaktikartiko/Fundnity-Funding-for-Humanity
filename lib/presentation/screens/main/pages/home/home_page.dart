import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/config/keys_config.dart';
import '../../../../../core/config/size_config.dart';
import '../../../../../core/config/urls_config.dart';
import '../../../../../injection_container.dart';
import '../../../../cubit/cubits.dart';
import 'state/loaded.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocConsumer<CampaignFactoryDeployedContractCubit,
          CampaignFactoryDeployedContractState>(
        listener: (context, state) {
          if (state is CampaignFactoryDeployedContractLoaded) {
            context.read<GetAllAddressCampaignsCubit>().getAllAddressCampaigns(
                  deployedContract: state.deployedContract,
                  web3Client: Web3Client(
                      UrlsConfig.infuraRinkbeyProvider +
                          KeysConfig.infuraPrivateKey,
                      sl<Client>()),
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
