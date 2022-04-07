import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/gas_model.dart';
import '../../../../../cubit/selected_transaction_speed/selected_transaction_speed_cubit.dart';
import '../widgets/transaction_speed_card.dart';

class Loaded extends StatelessWidget {
  const Loaded({
    Key? key,
    required this.listGas,
  }) : super(key: key);

  final List<GasModel?> listGas;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedTransactionSpeedCubit,
        SelectedTransactionSpeedState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listGas
              .asMap()
              .map(
                (key, value) => MapEntry(
                  key,
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          (key == listGas.length - 1) ? 0 : 10,
                    ),
                    child: GestureDetector(
                      onTap: () => _onSelectTransactionSpeed(
                        gas: value,
                        context: context,
                      ),
                      child: TransactionSpeedCard(
                        isActive: (value?.title == state.gas?.title),
                        gas: value,
                      ),
                    ),
                  ),
                ),
              )
              .values
              .toList(),
        );
      },
    );
  }

  void _onSelectTransactionSpeed({
    required GasModel? gas,
    required BuildContext context,
  }) {
    context
        .read<SelectedTransactionSpeedCubit>()
        .setSelectedTransactionSpeed(gas: gas);
  }
}
