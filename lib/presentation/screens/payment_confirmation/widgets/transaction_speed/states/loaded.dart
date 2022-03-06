import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/mock_transaction_speed.dart';
import '../../../../../cubit/cubits.dart';
import '../widgets/transaction_speed_card.dart';

class Loaded extends StatefulWidget {
  const Loaded({
    Key? key,
    required this.transactionSpeeds,
  }) : super(key: key);

  final List<MockTransactionSpeed?> transactionSpeeds;

  @override
  _LoadedState createState() => _LoadedState();
}

class _LoadedState extends State<Loaded> {
  @override
  void initState() {
    super.initState();
    context
        .read<SelectedTransactionSpeedCubit>()
        .setSelectedTransactionSpeed(widget.transactionSpeeds.first);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedTransactionSpeedCubit,
        SelectedTransactionSpeedState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.transactionSpeeds
              .asMap()
              .map(
                (key, value) => MapEntry(
                  key,
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          (key == widget.transactionSpeeds.length - 1) ? 0 : 10,
                    ),
                    child: GestureDetector(
                      onTap: () => _onSelectTransactionSpeed(
                        transactionSpeed: value,
                      ),
                      child: TransactionSpeedCard(
                        transactionSpeed: value,
                        isActive: (value == state.selectedTransactionSpeed),
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
    required MockTransactionSpeed? transactionSpeed,
  }) {
    context
        .read<SelectedTransactionSpeedCubit>()
        .setSelectedTransactionSpeed(transactionSpeed);
  }
}
