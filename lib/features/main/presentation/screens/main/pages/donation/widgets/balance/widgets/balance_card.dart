import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ndialog/ndialog.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../../../shared/extension/big_int_parsing.dart';
import '../../../../../../../../../../shared/extension/string_parsing.dart';
import '../../../../../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../../../../../../shared/widgets/custom_box_shadow.dart';
import '../../../../../../../../../../shared/widgets/custom_dialog.dart';
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
                Expanded(
                    child: Column(
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
                      "${widget.amount?.getInWei.etherInWeiToEther().toStringAsFixed(5)} ETH",
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
                const SizedBox(
                  width: 10,
                ),
                Material(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () => _openAddBalanceDialog(context),
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

  void _openAddBalanceDialog(BuildContext context) {
    NAlertDialog(
      dialogStyle: DialogStyle(
        contentPadding: EdgeInsets.all(24),
        borderRadius: BorderRadius.circular(6),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "How to get rinkeby balance?",
            style: CustomTextStyle.gray2TextStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "copy your address and go to rinkeby faucet like https://faucets.chain.link/rinkeby to get your rinkeby balance",
            textAlign: TextAlign.center,
            style: CustomTextStyle.gray2TextStyle.copyWith(
              fontSize: 13,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: UniversalColor.gray6,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    widget.address.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.gray2TextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () => _copyAddress(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: UniversalColor.gray6,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.copy,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButtonLabel(
            label: "Copy",
            fontSize: 12,
            borderRadius: 6,
            backgroundColor: UniversalColor.green4,
            onTap: () => _copyAddress(context),
          ),
        ],
      ),
    ).show(context);
  }

  void _copyAddress(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.address?.toString()));
    CustomDialog.showToast(
      context: context,
      message: "Address copied to clipboard",
      backgroundColor: UniversalColor.green4,
    );
    ScreenNavigator.closeScreen(context);
  }
}
