import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';
import '../../../../cubit/history/history_cubit.dart';
import 'states/empty.dart';
import 'states/error.dart';
import 'states/loaded.dart';
import 'states/loading.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    _getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getHistory,
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, walletState) {
          if (walletState is WalletLoaded) {
            return BlocBuilder<HistoryCubit, HistoryState>(
              builder: (context, state) {
                if (state is HistoryLoaded) {
                  return Loaded(history: state.history);
                } else if (state is HistoryEmpty) {
                  return Empty();
                } else if (state is HistoryFailure) {
                  return Error(message: state.message);
                } else {
                  return Loading();
                }
              },
            );
          }

          // Not login
          // TODO: Not login UI
          return SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> _getHistory() async {
    if (context.read<WalletCubit>().state is WalletLoaded) {
      await context.read<HistoryCubit>().getListHistory(
            address: (context.read<WalletCubit>().state as WalletLoaded)
                .wallet
                .privateKey
                .address
                .hex,
          );
    }
  }
}
