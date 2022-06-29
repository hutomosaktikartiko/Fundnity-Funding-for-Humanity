import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

import '../../shared/config/custom_color.dart';
import '../../shared/config/custom_text_style.dart';
import '../../shared/config/size_config.dart';
import '../../core/utils/screen_navigator.dart';
import 'button/custom_button_label.dart';

class CustomDialog {
  static Widget showCircularProgressIndicator({double? size = 30}) =>
      SizedBox(height: size, width: size, child: CircularProgressIndicator());

  static ProgressDialog showProgressDialog({
    required BuildContext context,
    required String message,
    String? title,
    bool? dismissable,
  }) {
    return ProgressDialog(
      context,
      message: Text(message),
      title: Text(title ?? "Loading..."),
      dismissable: dismissable ?? true,
    );
  }

  static CustomProgressDialog showCustomProgressDialog({required BuildContext context}) {
    return CustomProgressDialog(context);
  }

  static void showToast({
    required String? message,
    required BuildContext context,
    Color? backgroundColor,
    Color? textColor,
    IconData? iconData,
    Color? iconColor,
  }) {
    FToast fToast = FToast().init(context);
    fToast.showToast(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: backgroundColor ?? Colors.black,
        ),
        child: IntrinsicWidth(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              (iconData != null)
                  ? Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        iconData,
                        color: iconColor ?? Colors.white,
                      ),
                    )
                  : SizedBox.shrink(),
              Expanded(
                child: Text(
                  message ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor ?? Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static NAlertDialog alertDialogConfirmation({
    required BuildContext context,
    required Function() onConfirmation,
    required String buttonOkLabel,
    Function? onCancel,
    Function? onDismiss,
    Color? buttonOkBackgroundColor,
    Color? borderColor,
    Color? labelColor,
    String? label,
    IconData? icon,
    Color? iconColor,
    String? description,
    Color? descriptionColor,
    double? buttonWidth,
    bool? dismissable,
  }) {
    return NAlertDialog(
      dialogStyle: DialogStyle(
        contentPadding: EdgeInsets.all(24),
        borderRadius: BorderRadius.circular(6),
      ),
      dismissable: dismissable,
      onDismiss: onDismiss,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (icon != null) ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Icon(
                    icon,
                    size: 48,
                    color: iconColor,
                  ),
                ) : SizedBox.shrink(),
          (label != null)
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    label,
                    style: CustomTextStyle.green1TextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: labelColor ?? UniversalColor.gray3,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : SizedBox.shrink(),
          (description != null)
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    description,
                    style: CustomTextStyle.green1TextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: descriptionColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : SizedBox.shrink(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButtonLabel(
                width: buttonWidth ?? SizeConfig.screenWidth * 0.3,
                label: "Batal",
                fontSize: 12,
                borderRadius: 6,
                labelColor: UniversalColor.gray4,
                borderColor: Colors.white,
                backgroundColor: Colors.white,
                onTap: () {
                  if (onCancel != null) {
                    onCancel();
                  } else {
                    ScreenNavigator.closeScreen(context);
                  }
                }
              ),
              SizedBox(
                width: 10,
              ),
              CustomButtonLabel(
                width: buttonWidth ?? SizeConfig.screenWidth * 0.3,
                label: buttonOkLabel,
                fontSize: 12,
                borderRadius: 6,
                backgroundColor:
                    buttonOkBackgroundColor ?? UniversalColor.green4,
                borderColor: borderColor ?? Colors.transparent,
                onTap: onConfirmation,
              ),
            ],
          )
        ],
      ),
    );
  }

  static NAlertDialog alertDialogInfo({
    required BuildContext context,
    required String label,
    required Function() onTap,
    required String buttonLabel,
    Color? buttonBackgroundColor,
    Color? labelColor,
    IconData? icon,
    Color? iconColor,
    String? description,
  }) {
    return NAlertDialog(
      dialogStyle: DialogStyle(
        contentPadding: EdgeInsets.all(24),
        borderRadius: BorderRadius.circular(6),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (icon != null)
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Icon(
                    icon,
                    size: 48,
                    color: iconColor,
                  ),
                )
              : SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              label,
              style: CustomTextStyle.gray3TextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: labelColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          CustomButtonLabel(
            label: buttonLabel,
            fontSize: 12,
            borderRadius: 6,
            backgroundColor: buttonBackgroundColor ?? UniversalColor.green4,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
