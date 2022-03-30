import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';
import '../widgets/balance_card.dart';

class Loaded extends StatelessWidget {
  const Loaded({
    Key? key,
    required this.etherAmount,
  }) : super(key: key);

  final EtherAmount etherAmount;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state is WalletLoaded) {
          return BalanceCard(
            address: state.wallet.privateKey.address,
            amount: etherAmount,
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
