import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../../../service_locator.dart';
import '../../../../../../../../../shared/config/keys_config.dart';
import '../../../../../../../../../shared/config/urls_config.dart';
import '../../../../../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';
import '../../../../../../cubit/account_balance/account_balance_cubit.dart';
import 'states/error.dart';
import 'states/loaded.dart';
import 'states/loading.dart';

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({Key? key}) : super(key: key);

  @override
  _BalanceWidgetState createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  @override
  void initState() {
    super.initState();
    _getBalance();
  }

  void _getBalance() {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BlocBuilder<AccountBalanceCubit, AccountBalanceState>(
        builder: (context, state) {
          if (state is AccountBalanceLoaded) {
            return Loaded(
              etherAmount: state.balance,
            );
          } else if (state is AccountBalanceLoadingFailure) {
            return Error(
              message: state.message,
            );
          } else if (state is AccountBalanceLoading) {
            return Loading();
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
