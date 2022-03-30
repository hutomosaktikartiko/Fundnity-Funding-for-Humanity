import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../../../shared/extension/string_parsing.dart';
import '../../../../../../../../../../shared/widgets/custom_box_shadow.dart';
import '../../../../../../../../../../shared/widgets/disable_layer.dart';
import '../../../../../../../../../../shared/widgets/widget_sized.dart';

class BalanceCard extends StatefulWidget {
  const BalanceCard({
    Key? key,
    this.isDisable = false,
    this.address,
    this.amount,
    this.errorMessage,
  }) : super(key: key);

  final bool isDisable;
  final EthereumAddress? address;
  final EtherAmount? amount;
  final String? errorMessage;

  @override
  _BalanceCardState createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  Size? size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WidgetSize(
          onChange: (Size newSize) => setState(() => size = newSize),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: UniversalColor.green4,
              boxShadow: [
                CustomBoxShadow.defaultBoxShadow(),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.address ?? ''}".walletAddressSplit(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${widget.amount?.getInEther ?? 0} ETH",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Material(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () => _openAddBalanceBottomSheet(context),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: Text(
                        "ADD BALANCE",
                        style: CustomTextStyle.green4TextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        DisabledLayer(
          disabled: widget.isDisable,
          borderRadius: 12,
          height: size?.height,
          message: widget.errorMessage,
          width: size?.width,
          layerColor: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }

  void _openAddBalanceBottomSheet(BuildContext context) {
    // TODO => Open Add Balance BottomSheet
  }
}
