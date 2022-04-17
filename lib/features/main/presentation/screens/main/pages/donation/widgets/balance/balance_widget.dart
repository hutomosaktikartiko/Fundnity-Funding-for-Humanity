import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';
import '../../../../../../cubit/account_balance/account_balance_cubit.dart';
import '../../../../../../cubit/web3client/web3client_cubit.dart';
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
          web3Client: context.read<Web3ClientCubit>().state.web3client,
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
