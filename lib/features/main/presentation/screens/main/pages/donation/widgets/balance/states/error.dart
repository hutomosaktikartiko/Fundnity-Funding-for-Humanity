import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../../../../service_locator.dart';
import '../../../../../../../../../../shared/config/keys_config.dart';
import '../../../../../../../../../../shared/config/urls_config.dart';
import '../../../../../../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';
import '../../../../../../../cubit/account_balance/account_balance_cubit.dart';
import '../widgets/balance_card.dart';

class Error extends StatelessWidget {
  const Error({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onRefresh(context),
      child: BalanceCard(
        isDisable: true,
        errorMessage: message,
      ),
    );
  }

  void _onRefresh(BuildContext context) {
    context.read<AccountBalanceCubit>().getBalance(
          address: (context.read<WalletCubit>().state as WalletLoaded)
              .wallet
              .privateKey
              .address,
          web3client: Web3Client(
              UrlsConfig.infuraRinkbeyProvider +
                  KeysConfig.infuraEthereumProjectId,
              sl<Client>()),
        );
  }
}
