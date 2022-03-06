import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/cubits.dart';
import 'widgets/detail_amount_card.dart';

class DetailAmountWidget extends StatelessWidget {
  final int? donationAmount;

  const DetailAmountWidget({
    Key? key,
    required this.donationAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailAmountCard(
          title: "Donation Amount",
          value: donationAmount,
        ),
        const SizedBox(
          height: 10,
        ),
        DetailAmountCard(
          title: "Fee (Transaction Speed)",
          value: context.read<SelectedTransactionSpeedCubit>().state.selectedTransactionSpeed?.basePrice,
        ),
        const Divider(
          height: 15,
        ),
        DetailAmountCard(
          title: "Total",
          isBold: true,
          value: donationAmount,
        ),
      ],
    );
  }
}
