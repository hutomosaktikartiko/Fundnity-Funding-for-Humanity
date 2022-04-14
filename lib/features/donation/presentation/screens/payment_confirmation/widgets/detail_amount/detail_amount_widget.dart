import 'package:flutter/material.dart';

import '../../../../../../../shared/extension/big_int_parsing.dart';
import '../../../../../../../shared/extension/int_parsing.dart';
import '../../../../../data/models/gas_model.dart';
import 'widgets/detail_amount_card.dart';

class DetailAmountWidget extends StatelessWidget {
  final BigInt? donation;
  final GasModel? gas;

  const DetailAmountWidget({
    Key? key,
    required this.donation,
    required this.gas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailAmountCard(
          title: "Donation Amount",
          value: donation.gweiToEther().toString(),
        ),
        const SizedBox(
          height: 10,
        ),
        DetailAmountCard(
          title: "Fee (Transaction Speed)",
          value: (int.parse(gas?.gasPriceInGwei ?? "0") * 1500000).gweiToEther().toString()
        ),
        const Divider(
          height: 15,
        ),
        DetailAmountCard(
          title: "Total",
          isBold: true,
          value: (donation.gweiToEther() + (int.parse(gas?.gasPriceInGwei ?? "0") * 1500000).gweiToEther()).toString(),
        ),
      ],
    );
  }
}
