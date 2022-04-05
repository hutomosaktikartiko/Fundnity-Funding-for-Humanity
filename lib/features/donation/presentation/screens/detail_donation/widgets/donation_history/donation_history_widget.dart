import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../service_locator.dart';
import '../../../../../../../shared/config/keys_config.dart';
import '../../../../../../../shared/config/size_config.dart';
import '../../../../../../../shared/config/urls_config.dart';
import '../../../../cubit/contributor/contributor_cubit.dart';
import 'states/empty.dart';
import 'states/error.dart';
import 'states/loaded.dart';
import 'states/loading.dart';
import 'widgets/donation_history_header.dart';

class DonationHistoryWidget extends StatefulWidget {
  final EthereumAddress? address;

  const DonationHistoryWidget({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  _DonationHistoryWidgetState createState() => _DonationHistoryWidgetState();
}

class _DonationHistoryWidgetState extends State<DonationHistoryWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ContributorCubit>().getContributors(
          address: widget.address,
          web3Client: Web3Client(
              UrlsConfig.infuraRinkbeyProvider +
                  KeysConfig.infuraEthereumProjectId,
              sl<Client>()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultMargin + 5,
        horizontal: SizeConfig.defaultMargin,
      ),
      color: Colors.white,
      child: BlocBuilder<ContributorCubit, ContributorState>(
        builder: (context, state) {
          if (state is ContributorLoaded) {
            return DonationHistoryHeader(
              total: state.contributors.length,
              child: Loaded(
                contributors: state.contributors,
              ),
            );
          } else if (state is ContributorEmpty) {
            return DonationHistoryHeader(
              total: 0,
              child: Empty(),
            );
          } else if (state is ContributorLoadingFailure) {
            return DonationHistoryHeader(
              total: 0,
              child: Error(message: state.message),
            );
          } else {
            return DonationHistoryHeader(
              total: 0,
              child: Loading(),
            );
          }
        },
      ),
    );
  }
}
